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
