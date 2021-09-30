<?php

$referer = $_SERVER['HTTP_REFERER'];

if (!empty($referer)) {
    return  $referer;
} else {
    return '/';
}
