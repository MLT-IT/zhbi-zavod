<?php

//Вызывает сниппет, замена $modx->runSnippet.

class CallService {
  private $modx = null;
  function __construct(&$modx) {
    $this->modx = $modx;
  }
  //$path - путь относительно MODX_CORE_PATH
  function call($path, $params = []) {
    $modx = $this->modx;
    //$modx->log(xPDO::LOG_LEVEL_ERROR, 'call');
    try {
      $scriptProperties = &$params;
      //$modx->log(xPDO::LOG_LEVEL_ERROR, MODX_CORE_PATH.$path);
      //$modx->log(xPDO::LOG_LEVEL_ERROR, print_r($scriptProperties, true));
      $res = require MODX_CORE_PATH.$path;
      //$modx->log(xPDO::LOG_LEVEL_ERROR, $res);
      return $res;
    }catch(Throwable $t) {
      $modx->log(xPDO::LOG_LEVEL_ERROR, $t->getMessage().$t->getTraceAsString());
    }
  }

}