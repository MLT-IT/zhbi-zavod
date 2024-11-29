<?php
/*
Делит входную строку на колонки и выводит одну из них
    @param input - входная строка
    @param separator - разделитель элементов
    @param columns - кол-во колонок
    @param column - какую колонку вывести, начиная с 1
*/

$input = $modx->getOption('input', $scriptProperties, false);
if(!$input)return "no input for columns.php";

//echo "input: $input";

$sep = $modx->getOption('separator', $scriptProperties, "\n");
$columns = $modx->getOption('columns', $scriptProperties, 1);
$column = $modx->getOption('column', $scriptProperties, 1);
if($column > $columns)return "column = $column должен быть не больше $column_cnt";

$parts = explode($sep, $input);
if(!$parts)return "parts is empty in columns.php";

$count = count($parts); //всего элементов к выводу
//echo "Всего: $count";

$elem_cnt = floor($count/$columns); //кол-во элементов в каждой колонке
if($count%$columns !== 0)++$elem_cnt; //Если есть остаток, то вывести на 1 элемент больше

$offset = $elem_cnt*($column - 1); //с какого индекса выводить элементы
//echo "offset: $offset\n";
$limit_index = $offset + $elem_cnt; //индекс элемента, до которого выводить элементы, не включая его
//echo "limit_index: $limit_index\n";
if($limit_index > $count)$limit_index = $count; //не выходить за пределы массива

$output = "";
for($i = $offset; $i < $limit_index; ++$i){
    $output .= $parts[$i].$sep;
}

return $output;
