<?php
// сначала опция
$phone = $modx->getOption('phone');

// пробую UTM, если есть перезаписываю
$utmPhone = $modx->runSnippet('utm',['val' => 'phone']);

if($utmPhone){
    $phone = $utmPhone;
}
// пробую виртуалки, если есть перезаписываю
$localdata = $modx->getPlaceholder('localdata');

if($localdata['offices'][0]['phone']){
    $phone = $localdata['offices'][0]['phone'];
}

$host = $_SERVER['HTTP_HOST'];
$domain_seq = explode('.', $host);
$subdomain = $domain_seq[0];
$rev = array_reverse($domain_seq);
if($subdomain == 'msk'){
    $phone = '+7 (499) 350-66-48';
    if($type=='link'){
        $phone = '74993506648';
    }
}
if($modx->context->key == 'fibrofasad'){
    $phone = '+7 (812) 309-57-00';
    if($type=='link'){
        $phone = '78123095700';
    }
}
if($modx->context->key == 'beltermo'){
    $phone = '+7 (812) 309-57-00';
    if($type=='link'){
        $phone = '78123095700';
    }
}
echo $phone;
