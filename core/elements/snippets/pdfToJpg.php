<?php

/**
 * Принимает параметр $src - путь к pdf.
 * Требует расширение Imagick.
 * 
 */

// TODO: напиши проверку, действительно ли pdf в $src?
// TODO: напиши рекурсивное создание папки для сохранения jpg.

define('OUT_PATH', '/assets/template/img/pdf-to-jpg');


if (!function_exists('mb_basename')) {
  function mb_basename($path)
  {
    global $modx;
    if (preg_match('@^.*[\\\\/]([^\\\\/]+)$@s', $path, $matches)) {
      return $matches[1];
    } else if (preg_match('@^([^\\\\/]+)$@s', $path, $matches)) {
      return $matches[1];
    }
    return '';
  }
}

// не удалось подобрать качественные настройки, делает для битых файлов белую страницу, толку мало, оставил для стправки
// if (!function_exists('fix_pdf')) {
//   function fix_pdf($src)
//   {
//     global $modx;
//     // Step 1: Repair the PDF (temporarily) with Ghostscript
//     $pdf_name = mb_basename($src);
//     $full_src = $_SERVER['DOCUMENT_ROOT'] . $src;
//     $tempRepairedPdf = $_SERVER['DOCUMENT_ROOT'] . OUT_PATH . '/' . md5($pdf_name) . '_repaired.pdf';
//     $gsCommand = "gs -o " . escapeshellarg($tempRepairedPdf) . 
//     " -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress " .
//     "-dEmbedAllFonts=true -dSubsetFonts=true -dCompressFonts=true " .
//     "-dMaxSubsetPct=100 -dSubsetFonts=true -dDetectDuplicateImages=true " .
//     "-dDownsampleColorImages=false -dDownsampleGrayImages=false " .
//     "-dDownsampleMonoImages=false -dSAFER -dNOPAUSE -dBATCH " .
//     escapeshellarg($full_src);
//     exec($gsCommand, $output, $returnVar);

//     if ($returnVar !== 0) {
//       $modx->log(MODX_LOG_LEVEL_ERROR, 'fix_pdf: Error: Could not repair PDF. Ghostscript output:\n' . implode("\n", $output));
//       return false;
//     }
//     return $tempRepairedPdf;
//   }
// }

if (!function_exists('imagick_create')) {
  function imagick_create($src)
  {
    global $modx;
    try {
      $basename = mb_basename($src);
      $full_src = $_SERVER['DOCUMENT_ROOT'] . $src;

      // Проверяем, вдруг скрипт для этого файла уже выполнялся
      $resultSrc = OUT_PATH . '/' . $basename . '.jpg';
      $resultPath = $_SERVER['DOCUMENT_ROOT'] . $resultSrc;

      if (file_exists($resultPath)) {
        return $resultSrc;
      }
      // if ($fixedSrc = fix_pdf($src)) { 
      //   $full_src = $fixedSrc;
      // }
      $img = new Imagick();
      $img->setResolution(150, 150);
      $img->readImage($full_src . '[0]');

      $img->setImageFormat('jpg');
      $img->setImageCompressionQuality(85);

      $success = $img->writeImage($resultPath);
      $img->clear();
      $img->destroy();
      // if(file_exists($fixedSrc)){
      //   unlink($fixedSrc);
      // }
      if ($success === true) {
        return $resultSrc;
      } else {
        $modx->log(MODX_LOG_LEVEL_ERROR, 'imagick_create: File: ' . $full_src . ' error making preview to ' . $resultPath);
        return false;
      }
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
    $full_src = $_SERVER['DOCUMENT_ROOT'] . $src;

    // Проверяем, в src передан существующий файл или что-то другое?
    if (!file_exists($full_src)) {
      $modx->log(MODX_LOG_LEVEL_ERROR, 'make_thumb: Presumably PDF File: ' . $full_src . ' does not exist');
      return '';
    }
    return imagick_create($src) ?: '';
  }
}

// presume that incoming src is a relative path
return make_thumb($src) ?: '';
