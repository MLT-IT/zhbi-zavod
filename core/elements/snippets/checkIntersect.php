<?php

/**
 * Принимает параметры:
 * $array1,
 * $array2
 */
if (!is_array($array1) || !is_array($array2) || empty($array1) || empty($array2)) {
    return false;
}

return !empty(array_intersect($array1, $array2));
