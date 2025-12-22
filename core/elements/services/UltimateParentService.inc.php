<?php

/*
  Находит самого старшего родителя для товара при условии, что этот родитель должен быть потомком некоторой категории, указанной в $ancestorByCtx
*/

class UltimateParentService {
  public $modx = null;
  public static $defaultResult = 0; //Если в $ancestorByCtx нет нужного контекста, то вернуть этот ресурс
  public static $ancestorByCtx = [
    'web' => 93445
  ];
  function __construct(&$modx) {
    $this->modx = &$modx;
  }

  function log($msg) {
    if(is_array($msg))$msg = print_r($msg, true);
    $this->modx->log(xPDO::LOG_LEVEL_ERROR, $msg);
  }

  private function getUParentResByParent(int $id, int $parent, int $ancestor) {
    while($parent != 0 && $parent != $ancestor) {
      $q = $this->modx->query("SELECT parent from `modx_site_content` where id = $parent");
      if(!$q)throw new Exception("Can't build query");
      $res = $q->execute();
      if(!$res)throw new Exception("Can't exec query");
      $rows = $q->fetchAll(PDO::FETCH_ASSOC);
      if(!$rows || count($rows) < 1)throw new Exception("Bad query result");
      $parent2 = $rows[0]['parent'];
      return $this->getUParentResByParent($parent, $parent2, $ancestor);
    }
    return $id;
  }

  function getUltimateParent(int $product_id, $ancestor, $resource = null) {
    if(!$resource)$resource = $this->modx->getObject('modResource', $product_id);
    if(!$resource)return UltimateParentService::$defaultResult;
    //$ctx = $resource->get('context_key');
    //$this->log("Context: ".$ctx);
    //$ancestor = UltimateParentService::$ancestorByCtx[$ctx];
    //$this->log(print_r(UltimatParentService::$ancestorByCtx, true));
    if(!$ancestor) return UltimateParentService::$defaultResult;
    $parent = $resource->get('parent');
    $result = $this->getUParentResByParent($product_id, $parent, $ancestor);
    return $result;
  }

  /*
    заполняет кастомное поле ultimate_parent в таблице modx_ms2_products

    само поле:
    'ultimate_parent' => 
    array (
      'dbtype' => 'int',
      'precision' => '10',
      'phptype' => 'integer',
      'null' => true,
      'default' => 0,
    ),
    индекс:
    'ultimate_parent' => 
    array (
      'alias' => 'ultimate_parent',
      'primary' => false,
      'unique' => false,
      'type' => 'BTREE',
      'columns' => 
      array (
        'ultimate_parent' => 
        array (
          'length' => '',
          'collation' => 'A',
          'null' => true,
        ),
      ),
    ),

  */
  function setUltimateParent(int $product_id, int $up) {
    $q = $this->modx->query("UPDATE modx_ms2_products set ultimate_parent = $up where id = $product_id");
    if(!$q)throw new Exception('Can\'t build query');
    $res = $q->execute();
    if(!$res)throw new Exception('Can\'t execute query');
    return;
  }
}