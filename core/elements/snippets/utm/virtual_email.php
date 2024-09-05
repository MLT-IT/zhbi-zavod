<?php
$email = $modx->getOption('email');

// пробую UTM, если есть перезаписываю
$utmEmail = $modx->runSnippet('utm',['val' => 'email']);

if($utmEmail){
    $phone = $utmEmail;
}

$host = $_SERVER['HTTP_HOST'];
$domain_seq = explode('.', $host);
$subdomain = $domain_seq[0];
$rev = array_reverse($domain_seq);
if($subdomain == 'msk'){
    if(count($domain_seq) > 3){
        $email = 'msk@'.$rev[2].".".$rev[1].".".$rev[0];
    }else{
        $email = 'msk@'.$rev[1].".".$rev[0];
    }
}
// добавил для Краснодарских виртуалок 29.05.2024 tedgregory
// $localdata = $modx->getPlaceholder("localdata");
// if($localdata['local']){
//     $prefix = 'info';
//     if($localdata['region']){
//         $prefix = $localdata['region'];
//     }
//     if(count($domain_seq) > 3){
//         $email = $prefix.'@'.$rev[2].".".$rev[1].".".$rev[0];
//     }else{
//         $email = $prefix.'@'.$rev[1].".".$rev[0];
//     }
// }
// 
echo $email;
