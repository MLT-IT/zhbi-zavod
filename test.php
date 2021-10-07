<?php

$resources = $modx->getCollection('modResource', [
    'template' => 6,
    'id' => 8941
]);

$resultText = 'Неудавшиеся сохранения: ';
$resultIds = [];

foreach ($resources as $res) {
    $value = $res->get('upakovka');
    $valueDefault = $value;
    if (!empty($value)) {
        if (is_array($value)) {
            foreach ($value as $key => $val) {
                $val = handle($val);
                $value[$key] = $val;
            }
        } else {
            $value = handle($value);
        }

        $res->set('upakovka.value', $value);
        $result = $res->save();
        if ($result !== true) {
            $resultIds[] = $res->id;
        }
    }
}

$resultIds = implode(', ', $resultIds);
$resultText .= $resultIds;
echo $resultText;

function handle($val): string {
    $val = str_replace(',', '.', $val);
    $val = trim($val);
    $val = trim($val, '.');
    $floatVal = floatval($val);
    $floatVal = str_replace(',', '.', $floatVal);
    $val = str_replace($floatVal, '', $val);
    $val = trim($val);
    $val = trim($val, '.');
    $val = $floatVal . ' ' . $val;
    return $val;
}
