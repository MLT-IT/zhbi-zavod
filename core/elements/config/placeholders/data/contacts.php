<?php

/**
 * Телефон и почта считаются через уже существующие сниппеты
 * (core/elements/snippets/utm/virtual_phone.php, virtual_email.php) —
 * там завязана логика на UTM/поддомены/контекст, дублировать её здесь не нужно.
 */

$phone = $modx->runSnippet('virtual_phone');

ob_start();
include MODX_CORE_PATH . 'elements/snippets/utm/virtual_email.php';
$email = ob_get_clean();

// virtual_email.php может вернуть значение с необработанными тегами MODX
// (например, [[++key:empty=`[[++key_reserve]]`]] из системной настройки
// "email") — обычный вызов через | snippet прогонял бы это через парсер
// автоматически (modScript::process()), а тут это делаем явно, иначе
// такие теги попадут в HTML как есть.
if (is_string($email) && strpos($email, '[[') !== false && $modx->getParser()) {
    $modx->parser->processElementTags(
        '',
        $email,
        $modx->parser->isProcessingUncacheable(),
        $modx->parser->isRemovingUnprocessed(),
        '[[',
        ']]',
        array(),
        (int)$modx->getOption('parser_max_iterations', null, 10)
    );
}

$address = $modx->getOption('address');
$localdata = $modx->getPlaceholder('localdata');
if (!empty($localdata['local'])) {
    $address = $localdata['offices'][0]['address'];
}

// show_error_message выключен: у show-room.tpl уже есть своя обработка
// пустых/заглушечных значений (скрыть блок, а не показать текст ошибки
// на живой странице) — не меняем это поведение.
$data = [
    'phone' => [
        'value' => $phone,
        'show_error_message' => false
    ],
    'email' => [
        'value' => $email,
        'show_error_message' => false
    ],
    'address' => [
        'value' => $address,
        'show_error_message' => false
    ],
];

return [
    'config_prefix' => 'contacts',
    'placeholders' => $data,
];
