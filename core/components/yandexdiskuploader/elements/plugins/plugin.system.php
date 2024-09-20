<?php
if ($modx->context->key == 'mgr' || $modx->event->name != 'OnHandleRequest') {return;}
if (empty($_SERVER['HTTP_X_REQUESTED_WITH']) || $_SERVER['HTTP_X_REQUESTED_WITH'] != 'XMLHttpRequest') {return;}

if ($_REQUEST['action'] == 'yandexdiskuploader_upload') {
    if (isset($_FILES) && !empty($_FILES)) {
        foreach ($_FILES as $inputId => $file) {
            $headers = array("Authorization: OAuth " . $modx->getOption('yandexdiskuploader_access_token'), "Content-Type: application/json");
            if (!isset($_SESSION['yaDiskUpload_user']) || !$_SESSION['yaDiskUpload_user']) {
                $_SESSION['yaDiskUpload_user'] = date('H_i_s');
            }
            $user = $_SESSION['yaDiskUpload_user'];
            $path = date('Y-m-d') . '/' . $inputId . '/' . $user;
            $root = 'disk:/Приложения/MODX Яндекс.Диск/';
            foreach (explode('/', $path) as $dir) {
                $root = $root . $dir . '/';
                $ch = curl_init('https://cloud-api.yandex.net/v1/disk/resources?path=' . urlencode($root));
                curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
                curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'PUT');
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                curl_exec($ch);
                curl_close($ch);
            }
            $tmp = explode('.', $_FILES[$inputId]['name']);
            $ext = array_pop($tmp);
            $file_name = implode('.', $tmp) .'-'. substr(md5_file($_FILES[$inputId]['tmp_name']), 0, 5) . '.' . $ext;
            $ch = curl_init('https://cloud-api.yandex.net/v1/disk/resources/upload?path=' . urlencode($root . $file_name));
            curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            $response = $modx->fromJSON(curl_exec($ch));
            curl_close($ch);
            if (isset($response['href']) && $response['href']) {
                $ch = curl_init($response['href']);
                curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
                curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'PUT');
                curl_setopt($ch, CURLOPT_INFILE, fopen($_FILES[$inputId]['tmp_name'], 'r'));
                curl_setopt($ch, CURLOPT_INFILESIZE, filesize($_FILES[$inputId]['tmp_name']));
                curl_setopt($ch, CURLOPT_UPLOAD, true);
                curl_setopt($ch, CURLOPT_POST, false);
                curl_setopt($ch, CURLOPT_PUT, true);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                curl_exec($ch);
                curl_close($ch);
            }
            $output = array(
                'inputId' => $inputId,
                'url' => 'https://disk.yandex.ru/client/disk/' . str_replace('disk:/', '', $root)
            );
            print $modx->toJSON($output);
            die();
        }
    }
    die();
}
