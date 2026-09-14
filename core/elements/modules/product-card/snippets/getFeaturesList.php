<?php

try {
  $ctx = $modx->getOption('ctx', $scriptProperties, $modx->resource->context_key);
  $delivery_date = $modx->getOption('delivery_date', $scriptProperties, '');

  $json = file_get_contents(MODX_CORE_PATH."elements/modules/product-card/$ctx/json/features-list.json");
  $json = str_replace('%%delivery_date', $delivery_date, $json);
  //$modx->log(xPDO::LOG_LEVEL_ERROR, 'json:');
  //$modx->log(xPDO::LOG_LEVEL_ERROR, $json);
  $output = json_decode($json, true);
  return $output;
}catch(Throwable $t) {
  //$modx->log(xPDO::LOG_LEVEL_ERROR, $t->getMessage()."\n".$t->getTraceAsString());
}