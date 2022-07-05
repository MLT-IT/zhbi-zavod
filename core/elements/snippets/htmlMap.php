<?php

$cacheName = 'htmlMap';
$cacheOptions = [
    xPDO::OPT_CACHE_KEY => 'default/file_snippets/' . $cacheName . '/' . $modx->context->key . '/',
];

if (!$result = $modx->cacheManager->get($cacheName, $cacheOptions)) {
    if (!function_exists('pdoMenuArray')) {
        function pdoMenuArray($modx, $paramsUser = []) {
            $params = [
                'resources' => '-' . $modx->resource->id,
                'parents' => 0,
                'depth' => 1000,
                'limit' => 0,
                'tplOuter' => '@INLINE {[[+wrapper]]}',
                'tpl' => '@INLINE "[[+alias]]": { "id": "[[+id]]", "menutitle": "[[+menutitle]]", "uri": "[[+uri]]" [[+wrapper:is=``:then=``:else=`,"children":[[+wrapper]]`]] },',
                'showHidden' => '1',
                'context' => $modx->resource->context_key,
                'where' => '{"searchable:=":1}'
            ];

            if (!empty($paramsUser)) {
                $params = array_merge($params, $paramsUser);
            }

            $json = $modx->runSnippet('pdoMenu', $params);

            // Подправляем JSON, чтобы можно было выполнить json_decode
            $json = str_replace(',}', '}', $json);

            // Превращаем JSON в многомерный массив
            $array = json_decode($json, 1);

            return $array;
        }
    }

    if (!function_exists('arrayToString')) {
        function arrayToString($array) {
            $result = '<ul>';
            foreach ($array as $val) {
                $result .= '<li><a href="' . $val['uri'] . '">' . $val['menutitle'] . '</a>';
                if (!empty($val['children'])) {
                    $result .= arrayToString($val['children']);
                }
                $result .= '</li>';
            }
            $result .= '</ul>';

            return $result;
        }
    }

    // $pdo нужен, чтобы вызывать файловые сниппеты
    $pdo = $modx->getService('pdoTools');

    // Получаем id ресурса, в котором находятся СЕО выборки
    $seoId = $pdo->runSnippet('@FILE snippets/getIdByAlias.php', [
        'alias' => 'seo'
    ]);

    $htmlMapArray = pdoMenuArray($modx);

    if (!empty($seoId)) {
        $seoArray = pdoMenuArray($modx, ['parents' => $seoId]);
        $htmlMapArray['catalog']['children'] = array_merge($htmlMapArray['catalog']['children'], $seoArray);
    }

    $result = arrayToString($htmlMapArray);

    $modx->cacheManager->set($cacheName, $result, 0, $cacheOptions);
}

return $result;
