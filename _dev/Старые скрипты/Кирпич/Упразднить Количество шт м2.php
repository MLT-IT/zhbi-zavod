<?php

/*
Если заполнена опция: "Кол-во шт в 1 м2 с учетом растворного шва" и при этом есть "Количество шт/м2", то надо упразднить опцию у товара "Количество шт/м2"
*/

$ids = $modx->runSnippet('msProducts', [
    'parents' => 0,
    'returnIds' => 1,
    'depth' => 1000,
    'limit' => 1000,
    'offset' => 0,
    'showUnpublished' => 1,
    'showDeleted' => 1,
    'context' => 'kirpich-m',
    'optionFilters' => '{"k_m2seam:IS NOT": null, "kolvoshm2:IS NOT": null}'
]);

echo 'ids = ' . $ids . '<br><br>';

if (!empty($ids)) {
    $ids = explode(',', $ids);

    foreach ($ids as $id) {
        $object = $modx->getObject('msProduct', $id);
        if (empty($object)) {
            echo 'Не найден товар с id ' . $id . '<br>';
        }

        if (
            empty($object->get('k_m2seam')) ||
            empty($object->get('k_m2seam')[0])
        ) {
            echo 'Работа с товаром с id ' . $id . ' пропущена, т.к. у него не заполнено k_m2seam<br>';
            continue;
        }

        if (
            empty($object->get('kolvoshm2')) ||
            empty($object->get('kolvoshm2')[0])
        ) {
            echo 'Работа с товаром с id ' . $id . ' пропущена, т.к. у него не заполнено kolvoshm2<br>';
            continue;
        }

        echo 'У товара с id ' . $id . ' опция k_m2seam равна ' . $object->get('k_m2seam')[0] . ', а опция kolvoshm2 равна ' . $object->get('kolvoshm2')[0] . '<br>';

        $options = $object->loadData()->get('options');
        $options['kolvoshm2'] = '';
        $object->set('options', $options);
        $object->save();
    }
}

echo 'Конец работы скрипта';

