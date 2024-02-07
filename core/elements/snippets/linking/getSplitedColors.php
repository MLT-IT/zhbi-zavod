<?php

// Для перелинковки по RAL делим массив на 2 части
if (!isset($colorsArray)) return false;

function splitArray(array $array): array
{
    $resultArray = [];
    $counter = 0;
    foreach ($array as $key => $val) {
        if ($counter % 2 == 0) {
            $resultArray[0][$key] = $val;
        } else {
            $resultArray[1][$key] = $val;
        }
        $counter++;
    }

    return $resultArray;
}

return splitArray($colorsArray);
