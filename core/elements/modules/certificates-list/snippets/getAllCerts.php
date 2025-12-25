<?php

/**
 * @param - $tvName [string] - Название TV поля в котором содержатся сертификаты
 */

// Get the TV ID
$tv = $modx->getObject('modTemplateVar', ['name' => $tvName]);
if (!$tv) {
    return 'TV not found!';
}
$tvId = $tv->get('id');

// Query
$query = $modx->newQuery('modTemplateVarResource');
$query->leftJoin('modResource', 'Resource', 'modTemplateVarResource.contentid = Resource.id');
$query->where([
    'modTemplateVarResource.tmplvarid' => $tvId,
    'Resource.class_key' => 'msProduct',
    'Resource.context_key' => $modx->context->key,
]);

$query->select('modTemplateVarResource.value');
$tvs = $modx->getIterator('modTemplateVarResource', $query);

$output = [];
$seenFiles = [];

foreach ($tvs as $tv) {
    $value = $tv->get('value');
    if (!$value) continue;

    $items = json_decode($value, true);
    if (!is_array($items)) continue;

    foreach ($items as $item) {
        if (!isset($item['file'])) continue;

        $fileName = $item['file'];

        // Добавляем только если ещё не встречалось
        if (!in_array($fileName, $seenFiles, true)) {
            $seenFiles[] = $fileName;
            $output[] = $item;
        }
    }
}

return $output;
