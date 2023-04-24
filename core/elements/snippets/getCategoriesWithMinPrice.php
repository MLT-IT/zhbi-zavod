<?php

class getCategoriesWithMinPrice {

    static protected $brandsIds;

    static protected $brandsAndCategories;

    static protected function getBrandsMinPrices() {
        global $modx;

        // Устанавливаем переменные
        $select = [];
        $join = '';
        foreach (self::$brandsAndCategories as $brand => $categoriesIds) {
            $select[] = "REPLACE(MIN($brand.price), '.00', '') AS $brand";
            $join .= "LEFT JOIN modx_ms2_products as $brand ON $brand.id = resources.id AND resources.parent IN ($categoriesIds)";
        }
        $select = implode(',', $select);

        // Составляем SQL-запрос
        $query = "SELECT $select
        FROM modx_site_content AS resources
        INNER JOIN modx_ms2_products AS products ON products.id = resources.id 
        $join";

        // Выполняем SQL-запрос
        $data = $modx->query($query);
        $data = $data->fetchAll(PDO::FETCH_ASSOC);
        $data = reset($data);

        // Заменяем ключи
        $result = [];
        foreach ($data as $key => $val) {
            $result[self::$brandsIds[$key]] = $val;
        }

        // Возвращаем значение
        return $result;
    }

    static protected function getBrandsValues() {
        global $modx;

        $brands = array_keys(self::$brandsAndCategories);
        $resources = array_map(function ($val) {
            return self::$brandsIds[$val];
        }, $brands);

        $resources = implode(',', $resources);
        $params = [
            'resources' => $resources,
            'parents' => 0,
            'depth' => 50,
            'limit' => 0,
            'sortby' => 'FIELD(modResource.id, ' . $resources . ')',
            'sortdir' => 'ASC',
            'tplWrapper' => '@INLINE { [[+output]] }',
            'includeTVs' => 'mainImage',
            'tpl' => '@FILE chunks/category-with-min-price-json.tpl',
        ];
        $json = $modx->runSnippet('pdoResources', $params);
        $json = str_replace('}, }', '} }', $json);
        $data = json_decode($json, 1);

        return $data;
    }

    static public function getValues() {
        self::setVarsByContext();
        $brandsMinPrices = self::getBrandsMinPrices();
        $brandsValues = self::getBrandsValues();
        foreach ($brandsMinPrices as $key => $val) {
            $brandsValues[$key]['minprice'] = $val;
        }

        return $brandsValues;
    }

    static protected function setVarsByContext() {
        global $modx;

        switch ($modx->resource->context_key) {
            case 'web':
                static::$brandsIds = [
                    'knauf' => 93185,
                    'rockwool' => 93190,
                    'tn' => 93191,
                    'penoplex' => 93189,
                    'isover' => 93187,
                    'paroc' => 93188,
                    'ursa' => 93192,
                    'isorok' => 93186
                ];
                static::$brandsAndCategories = [
                    'knauf' => '93193,93194,93195,93196,93197,93198,93199,93200,93201,93202,93203,93204,93205,93206,93207,93208,93209,93210,93211,93212,93213,93214,93215,93216,93217,93218,93219,93220,93221,93222,93223,93224,93225,93226,93227,93228,93229,93230,93231,93232',

                    'rockwool' => '93456,93457,93458,93459,93460,93461,93462,93463,93464,93465,93466,93467,93468,93469,93470,93471,93472,93473,93474,93475,93476,93477,93478,93479,93480,93481,93482,93483,93484,93485,93486,93487,93488,93489,93490,93491,93492,93493,93494,93495,93496,93497,93498,93499,93500,93501,93502,93503,93504,93505,93506,93507,93508,93509,93510,93511,93512,93513,93514,93515,93516,93517,93518,93519,93520,93521,93522,93523,93524',

                    'tn' => '93525,93526,93527,93528,93529,93530,93531,93532,93533,93534,93535,93536,93537,93538,93539,93540,93541,93542,93543,93544,93545,93546,93547,93548,93549,93550,93551,93552,93553,93554,93555,93556,93557,93558,93559,93560,93561,93562,93563,93564,93565,93566,93567,93568,93569,93570,93571,93572,93573,93574,93575,93576,93577,93578,93579,93580,93581,93582,93583,93584,93585,93586,93587,93588,93589,93590,93591,93592,93593,93594,93595,93596,93597,93598,93599,93600,93601,93602,93603,93604,93605,93606,93607,93608,93609,93610,93611,93612,93613,93614,93615,93616,93617,93618,93619,93620,93621,93622,93623,93624,93625,93626,93627,93628,93629,93630',

                    'penoplex' => '93441,93442,93443,93444,93445,93446,93447,93448,93449,93450,93451,93452,93453,93454,93455',

                    'isover' => '93261,93262,93263,93264,93265,93266,93267,93268,93269,93270,93271,93272,93273,93274,93275,93276,93277,93278,93279,93280,93281,93282,93283,93284,93285,93286,93287,93288,93289,93290,93291,93292,93293,93294,93295,93296,93297,93298,93299,93300,93301,93302,93303,93304,93305,93306,93307,93308,93309,93310,93311,93312,93313,93314,93315,93316,93317,93318,93319,93320,93321,93322,93323,93324,93325,93326,93327',

                    'paroc' => '93328,93329,93330,93331,93332,93333,93334,93335,93336,93337,93338,93339,93340,93341,93342,93343,93344,93345,93346,93347,93348,93349,93350,93351,93352,93353,93354,93355,93356,93357,93358,93359,93360,93361,93362,93363,93364,93365,93366,93367,93368,93369,93370,93371,93372,93373,93374,93375,93376,93377,93378,93379,93380,93381,93382,93383,93384,93385,93386,93387,93388,93389,93390,93391,93392,93393,93394,93395,93396,93397,93398,93399,93400,93401,93402,93403,93404,93405,93406,93407,93408,93409,93410,93411,93412,93413,93414,93415,93416,93417,93418,93419,93420,93421,93422,93423,93424,93425,93426,93427,93428,93429,93430,93431,93432,93433,93434,93435,93436,93437,93438,93439,93440',

                    'ursa' => '93631,93632,93633,93634,93657,93650,93651,93652,93645,93646,93647,93648,93649,93635,93636,93637,93638,93639,93640,93641,93642,93643,93644,93653,93654,93655,93656,93658,93659,93660,93661,93662,93663,93664,93665,93666,93667,93668',

                    'isorok' => '93233,93234,93235,93236,93237,93238,93239,93240,93241,93242,93243,93244,93245,93246,93247,93248,93249,93250,93251,93252,93253,93254,93255,93256,93257,93258,93259,93260'
                ];
                break;
            case 'gazosilikatstroy':
                static::$brandsIds = [
                    'lsr' => 101938,
                    'sk' => 101936,
                    'eab' => 101934,
                    'aeroc' => 101932,
                    'mogil' => 101937,
                    'bck' => 101929,
                    'hh' => 101930,
                    'bonolit' => 101933,
                    'zabudova' => 101935,
                    'ytong' => 101931
                ];
                static::$brandsAndCategories = static::$brandsIds;
                break;
        }
    }
}

$cacheName = 'getCategoriesWithMinPrice';
$cacheOptions = [
    xPDO::OPT_CACHE_KEY => 'default/file_snippets/' . $cacheName . '/' . $modx->context->key . '/',
];

// Получаем данные
if (!$result = $modx->cacheManager->get($cacheName, $cacheOptions)) {
    $result = getCategoriesWithMinPrice::getValues();
    $modx->cacheManager->set($cacheName, $result, 0, $cacheOptions);
};

// Оборачиваем данные в чанк
$pdo = $modx->getService('pdoTools');
$result = array_map(function ($v) use ($pdo) {
    return $pdo->getChunk('@FILE sections/pop-slide.tpl', $v);
}, $result);

$result = implode('', $result);

return $result;
