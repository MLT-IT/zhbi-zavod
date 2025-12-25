<?php

/**
 * Конвертирует первую страницу PDF-файла в JPG.
 * Использует Imagick.
 * Работает с MODX и кастомным кэшированием.
 *
 * @param $src - путь к сертификату /assets/documents/files/xxx.pdf
 */

// === КОНФИГУРАЦИЯ ===
if (!defined('PDF_TO_JPG_OUT_PATH')) {
    define('PDF_TO_JPG_OUT_PATH', '/assets/documents/preview/' . $modx->context->key . '/');
}
if (!defined('PDF_RESOLUTION')) define('PDF_RESOLUTION', 150); // DPI
if (!defined('PDF_QUALITY')) define('PDF_QUALITY', 85);     // JPG качество

// === УТИЛИТЫ ===
if (!function_exists('is_valid_pdf')) {
    function is_valid_pdf($filePath)
    {
        if (!file_exists($filePath)) return false;
        $finfo = finfo_open(FILEINFO_MIME_TYPE);
        $mimeType = finfo_file($finfo, $filePath);
        finfo_close($finfo);
        return strtolower($mimeType) === 'application/pdf';
    }
}

if (!function_exists('ensure_directory_exists')) {
    function ensure_directory_exists($path)
    {
        if (!is_dir($path)) {
            mkdir($path, 0775, true);
        }
    }
}

// === ОСНОВНАЯ ЛОГИКА ===
if (!function_exists('imagick_create')) {
    function imagick_create($src)
    {
        global $modx;

        $basename = pathinfo($src, PATHINFO_FILENAME);
        $full_src = MODX_BASE_PATH . $src;
        $out_dir = MODX_BASE_PATH . PDF_TO_JPG_OUT_PATH;
        $resultPath = $out_dir . '/' . $basename . '.jpg';
        $resultSrc = PDF_TO_JPG_OUT_PATH . '/' . $basename . '.jpg';

        // Проверка на повторную генерацию
        if (file_exists($resultPath)) {
            return $resultSrc;
        }

        // Убедимся, что папка есть
        ensure_directory_exists($out_dir);

        try {
            $img = new Imagick();
            $img->setResolution(PDF_RESOLUTION, PDF_RESOLUTION);
            $img->readImage($full_src . '[0]');
            $img->setImageFormat('jpg');
            $img->setImageCompressionQuality(PDF_QUALITY);

            // ⚡ ресайз: максимум ширина 400px (высота масштабируется пропорционально)
            $img->resizeImage(400, 400, Imagick::FILTER_LANCZOS, 1, true);

            // Убираем чёрный фон и альфу
            $img->mergeImageLayers(Imagick::LAYERMETHOD_FLATTEN);
            $img->setImageAlphaChannel(Imagick::ALPHACHANNEL_REMOVE);

            $success = $img->writeImage($resultPath);
            $img->clear();
            $img->destroy();

            return $success ? $resultSrc : false;
        } catch (ImagickException $e) {
            $modx->log(MODX_LOG_LEVEL_ERROR, 'ImagickException: ' . $e->getMessage() . '. File: ' . $full_src);
            return false;
        }
    }
}

if (!function_exists('make_thumb')) {
    function make_thumb($src)
    {
        global $modx;

        // Папка кастомного кэша
        $customCacheDir = MODX_CORE_PATH . 'cache-custom/sertificates-preview/' . $modx->context->key . '/';
        ensure_directory_exists($customCacheDir);

        $cacheFile = $customCacheDir . md5($src) . '.cache';

        // Если есть кэш — возвращаем
        if (file_exists($cacheFile)) {
            return file_get_contents($cacheFile);
        }

        $full_src = MODX_BASE_PATH . $src;
        if (!file_exists($full_src)) {
            $modx->log(MODX_LOG_LEVEL_ERROR, 'make_thumb: File not found: ' . $full_src);
            return '';
        }

        $result = imagick_create($src);

        // Пишем в кэш
        if ($result) {
            file_put_contents($cacheFile, $result);
        }

        return $result ?: '';
    }
}

// === ВЫЗОВ ===
if (!is_valid_pdf(MODX_BASE_PATH . $src)) return $src;
return make_thumb($src) ?: '';
