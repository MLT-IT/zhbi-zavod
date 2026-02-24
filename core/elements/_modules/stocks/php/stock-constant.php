<?php

const MIN_STOCKS = 50; // минимальное количество товаров в наличии на складе
const MAX_STOCKS = 100; // максимальное количество товаров в наличии на складе
const MIN_LIMIT_STOCKS = 1; // минимальное количество товаров в наличии на складе с лимитом
const MAX_LIMIT_STOCKS = 5; // максимальное количество товаров в наличии на складе с лимитом
const MIN_NOT_STOCKS = 0; // минимальное количество товаров в наличии на складе без остатков
const MAX_NOT_STOCKS = 0; // максимальное количество товаров в наличии на складе без остатков

const CACHE_TIME = 86400; // время кэширования
const CACHE_KEY = "/stockTemplate/"; // ключ кэширования

const STOCKS = [ // массив складов
    [
        "title" => "Дачное",
        "url" => "/dachnoe/"
    ],
    [
        "title" => "Янино-1",
        "url" => "/yanino-1/"
    ],
    [
        "title" => "Шушары",
        "url" => "/shushary/"
    ],
    [
        "title" => "Парголово",
        "url" => "/pargolovo/"
    ],
    [
        "title" => "Металлострой",
        "url" => "/metallostroy/"
    ],
];

if (!function_exists('getStocksNamesByContext')) {
    function getStocksNamesByContext($context)
    {
        $context = (string)$context;

        return STOCKS;
    }
}

if (!function_exists('getStockDistributionByTemplate')) {
    function getStockDistributionByTemplate($templateId, $stocksCount)
    {
        $templateId = (int)$templateId;
        $stocksCount = max(0, (int)$stocksCount);

        $limitStocks = 0;
        $notStocks = 0;

        switch ($templateId) {
            case 1:
                $limitStocks = min(2, $stocksCount);
                $notStocks = 0;
                break;
            case 2:
                $limitStocks = min(2, $stocksCount);
                $notStocks = max($stocksCount - $limitStocks, 0);
                break;
            case 3:
                $limitStocks = 0;
                $notStocks = $stocksCount;
                break;
            case 4:
                $limitStocks = 0;
                $notStocks = 0;
                break;
            default:
                $limitConstName = "TEMPLATE_{$templateId}_COUNT_LIMIT_STOCKS";
                $notConstName = "TEMPLATE_{$templateId}_COUNT_NOT_STOCKS";
                $limitStocks = defined($limitConstName) ? (int)constant($limitConstName) : 0;
                $notStocks = defined($notConstName) ? (int)constant($notConstName) : 0;
                break;
        }

        $limitStocks = max(0, min($stocksCount, $limitStocks));
        $notStocks = max(0, min($stocksCount - $limitStocks, $notStocks));

        return [
            'limitStocks' => $limitStocks,
            'notStocks' => $notStocks,
        ];
    }
}

if (!function_exists('getStockTemplateRangeValue')) {
    function getStockTemplateRangeValue(array $template, $field)
    {
        $value = array_key_exists($field, $template) ? $template[$field] : null;
        $templateId = isset($template['template']) ? (int)$template['template'] : 0;

        if ($value === null) {
            return null;
        }

        if (is_string($value)) {
            $value = trim($value);
            if ($value === '') {
                return $templateId === 4 ? null : 0;
            }
        }

        return (int)$value;
    }
}

const TEMPLATE_1_COUNT_LIMIT_STOCKS = 2; // количество складов с лимитом для шаблона 1
const TEMPLATE_1_COUNT_NOT_STOCKS = 0; // количество складов без остатков для шаблона 1

const TEMPLATE_2_COUNT_LIMIT_STOCKS = 2; // количество складов с лимитом для шаблона 2
const TEMPLATE_2_COUNT_NOT_STOCKS = 3; // количество складов без остатков для шаблона 2

const TEMPLATE_3_COUNT_LIMIT_STOCKS = 0; // количество складов с лимитом для шаблона 3
const TEMPLATE_3_COUNT_NOT_STOCKS = 5; // количество складов без остатков для шаблона 3

const TEMPLATE_4_COUNT_LIMIT_STOCKS = 0; // количество складов с лимитом для шаблона 3
const TEMPLATE_4_COUNT_NOT_STOCKS = 0; // количество складов без остатков для шаблона 3
