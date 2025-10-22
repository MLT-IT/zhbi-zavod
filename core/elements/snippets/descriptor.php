<?php
try {
  $ctx = $modx->resource->context_key?$modx->resource->context_key:'web';
  
  $data = json_decode(file_get_contents(MODX_ASSETS_PATH."template/json/descriptor.json"));
  if(!$data)throw "default";
  $text = $data->$ctx;
  //$modx->log(xPDO::LOG_LEVEL_ERROR, "ctx: ".$ctx);
  //$modx->log(xPDO::LOG_LEVEL_ERROR, "text: ".$text);
  if(!$text)return $data->default;
  return $text;
}catch(Throwable $t) {
  return 'Продажа строительных товаров в Санкт-Петербурге';
}
