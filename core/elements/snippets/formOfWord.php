<?php

//  n      f1        f2        f5
// [10, 'статья', 'статьи', 'статей']

$n = abs(intval($n)) % 100;
if ($n > 10 && $n < 20) {
    return $f5;
}
$n = $n % 10;
if ($n > 1 && $n < 5) {
    return $f2;
}
if ($n == 1) {
    return $f1;
}

return $f5;
