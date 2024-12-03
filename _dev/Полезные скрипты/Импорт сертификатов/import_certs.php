<?php

/*
Запускается с локальной машины, загружает сертификаты с сайта в указанную папку.
Требует json вывод сниппета getAllCerts (который находится в БД),
в который добавлены alias и url 
и сделана замена $certsGlobal[] = $c;//$certsGlobal[$key] = $c;

Пример записи во входящих json файлах.
{
    "MIGX_id": 4,
    "name": "Каталог: Городская программа \"Моя улица\" от Standartpark",
    "file": "239bc4ebb02539021caab447822b9219.pdf",
    "url": "bruschatka-i-plitka-dlya-mosheniya\/bordury\/bordury-sadovyie\/bordyur-standartpark-newfix-pro-chernyy-3000-86-60-mm\/",
    "alias": "bordyur-standartpark-newfix-pro-chernyy-3000-86-60-mm"
},

*/

error_reporting(E_ALL & ~E_WARNING);

define("TARGET_URL", "https://kirpich-m.ru/assets/template/img/import/");
define("TARGET_DIR", "./toUpload/");


$m = json_decode(file_get_contents('./m_all_certs.json'), true);
$m5 = json_decode(file_get_contents('./m5_all_certs.json'), true);

//print_r($m);
//print_r($m5);

define("RET_DONE", 0);
define("RET_FILE_EXISTS", 1);
define("RET_FILE_NOT_FOUND", 2);

/*
Загрузка 1 сертификата.
@param $path - относительный путь
*/
function downloadFile(string $path){
    $target_path = TARGET_DIR.$path;
    if(file_exists($target_path))return RET_FILE_EXISTS;

    $dir = dirname($path);
    echo $dir;
    $filename = basename($path);
    $url = TARGET_URL.$dir."/".rawurlencode($filename);
    echo $url."\n";
    $data = file_get_contents($url);
    if(empty($data))return RET_FILE_NOT_FOUND;

    $target_path = TARGET_DIR.$path;
    if(!file_exists(dirname($target_path))){
        mkdir(dirname($target_path), 0777, true);
    }
    file_put_contents($target_path, $data);
    return RET_DONE;
}

/*
Загрузка сертификатов с kirpich-m
*/
function downloadCerts(array $new_m5, array $new_m){
    //global $m5;
    $total = count($new_m5);
    $i = 1;
    foreach($new_m5 as $alias => $item_m5){
        if(!isset($new_m[$alias])){
            ++$i;
            echo "[$i/$total]\n";
            continue;
        }
        //print_r($new_m[$alias]);
        //echo $new_m[$alias]."\n";
        foreach($new_m[$alias]['files'] as $item){
            //print_r($item);
            $r = downloadFile($item['file']); 
            //if($r == RET_DONE)echo "RET_DONE\n";
            if($r == RET_FILE_EXISTS){
                continue;
            }else if($r == RET_FILE_NOT_FOUND){
                echo $item['file']." not found\n";
                continue;
            }
        }
       
        echo "[$i/$total]\n";
        ++$i;
    }
    echo "Downloaded.\n";
}

/*
Выводит список товаров и сертификатов, которые есть на kirpich-m, но нету на kirpich-m5
*/
function setNewMIGXs(array $new_m5, array $new_m){
    $total = count($new_m5);
    $i = 1;

    $toAddMIGX = [];

    foreach($new_m5 as $alias => $item_m5){
        //echo $alias."\n";
        if(!isset($new_m[$alias])){
            ++$i;
            echo "[$i/$total]\n";
            continue;
        } 
        /*if($alias == 'keramicheskiy-blok-porotherm-20-8-99-nf-m100-400-200-219-mm'){
            echo "found\n";
            break;
        } */  
        //echo "found!\n";
        $m_doc = $new_m[$alias];
        foreach($m_doc['files'] as $file_m){
            //print_r($item_m);
            $found = false;
            foreach($item_m5['files'] as $file_m5){
                //print_r($item_m5);
                if($file_m5['file'] == $file_m['file']){
                    //echo $file_m5['file']."\n";
                    //echo $file_m['file']."\n";
                    /*if($alias == 'keramicheskiy-blok-porotherm-20-8-99-nf-m100-400-200-219-mm'){
                        echo "found\n";
                        echo "m: ".$file_m['file']."\n";
                        echo "m5: ".$file_m5['file']."\n";
                    }*/
                    $found = true;
                    break;
                }
                //var_dump($found);
            }
            if(!$found){
                echo "adding\n";
                print_r($file_m);
                $toAddMIGX[$alias][] = $file_m;
            }
        }
       
        //echo "[$i/$total]\n";
        ++$i;
    }
    file_put_contents("./to_add_migx.json", json_encode($toAddMIGX, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE));
    echo "done.\n";   
}

/*
Преобразует массив $m в массив, в котором удобно искать товары по алиасу и все их сертификаты
*/
function getIndex(array $m){
    $output = [];
    foreach($m as $item){
        $alias = $item['alias'];
        ++$output[$alias]['urls'][$item['url']];
        $output[$alias]['files'][] = [
            'name' => $item['name'],
            'file' => $item['file'],
        ];
    }
    return $output;
}



$new_m = getIndex($m);
$new_m5 = getIndex($m5);

/*
ob_start();
echo count($new_m);
print_r($new_m);
$buff = ob_get_clean();
file_put_contents("./new_m.txt", $buff);
*/
/*
ob_start();
echo count($new_m5);
print_r($new_m5);
$buff = ob_get_clean();
file_put_contents("./new_m5.txt", $buff);
*/


downloadCerts($new_m5, $new_m);
setNewMIGXs($new_m5, $new_m);


exit();