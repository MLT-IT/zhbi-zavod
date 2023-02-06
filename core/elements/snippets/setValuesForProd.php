<?php

// id товара, нужен для добавления товара в корзину
$prodId = $src['id'];
// Ключ товара, нужен для изменения товара в корзине
$productKey = str_replace(' ', '', $src['id'] . $src['price'] . $src['weight'] . '[]');

// Цена по умолчанию - нужна для расчета других цен на JS
$defaultPrice = str_replace([',', ' '], ['.', ''], $src['price']);
// Цена для красивого вывода
$outputPrice = str_replace(',', '.', preg_replace('/\B(?=(\d{3})+(?!\d))/', ' ', $src['price']));

// Старая цена
if ($src['old_price']) {
    // Цена по умолчанию
    $defaultOldPrice = str_replace([',', ' '], ['.', ''], $src['old_price']);
    // Цена для красивого вывода
    $outputOldPrice = str_replace(',', '.', preg_replace('/\B(?=(\d{3})+(?!\d))/', ' ', $src['old_price']));
}

