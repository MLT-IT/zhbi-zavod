<?php

$parents = 101936;

// -----------------------------------------------------
$uri = $modx->makeUrl($parents);
$uri = str_replace('https://gazosilikatstroy.ru', '', $uri);

$idsArray = $modx->runSnippet('msProducts', [
    'parents' => $parents,
    'depth' => 1000,
    'limit' => 0,
    'returnIds' => 1,
]);
$idsArray = explode(',', $idsArray);

$plotn = [];
$razmr = [];
foreach ($idsArray as $id) {
    $prod = $modx->getObject('msProduct', $id);
    $options = $prod->loadData()->get('options');
    $plotn[] = $options['plotnost-ob'][0];
    $razmr[] = $options['razmer-mm'][0];
}

$plotn = array_unique($plotn);
$plotn = array_map(function($v) use($uri) {
    return '[<br>"uri" => "' . $uri . '?plotnost-ob=' . $v . '",<br>"name" => "' . $v . '"<br>],<br>';
}, $plotn);

$razmr = array_unique($razmr);
$razmr = array_map(function($v) use($uri) {
    return '[<br>"uri" => "' . $uri . '?razmer-mm=' . $v . '",<br>"name" => "' . $v . '"<br>],<br>';
}, $razmr);

echo implode('<br>', $plotn);
echo '<br>--------------------------------------------<br><br>';
echo implode('<br>', $razmr);
echo '<br>';
