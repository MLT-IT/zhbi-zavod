<?php

$uri = $_SERVER['REQUEST_URI'];

// Separate the path and query string
$parts = parse_url($uri);
$path = $parts['path'] ?: '';
$query = isset($parts['query']) ? $parts['query'] : '';

$lowerPath = strtolower($path);

// Only redirect if path differs in case
if ($path !== $lowerPath) {
    $host = $_SERVER['HTTP_HOST'];
    $protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https://' : 'http://';
    $newUrl = $protocol . $host . $lowerPath;
    if ($query !== '') {
        $newUrl .= '?' . $query;
    }

    header("Location: {$newUrl}", true, 301);
    exit();
}
