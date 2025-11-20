<?php

/**
 * Скрипт получает данные по баннерам через API.
 *
 * Обязательные опции сайта:
 *   - api_banners_project_key: Ключ проекта из API
 *   - api_banners_url: Ссылка на API
 *
 * Параметры скрипта:
 * @param string $position    Позиция баннера (обязательный)
 * @param int|null $id        ID ресурса (необязательный)
 * @param int|null $parent    Родитель ресурса (необязательный)
 * @param array|null $parents Массив родителей ресурса вверх по иерархии (необязательный)
 * @param bool|null $no_cache Отключить кэширование (необязательный)
 *
 * @return array Возвращает массив с результатом:
 *               - status: true/false
 *               - data: данные баннеров или информация об ошибке
 */

if (!interface_exists('BFolderControlInterface')) {
    interface BFolderControlInterface
    {
        public function create(string $path): void;
    }
}
if (!interface_exists('BLoggerInterface')) {
    interface BLoggerInterface
    {
        public function error(string $message): void;
    }
}
if (!interface_exists('BCurlInterface')) {
    interface BCurlInterface
    {
        public function get(string $url): string;
    }
}

if (!class_exists('BCurl')) {
    class BCurl implements BCurlInterface
    {
        protected int $connectTimeout = 5;
        protected int $timeout = 10;

        public function get(string $url): string
        {
            $ch = curl_init($url);

            curl_setopt_array($ch, [
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_FOLLOWLOCATION => true,
                CURLOPT_CONNECTTIMEOUT => $this->connectTimeout,
                CURLOPT_TIMEOUT => $this->timeout,
                CURLOPT_SSL_VERIFYPEER => false,
            ]);

            $response = curl_exec($ch);
            $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
            $error = curl_error($ch);

            curl_close($ch);

            if ($response === false || $http_code !== 200) {
                throw new Exception("Curl error: $error, HTTP code: $http_code, URL: $url");
            }

            return $response;
        }
    }
}

if (!class_exists('BApi')) {
    class BApi
    {
        protected string $api_url;
        protected BCurlInterface $curl;

        public function __construct($api_url, BCurlInterface $curl)
        {
            $this->api_url  = $api_url;
            $this->curl = $curl;
        }

        public function get(array $query_params): string
        {
            $params = $this->buildingQuery($query_params);
            $url = $this->api_url . '?' . $params;

            return $this->curl->get($url);
        }

        protected function buildingQuery(array $query_params): string
        {
            $params = [];

            foreach ($query_params as $param_key => $param_data) {
                if (!empty($param_data['required']) && empty($param_data['value'])) {
                    throw new Exception("[buildingQuery] Empty required param: $param_key");
                }

                if (!empty($param_data['value'])) {
                    $params[$param_key] = $param_data['value'];
                }
            }

            return http_build_query($params);
        }
    }
}

if (!class_exists('BUploader')) {
    class BUploader
    {
        protected array $upload_params;
        protected BCurlInterface $curl;

        public function __construct(
            $upload_params,
            BFolderControlInterface $folderControl,
            BCurlInterface $curl
        ) {
            $this->curl = $curl;

            $this->upload_params = $upload_params;

            $folderControl->create($this->upload_params['full']);
        }

        public function upload(string $image_url): string
        {
            $file_name = basename(parse_url($image_url, PHP_URL_PATH));
            $upload_path = $this->upload_params['full'] . $file_name;

            if (file_exists($upload_path)) {
                return $this->upload_params['short'] . $file_name;
            }

            try {
                $image_data = $this->curl->get($image_url);
            } catch (Throwable $e) {
                throw new Exception("Ошибка загрузки баннера: " . $e->getMessage());
            }

            if (@file_put_contents($upload_path, $image_data) !== false) {
                return $this->upload_params['short'] . $file_name;
            }

            throw new Exception("Ошибка сохранения файла $upload_path");
        }
    }
}


if (!class_exists('BFolderControl')) {
    class BFolderControl implements BFolderControlInterface
    {
        public function create(string $path): void
        {
            if (!is_dir($path)) {
                mkdir($path, 0777, true);
            }
        }
    }
}

if (!class_exists('BCache')) {
    class BCache
    {
        protected string $path;

        public function __construct($cache_params, BFolderControlInterface $folderControl)
        {
            $folderControl->create($cache_params['path']);

            $this->path = $cache_params['path'] . $cache_params['filename'];
        }

        public function get(): ?array
        {
            if (file_exists($this->path)) {
                $content = file_get_contents($this->path);
                $data = json_decode($content, true);
                if (json_last_error() === JSON_ERROR_NONE) {
                    return $data;
                }
            }
            return null;
        }

        public function set(array $value): bool
        {
            $json = json_encode($value, JSON_UNESCAPED_SLASHES);
            if ($json === false) return false;

            return file_put_contents($this->path, $json) !== false;
        }
    }
}


// Класс для различных защит и проверок
if (!class_exists('BGuard')) {
    class BGuard
    {
        // Удаляет resource_id, если текущий ресурс — msProduct.
        public function removeIDFromProducts(array &$query_params, string $class_key): void
        {
            if ($class_key === 'msProduct') unset($query_params['id']);
        }

        // Гарантирует, что необходимый элемент будет массивом.
        public function propertyToArray(&$value): void
        {
            if (!$value) return;

            if (is_string($value)) $value = explode(',', $value);

            if (is_array($value)) $value = array_filter(array_map('trim', $value));
            else $value = [$value];
        }
    }
}

if (!class_exists('BModxLogger')) {
    class BModxLogger implements BLoggerInterface
    {
        protected modX $modx;

        public function __construct(modX $modx)
        {
            $this->modx = $modx;
        }
        public function error(string $message): void
        {
            $this->modx->log(modX::LOG_LEVEL_ERROR, '[ApiBanner] ' . $message);
        }
    }
}


// 1. Инициализация переменных
$bModxLogger = new BModxLogger($modx);
// Ссылка для curl запросов
$api_url = $modx->getOption('api_banners_url');
// Параметры для curl запроса
$query_params = [
    'context_key' => [
        'value' => $modx->context->key,
        'required' => true,
    ],
    'project_key' => [
        'value' => $modx->getOption('api_banners_project_key'),
        'required' => true,
    ],
    'position' =>  [
        'value' => $scriptProperties['position'],
        'required' => true,
    ],
    'id' =>  [
        'value' => $scriptProperties['id'],
        'required' => false,
    ],
    'parent' =>  [
        'value' => $scriptProperties['parent'],
        'required' => false,
    ],
    'parents' =>  [
        'value' => $scriptProperties['parents'],
        'required' => false,
    ],
];
// Данные для кэширования
$cache_params = [
    'path' => MODX_BASE_PATH . "/core/cache-banners/{$modx->context->key}/{$scriptProperties['position']}/",
    'filename' => md5(json_encode($query_params)) . '.json'
];
// Пути для сохранения баннеров на сайте
$upload_params = [
    'full' => MODX_BASE_PATH . "/assets/uploads/banners/{$modx->context->key}/{$scriptProperties['position']}/",
    'short' => "/assets/uploads/banners/{$modx->context->key}/{$scriptProperties['position']}/"
];

try {
    // 2. Подключаем необходимые классы для работы
    $bCurl = new BCurl();
    $bGuard = new BGuard();
    $bFolderControl = new BFolderControl();

    // 3. Производим проверку и изменение параметров
    $bGuard->removeIDFromProducts($query_params, $modx->resource->class_key);
    $bGuard->propertyToArray($query_params['parents']['value']);

    // 4. Отдаем кэшированные данные если имеются
    $bCache = new BCache(
        $cache_params,
        $bFolderControl
    );
    $cache_data = $bCache->get();
    if ($cache_data && !isset($scriptProperties['no_cache'])) {
        return [
            'status' => true,
            'data' => $cache_data
        ];
    }

    // 5. Получение данных по api
    $bApi = new BApi(
        $api_url,
        $bCurl
    );
    $response = $bApi->get($query_params);
    $response = json_decode($response, true);
    if (isset($response['error']) || !$response['success']) return [
        'status' => false,
        'data' => $response
    ];
    $banner_groups = $response['data']; // Массив полученных групп баннеров

    // 6. Создание папки для сохранения баннеров
    $bUploader = new BUploader(
        $upload_params,
        $bFolderControl,
        $bCurl
    );

    // 7. Формирование массива для вывода
    if (!empty($banner_groups)) {
        foreach ($banner_groups as &$banner_group) {
            foreach ($banner_group['banners_by_type'] as $type => &$banner) {
                if (!isset($banner['image_url'])) continue;

                // Сохранение баннера
                if ($upload_banner_url = $bUploader->upload($banner['image_url'])) {
                    $banner['image_url'] = $upload_banner_url;
                }
            }
        }
    }

    $bCache->set($banner_groups);

    return [
        'status' => true,
        'data' => $banner_groups
    ];
} catch (Throwable $e) {
    $bModxLogger->error($e->getMessage());

    return [
        'status' => false,
        'data' => 'ApiBanner script error'
    ];
}
