<?php

$ids = $modx->runSnippet('msProducts', [
    'parents' => 66777,
    'depth' => 1000,
    'limit' => 0,
    'returnIds' => 1,
]);

echo $ids . '<br>';
$ids = explode(',', $ids);

foreach ($ids as $id) {
    $prod = $modx->getObject('msProduct', $id);
    $options = $prod->loadData()->get('options');

    if (empty($options['item_width']) || empty($options['item_width'][0])) {
        echo 'Работа с товаром ' . $id . ' пропущена, т.к. у него не заполнено поле item_width<br>';
        continue;
    }

    if (empty($options['item_length']) || empty($options['item_length'][0])) {
        echo 'Работа с товаром ' . $id . ' пропущена, т.к. у него не заполнено поле item_length<br>';
        continue;
    }

    $val = $options['item_width'][0] . 'х' . $options['item_length'][0];
    $options['format_text'] = [$val];

    $prod->set('options', $options);
    $prod->save();
}
