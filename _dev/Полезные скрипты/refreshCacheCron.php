<?php

/*
    Внимание!!!
    Для работы требуется минимум console-2.2.1 или поправьте вот это:
    https://github.com/MODX-Club/modx-console/commit/e75ef98a6d525c6a62e877dcb371e9d964b07962#diff-90a9966e2f3a0bcd55be99c92f37511b
*/

$output = "";

ini_set("display_errors", 0);
error_reporting(false);

$output .= "<pre>";

$modx->setOption("syncsite_default", false);
$modx->setOption("cacheregenerator.regenerate_docs_on_doc_save", false);
$modx->setOption("cacheregenerator.regenerate_docs_on_site_refresh", false);
$modx->setOption("cacheregenerator.regenerate_unsearchable_docs", false);



// Если процесс уже остановлен, сбрасываем OFFSET
if (!isset($_SESSION['Console']['completed'])) {
    $_SESSION['console_total'] = 0;
    $_SESSION['console_offset'] = 0;
    $_SESSION['console_processed'] = 0;
    $_SESSION['console_ids'] = array();
}
// Формируем запрос

// Общий запрос выборки перегенерируемых документов
$q = $modx->newQuery("modResource");

$alias = $q->getAlias();

$where = array(
    "cacheable" => true,
    "published" => true,
    "deleted"   => false,
);

if($exclude_templates = $modx->getOption("cacheregenerator.exclude_doc_templates_id")){
    $where['template:not in'] = explode(",", $exclude_templates);
}

if($exclude_ids = $modx->getOption("cacheregenerator.exclude_docs_id")){
    $where['id:not in'] = explode(",", $exclude_ids);
}

if(!$modx->getOption("cacheregenerator.regenerate_unsearchable_docs")){
    $where['searchable'] = true;
}

$q->where($where);

if (empty($_SESSION['console_total'])) {

    $ids = array();

    $qq = clone $q;
    $qq->select(array(
        "{$alias}.id",
    ));

    $ss = $qq->prepare();
    $ss->execute();

    while($row = $ss->fetch(PDO::FETCH_ASSOC)){
        // print_r($id['id']);
        $ids[$row['id']] = $row['id'];
    }

    $_SESSION['console_ids'] = $ids;

    $total = count($ids);
    $_SESSION['console_total'] = $total;
}
else{
    $total = $_SESSION['console_total'];
}

if(!$total){
    $modx->log(1, "Нечего обновлять", "HTML");
    $_SESSION['Console']['completed'] = true;
    return;
}
else{
    $_SESSION['Console']['completed'] = false;
}

$id = current($_SESSION['console_ids']);

unset($_SESSION['console_ids'][$id]);

if($resource = $modx->getObject('modResource', $id)){
    $output .= "<p>Processing resource <b>(".$resource->id.") ".$resource->get('pagetitle')."</b></p>";

    $modx->invokeEvent("OnDocFormSave", array(
        "object"    => $resource,
    ));

    $_SESSION['console_processed']++;
}



// Меняем offset
$success = round($_SESSION['console_processed'] / $total, 2) * 100;

for ($i=0; $i<=100; $i++) {
    if ($i <= $success) {
        $output .= '=';
    } else {
        $output .= '_';
    }
}

$current = $_SESSION['console_processed'];
$output .= "\n";
$output .= $success.'% ('.$current.')'."\n\n";

if(empty($_SESSION['console_ids'])){
    $output .= "\n";
    $output .= "Регенерация кеша завершена\n\n";
    unset($_SESSION['Console']['completed']);
}

return $output;
