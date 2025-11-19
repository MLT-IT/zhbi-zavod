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

if (!class_exists('BannerApi')) {
    class BannerApi
    {
        protected $api_url;
        protected $context_key;
        protected $project_key;
        protected $CURLOPT_CONNECTTIMEOUT = 5; // таймаут на подключение (сек.)
        protected $CURLOPT_TIMEOUT = 5; // общий таймаут запроса (сек.)

        public function __construct($context_key, $api_url, $project_key)
        {
            $this->api_url = $api_url;
            $this->context_key = $context_key;
            $this->project_key = $project_key;
        }

        // GET запрос на api
        public function get($resource_id = null, $resource_parent = null, $banner_position)
        {
            $params = "?context_key=$this->context_key&project_key=$this->project_key&position=$banner_position";

            if ($resource_id) $params .= "&id=$resource_id";
            if ($resource_parent) $params .= "&parent=$resource_parent";

            $ch = curl_init($this->api_url . $params);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

            curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $this->CURLOPT_CONNECTTIMEOUT);
            curl_setopt($ch, CURLOPT_TIMEOUT, $this->CURLOPT_TIMEOUT);

            $response = curl_exec($ch);
            curl_close($ch);

            return $response;
        }
    }
}

if (!class_exists('BannerUploader')) {
    class BannerUploader
    {
        protected $upload_dir;

        public function __construct($context_key)
        {
            $this->upload_dir = [
                'full' => MODX_BASE_PATH . "/assets/uploads/banners/$context_key/",
                'short' => "/assets/uploads/banners/$context_key/"
            ];
        }

        /**
         * Скачивает баннер
         * 
         * return {string} - Ссылка на скаченный баннер
         */
        public function upload($image_url): string
        {
            $file_name = basename(parse_url($image_url, PHP_URL_PATH));
            $upload_path = $this->upload_dir['full'] . $file_name;

            // Если файл уже загружен
            if (file_exists($upload_path)) return $this->upload_dir['short'] . $file_name;

            // Загружаем файл на наш сервер
            $image_data = file_get_contents($image_url);
            if ($image_data !== false) {
                file_put_contents($upload_path, $image_data);
                return $this->upload_dir['short'] . $file_name;
            }

            return "";
        }

        // Создает папку для баннеров если она не создана
        public function createFolder()
        {
            if (!is_dir($this->upload_dir['full'])) {
                mkdir($this->upload_dir['full'], 0777, true);
            }
        }
    }
}

if (!class_exists('BannerCache')) {
    class BannerCache
    {
        protected $modx;
        protected $key;

        public function __construct($modx, $context_key, $properties)
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

        public function set($value)
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
        public function removeIDFromProducts(&$properties, $resource_class_key)
        {
            if ($resource_class_key === 'msProduct')
                $properties['resource_id'] = null;
        }
    }
}

try {
    $bannerGuard = new BannerGuard();

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

    // 3 Проверка кэша
    $bannerCache = new BannerCache($modx, $main_data['context_key'], $properties);
    if (!isset($properties['no_cache'])) {
        if ($cache_data = $bannerCache->get()) return [
            'status' => true,
            'data' => $cache_data
        ];
    }

    // 4. Получение данных по api
    $bannerApi = new BannerApi($main_data['context_key'], $main_data['api_url'], $main_data['api_project_key']);
    $response = $bannerApi->get($properties['resource_id'], $properties['resource_parent'], $properties['banner_position']);
    $response = json_decode($response, true);
    if (isset($response['error']) || !$response['success']) return [
        'status' => false,
        'data' => $response
    ];
    $data = $response['data'];

    // 5. Создание папки для сохранения баннеров
    $bannerUpload = new BannerUploader($main_data['context_key']);
    $bannerUpload->createFolder();

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
    $modx->log(modX::LOG_LEVEL_ERROR, '[ApiBanner] ' . $e->getMessage());

    return [
        'status' => false,
        'data' => 'ApiBanner script error'
    ];
}
