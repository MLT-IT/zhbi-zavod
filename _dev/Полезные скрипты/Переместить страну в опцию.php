<?php

$q = 'SELECT * 
      FROM ' . $modx->getOption('table_prefix') . 'ms2_products 
      WHERE made_in IS NOT NULL AND made_in != " "';

$query = $modx->query($q);

if ($query !== false) {
    $fetch = $query->fetchAll(PDO::FETCH_ASSOC);

    foreach ($fetch as $item) {
        $prod = $modx->getObject('msProduct', $item['id']);

        if (empty($prod)) {
            echo 'Не удалось найти товар с id ' . $item['id'] . '<br>';
            continue;
        }

        $options = $prod->loadData()->get('options');
        $options['strana'] = [$prod->get('made_in')];
        $prod->set('options', $options);

        echo 'Теперь для товара с id ' . $item['id'] . ' будет такая страна: ' . $prod->get('made_in') . '<br>';

        $prod->set('made_in', '');
        $prod->save();
    }
}

echo 'Конец работы скрипта';
