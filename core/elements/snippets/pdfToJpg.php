<?php
/**
 * Принимает параметр $src - путь к pdf.
 * Требует расширение Imagick.
 */

// TODO: напиши проверку, действительно ли pdf в $src?
// TODO: напиши рекурсивное создание папки для сохранения jpg.

if (!function_exists('mb_basename')) {
    function mb_basename($path) {
        if (preg_match('@^.*[\\\\/]([^\\\\/]+)$@s', $path, $matches)) {
            return $matches[1];
        } else if (preg_match('@^([^\\\\/]+)$@s', $path, $matches)) {
            return $matches[1];
        }
        return '';
    }
}

$src = $_SERVER['DOCUMENT_ROOT'] . $src;

// Проверяем, в src передан существующий файл или что-то другое?
if (!file_exists($src)) {
    $modx->log(MODX_LOG_LEVEL_ERROR, 'pdfToJpg: Presumably PDF File: '.$src.' does not exist');
    return '';
}

$basename = mb_basename($src);
// $basename = basename($src);
// $newname = hash('sha-256', $basename);

// Проверяем, вдруг скрипт для этого файла уже выполнялся
$resultSrc = '/assets/template/img/pdf-to-jpg/' . $basename . '.jpg';
$resultPath = $_SERVER['DOCUMENT_ROOT'] . $resultSrc;

if (file_exists($resultPath)) {
    return $resultSrc;
}

try {
    // $img = new Imagick($src);
    $img = new Imagick();
    $img->setResolution(150, 150);
    $img->readImage($src . '[0]');

    $img->setImageFormat('jpg');
    // Некоторые сертификаты почему-то получаются черными. Этот код исправляет данную проблему.
    $img->setImageCompressionQuality(85);
    // $img->mergeImageLayers(Imagick::LAYERMETHOD_FLATTEN);
    // $img->setImageAlphaChannel(Imagick::ALPHACHANNEL_REMOVE);

    $success = $img->writeImage($resultPath);
    $img->clear();
    $img->destroy();
    if ($success === true) {
        return $resultSrc;
    } else {
        $modx->log(MODX_LOG_LEVEL_ERROR, 'ImagickException: File: '.$src.' error sacing preview to '.$resultPath);
        return '';
    }
} catch (ImagickException $e) {
    $modx->log(MODX_LOG_LEVEL_ERROR, 'ImagickException: '. $e->getMessage() .'. File: '.$src);
    return '';
}
