<?php
try {

  $ottenokItems = $modx->getOption('ottenokItems', $scriptProperties, false);
  //$modx->log(xPDO::LOG_LEVEL_ERROR, 'ottenokItems: ');
  //$modx->log(xPDO::LOG_LEVEL_ERROR, print_r($ottenokItems, true));
  if(!$ottenokItems)return;
  $ottenok = $modx->resource->get('ottenok')[0];
  $pids = '';
  $values = [];
  foreach($ottenokItems as &$item) {
    $pid = $item['product_id'];
    $value = $item['value'];
    if(!$pids)$pids = $pid;
    else $pids .= ','.$pid;
    $values[$pid] = $value;
  }

  //$modx->log(xPDO::LOG_LEVEL_ERROR, 'pids: '.$pids);
  //$modx->log(xPDO::LOG_LEVEL_ERROR, 'values: '.print_r($values, true));
  $query = "SELECT id, image, thumb from modx_ms2_products where id in ($pids)";
  $st = $modx->query($query);
  if(!$st)throw new Exception('Can\'t make query');
  $output = [
    'ottenok' => $ottenok,
    'ottenokItems' => []
  ];
  while($row = $st->fetch(PDO::FETCH_OBJ)) {
    $output['ottenokItems'][] = [
      'id' => $row->id,
      'thumb' => $row->thumb,
      'image' => $row->image,
      'title' => $values[$row->id]
    ];
  }
  $modx->log(xPDO::LOG_LEVEL_ERROR, 'output:'.print_r($output, true));
  return $output;
}catch(Throwable $t) {

}
