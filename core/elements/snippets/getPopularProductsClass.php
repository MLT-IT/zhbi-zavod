<?php

// TODO: Возможно, в алгоритме надо учитывать доп. категории ("Показывать в категориях"). Но пока никто не просил меня это реализовывать.

class getPopularProductsClass {

    protected static $debug = []; // Массив, в котором хранятся сообщения о поиске популярных (рекомендуемых) товаров

    // Текстовые переменные для заполнения $debug
    protected static $textStd = 'значение для стандартных случаев';
    protected static $textSpecial = 'значение для особых случаев';

    protected static $prod; // Товар, к которому подбираются популярные (рекомендуемые) товары

    protected static $resultStd = []; // Возвращаемое значение в стандартных случаях или в случае ошибки
    protected static $resultSpecial = []; // Возвращаемое значение в особых случаях (которые описаны в этом классе)

    protected static $specificCtxs = [];

    /**
     * Установка основных полей класса.
     */
    protected static function init() {
        global $modx;
        global $scriptProperties;

        $prodId = null;
        $prodIdText = 'id товара, для которого будут выводиться популярные товары';

        if (empty($scriptProperties['prodId'])) {
            self::$debug[] = 'В $scriptProperties отсутствует параметр prodId (' . $prodIdText . '). Поэтому взят id текущего товара (' . $modx->resource->id . ').';
            $prodId = $modx->resource->id;
        } else {
            self::$debug[] = 'Получен параметр prodId (' . $prodIdText . ') из $scriptProperties (' . $scriptProperties['prodId'] . ').';
            $prodId = $scriptProperties['prodId'];
        }

        // TODO: здесь нужен exception - вдруг не получилось найти товар с таким id
        self::$prod = $modx->getObject('modResource', $prodId);

        $defaultParams = [
            'resources' => '-' . $prodId,
            'parents' => 0,
            'depth' => 50,
            'limit' => 42,
            'tpl' => '@FILE chunks/product/listing-products-item-slide.tpl',
            'tplWrapper' => '@FILE sections/related-products.tpl',
            'includeTVs' => 'isFractional,productNotAvailable,freeShipping',
            'context' => self::$prod->context_key,
            'wrapIfEmpty' => 0
        ];
        self::$resultStd = self::$resultSpecial = $defaultParams;
    }


    /**
     * Попытка получить строку с id ресурсов извне (из $scriptProperties или из настроек контекста).
     */
    protected static function tryGetResourcesFromOutside() {
        global $scriptProperties;
        global $modx;

        if (in_array(self::$prod->context_key, self::$specificCtxs)) {
            self::$resultStd = [];
        }

        // Попробуем получить значение из $scriptProperties
        if (!empty($scriptProperties['resources'])) {
            self::$resultStd = self::addResourcesAndSort(self::$resultStd, $scriptProperties['resources']);
            self::$debug[] = 'Получен параметр resources из $scriptProperties: ' . $scriptProperties['resources'] . '.';
        } else {
            self::$debug[] = 'В $scriptProperties отсутствует параметр resources.';

            // TODO: здесь нужно сделать рекурсивный SQL запрос и узнать id самого верхнего родителя. И в зависимости от этого id получать настройки контекста.
            // Попробуем получить значение из настроек контекста
            $contextSettingKey = 'popular_ids_' . $modx->resource->context_key;
            $resources = $modx->context->getOption($contextSettingKey);
            if (empty($resources)) {
                self::$debug[] = "Не удалось получить значение $contextSettingKey из настроек контекста (или оно пустое).";
            } else {
                self::$resultStd = self::addResourcesAndSort(self::$resultStd, $resources);
                self::$debug[] = "Получено значение $contextSettingKey из настроек контекста: $resources.";
            }
        }
    }


    /**
     * Удобная обертка для return.
     */
    protected static function rtn($params) {
        return [
            'params' => $params,
            'params_default' => self::$resultStd,
            'debug' => self::$debug
        ];
    }


    /**
     * Добавляет в массив $params ключи "resources" и "sortby" со значениями на основе параметра $resources.
     */
    protected static function addResourcesAndSort($params, $resources) {
        return array_merge($params, [
            'resources' => $resources,
            'sortby' => "FIELD(msProduct.id, $resources)"
        ]);
    }


    /**
     * Главная открытая функция класса.
     * @return array
     */
    public static function getPopularProductsParams() {
        // Устанавливаем основные поля класса
        self::init();

        // Возможно, популярные (рекомендуемые) товары есть у ресурса в tv и ничего вычислять не надо
        $recommendIds = self::$prod->getTVValue('recommendIds');
        if ($recommendIds) {
            self::$debug[] = 'Популярные (рекомендуемые) товары получены из tv recommendIds: ' . $recommendIds;
            self::$resultStd = self::addResourcesAndSort(self::$resultStd, $recommendIds);
            return self::rtn(self::$resultStd);
        }

        // Попробуем получить строку с id ресурсов извне и записать в $resultStd
        self::tryGetResourcesFromOutside();

        // Вывод для неспецифичных контекстов
        // Если для текущего контекста нет логики в этом скрипте, то возвращаем значение для стандартных случаев
        if (!in_array(self::$prod->context_key, self::$specificCtxs)) {
            self::$debug[] = "Контекст не является специфичным (специфичные: " . implode(', ', self::$specificCtxs) . "). Возвращено self::$textStd.";
            return self::rtn(self::$resultStd);
        }

        // Получение ресурсов для специфичных контекстов
        //switch (self::$prod->context_key) {
        //    case 'kirpich-m':
        //        $resources = self::kirpich();
        //        break;
        //
        //    case 'krovlya':
        //        $resources = self::krovlya();
        //        break;
        //}

        if ($resources === false) {
            return self::rtn(self::$resultStd);
        }

        self::$resultSpecial = self::addResourcesAndSort(self::$resultSpecial, $resources);
        self::$resultSpecial['limit'] = 300;
        self::$debug[] = "Возвращено " . self::$textSpecial . ".";
        return self::rtn(self::$resultSpecial);
    }
}

$cacheName = 'getPopularProductsClass';
$cacheOptions = [
    xPDO::OPT_CACHE_KEY => 'default/file_snippets/' . $cacheName . '/' . $modx->context->key . '/' . $modx->resource->id,
];

if (!$params = $modx->cacheManager->get($cacheName, $cacheOptions)) {
    $data = getPopularProductsClass::getPopularProductsParams();
    $params = $data['params'];
    $modx->cacheManager->set($cacheName, $params, 0, $cacheOptions);
}

if (!empty($params['resources'])) {
    $result = $modx->runSnippet('msProductsMy', $params);
} else {
    $result = '';
}

return $result;
