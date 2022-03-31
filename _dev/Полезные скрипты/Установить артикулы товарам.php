<?php
if (!function_exists('rus2translit')) {
    function rus2translit($string) {
        $converter = [
            'а' => 'a', 'б' => 'b', 'в' => 'v',
            'г' => 'g', 'д' => 'd', 'е' => 'e',
            'ё' => 'e', 'ж' => 'zh', 'з' => 'z',
            'и' => 'i', 'й' => 'y', 'к' => 'k',
            'л' => 'l', 'м' => 'm', 'н' => 'n',
            'о' => 'o', 'п' => 'p', 'р' => 'r',
            'с' => 's', 'т' => 't', 'у' => 'u',
            'ф' => 'f', 'х' => 'h', 'ц' => 'c',
            'ч' => 'ch', 'ш' => 'sh', 'щ' => 'sch',
            'ь' => '', 'ы' => 'y', 'ъ' => '',
            'э' => 'e', 'ю' => 'yu', 'я' => 'ya'
        ];

        return strtr($string, $converter);
    }
}

if (!function_exists('handleWord')) {
    function handleWord($word, $amountChars) {
        if (is_numeric($word)) {
            return $word;
        }

        if (strlen($word) <= 2) {
            return ucfirst($word);
        }

        return ucfirst(substr($word, 0, $amountChars));
    }
}

$ids = $modx->runSnippet('pdoResources', [
    'parents' => 0,
    'depth' => 1000,
    'returnIds' => 1,
    'where' => '{"template:=": "6"}',
    'sortby' => 'id',
    'sortdir' => 'ASC',

    'offset' => 0,
    'limit' => 10000,
    'context' => 'krovlya'
]);

$ids = explode(',', $ids);
array_filter($ids);

foreach ($ids as $id) {
    $article = '';

    $prod = $modx->getObject('modResource', $id);

    // Получение родителя
    $parentId = $prod->parent;
    $parent = $modx->getObject('modResource', $parentId);

    // Получение слов
    $name = $parent->get('menutitle');
    if (empty($name)) {
        $name = $parent->get('pagetitle');
    }
    $name = mb_strtolower($name);

    $name = rus2translit($name);
    $words = explode(' ', $name);

    // Составление артикула
    // Первое слово
    $article .= handleWord($words[0], 3);
    if (count($words) > 1) {
        // Второе слово
        $article .= handleWord($words[1], 2);
        // Остальные слова
        for ($i = 2; $i < count($words); $i++) {
            $article .= handleWord($words[$i], 1);
        }
    }

    $article .= '-' . $id;

    //echo 'Для товара с id ' . $id . ' артикул будет таким: ' . $article . '<br>';

    $prod->set('article', $article);
    $prod->save();
}

echo 'Конец работы скрипта';
