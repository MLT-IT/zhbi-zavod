<?php

try {
  $output = [];
  $localdata = $modx->getPlaceholder('localdata');
  if ($localdata['stores'] && count($localdata['stores']) > 0) {
    $output['stores'] = &$localdata['stores'];
  }else {
    switch($localdata['region']) {
      case "krasnodar":
        $phone = &$localdata['offices'][0]['phone'];
        $output['stores'] = [
          ["case" => "Краснодаре",
          "phone" => $phone.', доб 1'],
          ["case" => "Армавире",
          "phone" => $phone.', доб 2'],
          ["case" => "Адыгейске",
          "phone" => $phone.', доб 3']
        ];
      break;
      default:
        $phone = $modx->getOption('phone', null, false);
        $output['stores'] = [
          ["case" => "Мурино",
          "phone" => $phone.', доб 1'],
          ["case" => "Красном Селе",
          "phone" => $phone.', доб 2'],
          ["case" => "Гатчине",
          "phone" => $phone.', доб 3']
        ];
      break;
    }
  }
  return $output;
}catch(Throwable $t) {

}