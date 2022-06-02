<?php

$ids = $modx->runSnippet('pdoResources', [
    'parents' => 18986,
    'depth' => 9000,
    'limit' => 0,
    'sortby' => 'id',
    'sortdir' => 'ASC',
    'returnIds' => '1',
    'where' => '{"template:=":"5"}',
]);

$ids = explode(',', $ids);

foreach ($ids as $index => $id) {
    $cat = $modx->getObject('modResource', $id);
    $tv = $cat->getTVValue('listFilters');

    if (empty($tv)) {
        echo 'Действие с ресурсом' . $id . ' пропускается, т.к. у него пустое tv<br>';
        continue;
    }

    $tvNew = str_replace(',msoption|brand', '', $tv);

    if ($tv === $tvNew) {
        echo 'У ресурса ' . $id . ' не изменилось tv. ';

        if (mb_strpos($tv, 'brand') === false) {
            echo 'У этого ресурса нет слова "brand" в tv';
        }

        echo '<br>';

        continue;
    }

    echo 'Для ресурса ' . $id . ' tv теперь будет таким: ' . $tvNew . '<br>';

    $cat->setTVValue('listFilters', $tvNew);
    //$cat->save();
}

echo 'Конец';
