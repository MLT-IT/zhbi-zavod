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
 * @param optional $no_cache - Отключить кэширование
 */

if (!interface_exists('FolderControl')) {
    interface FolderControl
    {
        public function create(string $path): void;
    }
}

if (!interface_exists('BannerLogger')) {
    interface BannerLogger
    {
        public function log(string $message, int $level): void;
    }
}

if (!class_exists('BannerApi')) {
    class BannerApi
    {
        protected $api_url;
        protected $context_key;
        protected $project_key;
        protected $CURLOPT_CONNECTTIMEOUT = 5; // таймаут на подключение (сек.)
        protected $CURLOPT_TIMEOUT = 5; // общий таймаут запроса (сек.)

        public function __construct(string $context_key, string $api_url, string $project_key)
        {
            $this->api_url = $api_url;
            $this->context_key = $context_key;
            $this->project_key = $project_key;
        }

        // GET запрос на api
        public function get(string $banner_position, ?int $resource_id, ?int $resource_parent): string
        {
            $params = [
                'context_key' => $this->context_key,
                'project_key' => $this->project_key,
                'position'    => $banner_position,
            ];

            if ($resource_id !== null) {
                $params['id'] = $resource_id;
            }

            if ($resource_parent !== null) {
                $params['parent'] = $resource_parent;
            }

            $url = $this->api_url . '?' . http_build_query($params);

            $ch = curl_init($url);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $this->CURLOPT_CONNECTTIMEOUT);
            curl_setopt($ch, CURLOPT_TIMEOUT, $this->CURLOPT_TIMEOUT);

            $response = curl_exec($ch);
            curl_close($ch);

            return $response ?: '';
        }
    }
}

if (!class_exists('BannerUploader')) {
    class BannerUploader
    {
        protected $upload_dir;
        protected $bannerLogger;

        public function __construct(string $banner_position, string $context_key, FolderControl $folderControl, BannerLogger $bannerLogger)
        {
            $this->bannerLogger = $bannerLogger;

            $this->upload_dir = [
                'full' => MODX_BASE_PATH . "/assets/uploads/banners/$context_key/$banner_position/",
                'short' => "/assets/uploads/banners/$context_key/$banner_position/"
            ];

            $folderControl->create($this->upload_dir['full']);
        }

        /**
         * Скачивает баннер
         * 
         * return {string} - Ссылка на скаченный баннер
         */
        public function upload(string $image_url): string
        {
            $file_name = basename(parse_url($image_url, PHP_URL_PATH));
            $upload_path = $this->upload_dir['full'] . $file_name;

            // Если файл уже загружен
            if (file_exists($upload_path)) {
                return $this->upload_dir['short'] . $file_name;
            }

            // --- CURL загрузка файла ---
            $ch = curl_init($image_url);

            curl_setopt_array($ch, [
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_FOLLOWLOCATION => true,
                CURLOPT_CONNECTTIMEOUT => 5,
                CURLOPT_TIMEOUT => 10,
                CURLOPT_SSL_VERIFYPEER => false, // если API без SSL нормальной конфигурации
            ]);

            $image_data = curl_exec($ch);
            $http_code  = curl_getinfo($ch, CURLINFO_HTTP_CODE);
            $error      = curl_error($ch);

            curl_close($ch);

            // Проверка ошибок
            if ($image_data === false || $http_code !== 200) {
                $this->bannerLogger->log("Ошибка загрузки баннера $error");
                return "";
            }

            // --- Сохранение файла ---
            if (@file_put_contents($upload_path, $image_data) !== false) {
                return $this->upload_dir['short'] . $file_name;
            }

            return "";
        }
    }
}

if (!class_exists('BannerFolderControl')) {
    class BannerFolderControl implements FolderControl
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
        protected $modx;
        protected $key;

        public function __construct($modx, string $context_key, array $properties)
        {
            $this->modx = $modx;
            $this->key = "/banners/$context_key/" . md5(json_encode($properties));
        }

        public function get()
        {
            $cached = $this->modx->cacheManager->get($this->key);
            if ($cached) return $cached;
            return null;
        }

        public function set(array $value)
        {
            return $this->modx->cacheManager->set($this->key, $value);
        }
    }
}

// Класс для различных защит и проверок
if (!class_exists('BannerGuard')) {
    class BannerGuard
    {
        // Удаляет параметр ID если текущий ресурс товар. 
        // Сейчас кэш генерируется из $properties
        // И если передать ID товара, то будет много ненужных запросов на АПИ
        // Так как баннеры для товаров формируются по его parent 
        public function removeIDFromProducts(array &$properties, string $resource_class_key)
        {
            if ($resource_class_key === 'msProduct')
                $properties['resource_id'] = null;
        }
    }
}


if (!class_exists('ModxBannerLogger')) {
    class ModxBannerLogger implements BannerLogger
    {
        protected modX $modx;

        public function __construct(modX $modx)
        {
            $this->modx = $modx;
        }
        public function log(string $message, int $level = modX::LOG_LEVEL_ERROR): void
        {
            $this->modx->log($level, '[ApiBanner] ' . $message);
        }
    }
}

$modxBannerLogger = new ModxBannerLogger($modx);

try {
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
        'banner_position' => $scriptProperties['banner_position'],
        'no_cache' => $scriptProperties['no_cache'],
    ];
    if (!$properties['banner_position']) return [
        'status' => false,
        'data' => "Undefined property - banner_position"
    ];
    $bannerGuard->removeIDFromProducts($properties, $modx->resource->class_key);

    // 3. Проверка кэша
    $bannerCache = new BannerCache($modx, $main_data['context_key'], $properties);
    if (!isset($properties['no_cache'])) {
        if ($cache_data = $bannerCache->get()) return [
            'status' => true,
            'data' => $cache_data
        ];
    }

    // 4. Получение данных по api
    $bannerApi = new BannerApi($main_data['context_key'], $main_data['api_url'], $main_data['api_project_key']);
    $response = $bannerApi->get($properties['banner_position'], $properties['resource_id'], $properties['resource_parent']);
    $response = json_decode($response, true);
    if (isset($response['error']) || !$response['success']) return [
        'status' => false,
        'data' => $response
    ];
    $data = $response['data'];

    // 5. Создание папки для сохранения баннеров
    $bannerUpload = new BannerUploader($properties['banner_position'], $main_data['context_key'], $bannerFolderControl, $modxBannerLogger);

    // 6. Формирование массива для вывода
    if (isset($data['banners_by_type'])) {
        foreach ($data['banners_by_type'] as $type => &$banner) {
            if (!isset($banner['image_url'])) continue;

            // Сохранение баннера
            if ($upload_banner_url = $bannerUpload->upload($banner['image_url'])) {
                $banner['image_url'] = $upload_banner_url;
            }
        }
    }

    $bannerCache->set($data);

    return [
        'status' => true,
        'data' => $data
    ];
} catch (Throwable $e) {
    $modxBannerLogger->log($e->getMessage());

    return [
        'status' => false,
        'data' => 'ApiBanner script error'
    ];
}
