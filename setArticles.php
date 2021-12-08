<?php
function rus2translit($string) {
    $converter = array(
        'а' => 'a',   'б' => 'b',   'в' => 'v',
        'г' => 'g',   'д' => 'd',   'е' => 'e',
        'ё' => 'e',   'ж' => 'zh',  'з' => 'z',
        'и' => 'i',   'й' => 'y',   'к' => 'k',
        'л' => 'l',   'м' => 'm',   'н' => 'n',
        'о' => 'o',   'п' => 'p',   'р' => 'r',
        'с' => 's',   'т' => 't',   'у' => 'u',
        'ф' => 'f',   'х' => 'h',   'ц' => 'c',
        'ч' => 'ch',  'ш' => 'sh',  'щ' => 'sch',
        'ь' => '',  'ы' => 'y',   'ъ' => '',
        'э' => 'e',   'ю' => 'yu',  'я' => 'ya'
    );

    return strtr($string, $converter);
}

function handleWord($word, $amountChars) {
    if (is_numeric($word)) {
        return $word;
    }

    if (strlen($word) <= 2) {
        return ucfirst($word);
    }

    return ucfirst(substr($word, 0, $amountChars));
}

$ids = $modx->runSnippet('pdoResources', [
    'parents' => 0,
    'depth' => 100,
    'returnIds' => 1,
    'where' => '{"template:=": "6"}',
    'limit' => 0,
    'sortby' => 'id',
    'sortdir' => 'ASC'
]);

$ids = explode(',', $ids);

$iterator = 1;
foreach ($ids as $id) {
    $article = '';

    // Получение родителя
    $prod = $modx->getObject('modResource', $id);
    $parentId = $prod->parent;
    $parent = $modx->getObject('modResource', $parentId);

    // Получение слов
    $pagetitle = $parent->get('menutitle');
    if (empty($pagetitle)) {
        $pagetitle = $parent->get('pagetitle');
    }
    $pagetitle = mb_strtolower($pagetitle);

    $pagetitle = rus2translit($pagetitle);
    $words = explode(' ', $pagetitle);

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

    $article .= '-' . $iterator;

    $iterator++;

    echo 'Для товара с id ' . $id . ' артикул будет таким: ' . $article . '<br>';

    $prod->set('article', $article);
    $prod->save();
}
