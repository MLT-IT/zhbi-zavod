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

$ids = $modx->runSnippet('msProducts', [
    'parents' => 0,
    'depth' => 100000,
    'returnIds' => 1,
    'where' => '{"Data.article:IS": null}',
    'context' => 'kraska',
    'sortby' => 'id',
    'sortdir' => 'ASC',
    'offset' => 0,
    'limit' => 5000,
]);

$ids = explode(',', $ids);
array_filter($ids);

foreach ($ids as $id) {
    $prod = $modx->getObject('modResource', $id);

    if (empty($prod)) {
        continue;
    }

    // Получение родителя
    $parentId = $prod->parent;
    $parent = $modx->getObject('modResource', $parentId);

    if (empty($parent)) {
        continue;
    }

    $article = $parent->pagetitle;

    $article = mb_strtolower(mb_substr($article, 0, 1));
    $article = rus2translit($article);
    $article .= '-' . $prod->id;

    echo 'Для товара с id ' . $id . ' артикул будет таким: ' . $article . '<br>';

    $prod->set('article', $article);
    $prod->save();
}

echo 'Конец работы скрипта';