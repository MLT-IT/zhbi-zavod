<?php
/*
  Проверяет, является ли $id потомком $ancestor
*/
try{
  //$modx->log(xPDO::LOG_LEVEL_ERROR, 'It works!');
  $id = $modx->getOption('id', $scriptProperties, false);
  $ancestor = $modx->getOption('ancestor', $scriptProperties, false);
  //$modx->log(xPDO::LOG_LEVEL_ERROR, 'id:'.$id);
  //$modx->log(xPDO::LOG_LEVEL_ERROR, 'ancestor:'.$ancestor);
  if(!$id)return;
  if(!$ancestor)return;
  include_once MODX_CORE_PATH."elements/services/UltimateParentService.inc.php";
  $svc = new UltimateParentService($modx);
  $up = $svc->getUltimateParent($id, $ancestor);
  //$modx->log(xPDO::LOG_LEVEL_ERROR, 'up:'.$up);
  return ($up == $ancestor || $up == $id);
}catch(Throwable $t) {
  //$modx->log(xPDO::LOG_LEVEL_ERROR, $t->getMessage().$t->getTraceAsString());
}