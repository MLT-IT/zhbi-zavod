<?php
// Shared multi-host config. DO NOT COMMIT. Rotate api_key if leaked.
// Resolves site by HTTP_HOST so one api/ folder can serve many domains.

$shared_origins = [
    'https://admin.mlt-development.ru',
    'https://beton-mlt.sonclick.dev',
];

$sites = [
    'alterteplo.ru' => '3e41f4e05dc3e04855d1b27e05926571e35ef6d5be4b9e955c9eb44d65028ab8',
];

$host = strtolower((string)($_SERVER['HTTP_HOST'] ?? ''));
$host = preg_replace('/:\d+$/', '', $host) ?: '';

$siteKey = $host;
if (!isset($sites[$siteKey]) && strncmp($host, 'www.', 4) === 0) {
    $siteKey = substr($host, 4);
}

if (!isset($sites[$siteKey])) {
    return [
        'api_key'          => '',
        'allowed_origins'  => $shared_origins,
        'backup_retention' => 50,
        'site_slug'        => 'unknown',
    ];
}

return [
    'api_key'          => $sites[$siteKey],
    'allowed_origins'  => array_values(array_unique(array_merge([
        'https://' . $siteKey,
        'https://www.' . $siteKey,
    ], $shared_origins))),
    'backup_retention' => 50,
    'site_slug'        => preg_replace('/\.[^.]+$/', '', $siteKey),
];
