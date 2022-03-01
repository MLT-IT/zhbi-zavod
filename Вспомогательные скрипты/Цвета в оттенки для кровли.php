<?php

$ids = $modx->runSnippet('msProducts', [
    'parents' => 0,
    'depth' => 9000,
    'limit' => 0,
    'sortby' => 'id',
    'sortdir' => 'ASC',
    'innerJoin' => '{"Options":{"class":"msProductOption"}}',
    'tpl' => '@INLINE [[+id]],',
    'where' => '{"1":{"Options.key":"cvet","Options.value:IS NOT":null}}',
    'context' => 'krovlya'
]);

$ids = trim($ids, " \t\n\r\0\x0B,");
$ids = explode(',', $ids);
$ids = array_map(function($id) {
    return trim($id);
}, $ids);

foreach ($ids as $index => $id) {
    $prod = $modx->getObject('msProduct', $id);
    if (!empty($prod)) {
        // echo $id . ' ' . $prod->get('cvet')[0] . ', всего цветов: ' . count($prod->get('cvet')) . '<br>';

        $options = $prod->loadData()->get('options');

        $cvet = $prod->get('cvet');
        foreach ($cvet as $key => $val) {
            if (empty($val)) {
                continue;
            }
            $cv = mb_strtolower($val);
            $match = preg_match('/^ral|^rr/mi', $cv);
            if ($match === 0) {
                echo '++ У товара с id ' . $id . ' цвет ' . $val . ' будет перенесен в оттенок<br>';

                unset($options['cvet'][$key]);
                $options['ottenok'][] = $val;
            } elseif ($match === 1) {
                //echo '-- У товара с id ' . $id . ' цвет ' . $val . ' останется цветом<br>';
            }
        }

        $prod->set('options', $options);
        //$prod->save();
    } else {
        echo 'Не найден товар с id ' . $id;
    }

    /*
    if ($index >= 20) {
        break;
    }
    */
}

echo 'УСПЕХ!!!';
