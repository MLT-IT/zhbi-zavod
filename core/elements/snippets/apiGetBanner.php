<?php

/**
 * Скрипт получает по API данные по баннерам.
 *
 * [required] api_banners_project_key - Обязательная опция на сайте - Ключ проекта из API
 * [required] api_banners_url - Обязательная опция на сайте - Ссылка на API
 * 
 * @param required $banner_position - Позиция
 * @param optional $resource_id - ID ресурса
 * @param optional $resource_parent - resource_parent ресурса
 * @param optional [array] $resource_parents - Родители ресурса вверх по иерархии
 * @param optional $no_cache - Отключить кэширование
 */

if (!interface_exists('FolderControlInterface')) {
    interface FolderControlInterface
    {
        public function create(string $path): void;
    }
}

if (!interface_exists('BannerLoggerInterface')) {
    interface BannerLoggerInterface
    {
        public function error(string $message): void;
    }
}

if (!interface_exists('BannerCurlInterface')) {
    interface BannerCurlInterface
    {
        public function get(string $url): string;
    }
}

if (!class_exists('BannerCurl')) {
    class BannerCurl implements BannerCurlInterface
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
                throw new RuntimeException("Curl error: $error, HTTP code: $http_code, URL: $url");
            }

            return $response;
        }
    }
}

if (!class_exists('BannerApi')) {
    class BannerApi
    {
        protected string $api_url;
        protected string $context_key;
        protected string $project_key;
        protected BannerCurlInterface $curl;

        public function __construct(string $context_key, string $api_url, string $project_key, BannerCurlInterface $curl)
        {
            $this->api_url = $api_url;
            $this->context_key = $context_key;
            $this->project_key = $project_key;
            $this->curl = $curl;
        }

        public function get(string $banner_position, ?int $resource_id, ?int $resource_parent, ?array $resource_parents): string
        {
            $params = [
                'context_key' => $this->context_key,
                'project_key' => $this->project_key,
                'position' => $banner_position,
            ];

            if ($resource_id !== null) $params['id'] = $resource_id;
            if ($resource_parent !== null) $params['parent'] = $resource_parent;
            if ($resource_parents !== null) $params['parents'] = $resource_parents;

            $url = $this->api_url . '?' . http_build_query($params);

            return $this->curl->get($url);
        }
    }
}

if (!class_exists('BannerUploader')) {
    class BannerUploader
    {
        protected array $upload_dir;
        protected BannerCurlInterface $curl;

        public function __construct(
            string $banner_position,
            string $context_key,
            FolderControlInterface $folderControl,
            BannerCurlInterface $curl
        ) {
            $this->curl = $curl;

            $this->upload_dir = [
                'full' => MODX_BASE_PATH . "/assets/uploads/banners/$context_key/$banner_position/",
                'short' => "/assets/uploads/banners/$context_key/$banner_position/"
            ];

            $folderControl->create($this->upload_dir['full']);
        }

        public function upload(string $image_url): string
        {
            $file_name = basename(parse_url($image_url, PHP_URL_PATH));
            $upload_path = $this->upload_dir['full'] . $file_name;

            if (file_exists($upload_path)) {
                return $this->upload_dir['short'] . $file_name;
            }

            try {
                $image_data = $this->curl->get($image_url);
            } catch (Throwable $e) {
                throw new RuntimeException("Ошибка загрузки баннера: " . $e->getMessage());
            }

            if (@file_put_contents($upload_path, $image_data) !== false) {
                return $this->upload_dir['short'] . $file_name;
            }

            throw new RuntimeException("Ошибка сохранения файла $upload_path");
        }
    }
}


if (!class_exists('BannerFolderControl')) {
    class BannerFolderControl implements FolderControlInterface
    {
        public function create(string $path): void
        {
            if (!is_dir($path)) {
                mkdir($path, 0777, true);
            }
        }
    }
}

if (!class_exists('BannerCache')) {
    class BannerCache
    {
        protected string $path;

        public function __construct(string $context_key, array $properties, FolderControlInterface $folderControl)
        {
            $dir = MODX_BASE_PATH . "/core/cache-banners/$context_key/{$properties['banner_position']}/";

            $folderControl->create($dir);

            $this->path = $dir . md5(json_encode($properties)) . '.json';
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
if (!class_exists('BannerGuard')) {
    class BannerGuard
    {
        /**
         * Удаляет resource_id, если текущий ресурс — msProduct.
         */
        public function removeIDFromProducts(array &$properties, string $resource_class_key): void
        {
            if ($resource_class_key === 'msProduct') {
                $properties['resource_id'] = null;
            }
        }

        /**
         * Превращает строку "1,2,3" → [1, 2, 3]
         * Гарантирует, что resource_parents будет массивом.
         */
        public function parentsToArray(array &$properties): void
        {
            if (!isset($properties['resource_parents'])) return;

            $parents = $properties['resource_parents'];

            if (is_string($parents)) {
                $parents = explode(',', $parents);
            }

            if (is_array($parents)) {
                // trim всех элементов + удаление пустых
                $parents = array_filter(array_map('trim', $parents));
            } else {
                // Любая другая хрень — просто сделаем массивом
                $parents = [$parents];
            }

            $properties['resource_parents'] = array_values($parents);
        }
    }
}



if (!class_exists('ModxBannerLogger')) {
    class ModxBannerLogger implements BannerLoggerInterface
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

$modxBannerLogger = new ModxBannerLogger($modx);

try {
    $bannerCurl = new BannerCurl();
    $bannerGuard = new BannerGuard();
    $bannerFolderControl = new BannerFolderControl();

    // 1. Основные данные
    $main_data = [
        'context_key' => $modx->context->key,
        'api_url' => $modx->getOption('api_banners_url'),
        'api_project_key' => $modx->getOption('api_banners_project_key')
    ];
    if (!$main_data['api_project_key']) return [
        'status' => false,
        'data' => "Undefined site option - api_banners_project_key"
    ];

    // 2. Данные переданные в сниппете
    $properties = [
        'resource_id' => $scriptProperties['resource_id'],
        'resource_parent' => $scriptProperties['resource_parent'],
        'resource_parents' => $scriptProperties['resource_parents'],
        'banner_position' => $scriptProperties['banner_position'],
        'no_cache' => $scriptProperties['no_cache'],
    ];
    if (!$properties['banner_position']) return [
        'status' => false,
        'data' => "Undefined property - banner_position"
    ];
    $bannerGuard->removeIDFromProducts($properties, $modx->resource->class_key);
    $bannerGuard->parentsToArray($properties);

    // 3. Проверка кэша
    $bannerCache = new BannerCache(
        $main_data['context_key'],
        $properties,
        $bannerFolderControl
    );
    if (!isset($properties['no_cache'])) {
        if ($cache_data = $bannerCache->get()) return [
            'status' => true,
            'data' => $cache_data
        ];
    }

    // 4. Получение данных по api
    $bannerApi = new BannerApi(
        $main_data['context_key'],
        $main_data['api_url'],
        $main_data['api_project_key'],
        $bannerCurl
    );
    $response = $bannerApi->get(
        $properties['banner_position'],
        $properties['resource_id'],
        $properties['resource_parent'],
        $properties['resource_parents']
    );
    $response = json_decode($response, true);
    if (isset($response['error']) || !$response['success']) return [
        'status' => false,
        'data' => $response
    ];
    $banner_groups = $response['data']; // Массив полученных групп баннеров

    // 5. Создание папки для сохранения баннеров
    $bannerUpload = new BannerUploader(
        $properties['banner_position'],
        $main_data['context_key'],
        $bannerFolderControl,
        $bannerCurl
    );

    // 6. Формирование массива для вывода
    if (!empty($banner_groups)) {
        foreach ($banner_groups as &$banner_group) {
            foreach ($banner_group['banners_by_type'] as $type => &$banner) {
                if (!isset($banner['image_url'])) continue;

                // Сохранение баннера
                if ($upload_banner_url = $bannerUpload->upload($banner['image_url'])) {
                    $banner['image_url'] = $upload_banner_url;
                }
            }
        }
    }

    $bannerCache->set($banner_groups);

    return [
        'status' => true,
        'data' => $banner_groups
    ];
} catch (Throwable $e) {
    $modxBannerLogger->error($e->getMessage());

    return [
        'status' => false,
        'data' => 'ApiBanner script error'
    ];
}
