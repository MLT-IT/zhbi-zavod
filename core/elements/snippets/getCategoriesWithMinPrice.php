<?php

class getCategoriesWithMinPrice
{

    static protected $brandsIds;
    static protected $brandsAndCategories;
    static protected $customPrices;

    static protected function getBrandsMinPrices()
    {
        global $modx;

        if (empty(self::$brandsAndCategories)) {
            echo "Пустой массив brandsAndCategories";
            return;
        }

        // Устанавливаем переменные
        $select = [];
        $join = '';
        foreach (self::$brandsAndCategories as $brand => $categoriesIds) {
            $select[] = "REPLACE(MIN($brand.price), '.00', '') AS $brand";
            $join .= " LEFT JOIN modx_ms2_products as $brand ON $brand.id = resources.id AND resources.parent IN ($categoriesIds)";
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
            if (!empty(self::$customPrices) && isset(self::$customPrices[$key])) {
                $result[self::$brandsIds[$key]] = self::$customPrices[$key];
            } else {
                $result[self::$brandsIds[$key]] = $val != NULL ? $val : '0'; // пришлось добавить по умолчанию 0, у некоторых brandsIds нет детей
            }
        }
        
        // Возвращаем значение
        return $result;
    }

    static protected function getBrandsValues()
    {
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

    static public function getValues()
    {
        self::setVarsByContext();
        $brandsMinPrices = self::getBrandsMinPrices();
        $brandsValues = self::getBrandsValues();
        foreach ($brandsMinPrices as $key => $val) {
            $brandsValues[$key]['minprice'] = $val;
            $brandsValues[$key]['key'] = $key;
        }

        return $brandsValues;
    }

    static protected function setVarsByContext()
    {
        global $modx;

        switch ($modx->resource->context_key) {
            // case 'web':
            //     static::$brandsIds = [
            //         'rockwool' => 93190,
            //         'tn' => 93191,
            //         'penoplex' => 93189,
            //         'knauf' => 93185,
            //         'paroc' => 93188,
            //         'ursa' => 93192,
            //         'isover' => 93187,
            //         'isorok' => 93186,
            //         'umatex' => 124718,
            //         '167261x' => 167261,
            //         '167260x' => 167260,
            //         '167262x' => 167262,
            //         '167263x' => 167263,
            //         '167265x' => 167265,
            //         '167264x' => 167264,
            //         '167266x' => 167266,
            //         '167718x' => 167718,
            //         '167657x' => 167657,
            //         '167836x' => 167836,
            //         '167217x' => 167217,
            //         '168218x' => 168218,
            //         '168256x' => 168256,
            //         '168257x' => 168257,
            //         '168258x' => 168258,
            //         '175241x' => 175241,
            //     ];
            //     static::$brandsAndCategories = [
            //         'rockwool' => '93456,93457,93458,93459,93460,93461,93462,93463,93464,93465,93466,93467,93468,93469,93470,93471,93472,93473,93474,93475,93476,93477,93478,93479,93480,93481,93482,93483,93484,93485,93486,93487,93488,93489,93490,93491,93492,93493,93494,93495,93496,93497,93498,93499,93500,93501,93502,93503,93504,93505,93506,93507,93508,93509,93510,93511,93512,93513,93514,93515,93516,93517,93518,93519,93520,93521,93522,93523,93524',
            //         'tn' => '93525,93526,93527,93528,93529,93530,93531,93532,93533,93534,93535,93536,93537,93538,93539,93540,93541,93542,93543,93544,93545,93546,93547,93548,93549,93550,93551,93552,93553,93554,93555,93556,93557,93558,93559,93560,93561,93562,93563,93564,93565,93566,93567,93568,93569,93570,93571,93572,93573,93574,93575,93576,93577,93578,93579,93580,93581,93582,93583,93584,93585,93586,93587,93588,93589,93590,93591,93592,93593,93594,93595,93596,93597,93598,93599,93600,93601,93602,93603,93604,93605,93606,93607,93608,93609,93610,93611,93612,93613,93614,93615,93616,93617,93618,93619,93620,93621,93622,93623,93624,93625,93626,93627,93628,93629,93630',
            //         'penoplex' => '93441,93442,93443,93444,93445,93446,93447,93448,93449,93450,93451,93452,93453,93454,93455',
            //         'knauf' => '93193,93194,93195,93196,93197,93198,93199,93200,93201,93202,93203,93204,93205,93206,93207,93208,93209,93210,93211,93212,93213,93214,93215,93216,93217,93218,93219,93220,93221,93222,93223,93224,93225,93226,93227,93228,93229,93230,93231,93232',
            //         'paroc' => '93328,93329,93330,93331,93332,93333,93334,93335,93336,93337,93338,93339,93340,93341,93342,93343,93344,93345,93346,93347,93348,93349,93350,93351,93352,93353,93354,93355,93356,93357,93358,93359,93360,93361,93362,93363,93364,93365,93366,93367,93368,93369,93370,93371,93372,93373,93374,93375,93376,93377,93378,93379,93380,93381,93382,93383,93384,93385,93386,93387,93388,93389,93390,93391,93392,93393,93394,93395,93396,93397,93398,93399,93400,93401,93402,93403,93404,93405,93406,93407,93408,93409,93410,93411,93412,93413,93414,93415,93416,93417,93418,93419,93420,93421,93422,93423,93424,93425,93426,93427,93428,93429,93430,93431,93432,93433,93434,93435,93436,93437,93438,93439,93440',
            //         'ursa' => '93631,93632,93633,93634,93657,93650,93651,93652,93645,93646,93647,93648,93649,93635,93636,93637,93638,93639,93640,93641,93642,93643,93644,93653,93654,93655,93656,93658,93659,93660,93661,93662,93663,93664,93665,93666,93667,93668',
            //         'isover' => '93261,93262,93263,93264,93265,93266,93267,93268,93269,93270,93271,93272,93273,93274,93275,93276,93277,93278,93279,93280,93281,93282,93283,93284,93285,93286,93287,93288,93289,93290,93291,93292,93293,93294,93295,93296,93297,93298,93299,93300,93301,93302,93303,93304,93305,93306,93307,93308,93309,93310,93311,93312,93313,93314,93315,93316,93317,93318,93319,93320,93321,93322,93323,93324,93325,93326,93327',
            //         'isorok' => '93233,93234,93235,93236,93237,93238,93239,93240,93241,93242,93243,93244,93245,93246,93247,93248,93249,93250,93251,93252,93253,93254,93255,93256,93257,93258,93259,93260',
            //         'umatex' => '124747,124738,124739,124740,124741,124742,124743,124744,124745,124746,124737,124748,124749,124750,124751,124752,124753,124754,124755,124728,124720,124721,124722,124723,124724,124725,124726,124727,124719,124729,124730,124731,124732,124733,124734,124735,124736',
            //         '167261x' => 167261,
            //         '167260x' => 167260,
            //         '167262x' => 167262,
            //         '167263x' => 167263,
            //         '167265x' => 167265,
            //         '167264x' => 167264,
            //         '167266x' => 167266,
            //         '167718x' => 167718,
            //         '167657x' => 167657,
            //         '167836x' => 167836,
            //         '167217x' => 167217,
            //         '168218x' => 168218,
            //         '168256x' => 168256,
            //         '168257x' => 168257,
            //         '168258x' => 168258,
            //         '175241x' => 175241,
            //     ];
            //     static::$customPrices = [
            //         'rockwool' => 999,
            //         'tn' => 1050,
            //         'penoplex' => 105,
            //         'knauf' => 1490,
            //         'paroc' => 2100,
            //         'ursa' => 989,
            //         'isover' =>  995,
            //         'isorok' =>  995,
            //         'umatex' =>  2000,
            //         '167261x' => 980,
            //         '167260x' => 1005,
            //         '167262x' => 990,
            //         '167263x' => 1100,
            //         '167265x' => 1205,
            //         '167264x' => 1290,
            //         '167266x' => 1300,
            //         '167718x' => 1500,
            //         '167657x' => 1780,
            //         '167836x' => 1490,
            //         '167217x' => 1600,
            //         '168218x' => 1370,
            //         '168256x' => 1500,
            //         '168257x' => 1270,
            //         '168258x' => 1600,
            //         '175241x' => 1200,
            //     ];
            //     break;

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
            case 'plitnye':
                static::$brandsIds = [
                    'fanera' => 178116,
                    'gipsokarton' => 177263,
                    'dsp' => 177282,
                    'osb' => 177289,
                    'csp' => 177299,
                    'gidrovolokno' => 177264,
                    'mdvp' => 177042,
                    'fibrolit' => 177296,

                ];
                // static::$brandsAndCategories = static::$brandsIds;
                static::$brandsAndCategories = [
                    "fanera" => "178143,178151,178150,178149,178148,178147,178146,178145,178144,178142,178141,178140,178152,178153,178154,178128,178125,178126,178124,178127,178277,178276,178275,178274,178273,178269,178268,178267,178263,178262,178257,178256,178255,178254",
                    "gipsokarton" => "177276,230952,230951,230950,230949,177295,177281,177280,177279,177278,177277,177266,177275,177274,177273,177272,177271,177270,177269,177268,177267",
                    "dsp" => "180053,180054,180055,177283,177285,177286,177287,177288",
                    "osb" => "177290,177291,177292,177293,177294",
                    "csp" => "177300",
                    "gidrovolokno" => "177265,177301",
                    "mdvp" => "177055,230902,183470,183469,183468,183467,183466,177060,177059,177058,177057,177056,177044,177054,177053,177052,177051,177050,177049,177048,177047,177046,177045",
                    "fibrolit" => "177297,177298",
                ];
                // ПОЧЕМУ для ЦСП криво работает - я не понял, сделал заглушку 
                static::$customPrices = [
                    "fanera" =>  202,
                    "gipsokarton" =>  228,
                    "dsp" =>  581,
                    "osb" =>  248,
                    "csp" =>  273,
                    "gidrovolokno" =>  240,
                    "mdvp" =>  124,
                    "fibrolit" =>  354,
                ];
                break;

            case 'profnastil':
                static::$brandsIds = [
                    'fanera' => 218619,
                    'gipsokarton' => 218600,
                    'ldsp' => 218645,
                ];
                static::$brandsAndCategories = static::$brandsIds;
                break;
                
            case 'gbi-zavod78':
                static::$brandsIds = [
                    'dorsroy' => 255831,
                    'zhilstroy' => 255835,
                    'elzhogr' => 255833,
                    'communic' => 255834,
                    'zheleznodor' => 255836,
                    'energ' => 255837,
                    'most' => 255870,
                    'bu' => 255832,
                    'blago' => 255830
                ];
                static::$brandsAndCategories = static::$brandsIds;
                break;

            case 'gibkaya-cherepiza':
                static::$brandsIds = [
                    'fanera' => 229624,
                    'gipsokarton' => 229631,
                    'ldsp' => 229640,
                    'fanera1' => 229646,
                    'gipsokarton2' => 229670,
                    'ldsp3' => 229672,
                ];
                static::$brandsAndCategories = static::$brandsIds;
                break;
            case 'falcevaya-krovlya':
                static::$brandsIds = [
                    'fanera' => 220387,
                    'gipsokarton' => 220397,
                ];
                static::$brandsAndCategories = static::$brandsIds;
                break;
            case 'metallocherepica':
                static::$brandsIds = [
                    'fanera' => 226928,
                    'gipsokarton1' => 226933,
                    'gipsokarton' => 226942,
                ];
                static::$brandsAndCategories = static::$brandsIds;
                break;
            case 'stenovye':
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
            case 'kraska':
                static::$brandsIds = [
                    'grunty' => 102922,
                    // 'voddis' => 103255, // seo категория, не хочет выбирать, надо бы tv поле добавить и его читать
                    'pokder' => 103193,
                    'emali' => 117397,
                    'laki' => 113157,
                    'rastvoch' => 112001,
                    'coleri' => 119822,
                    'shpat' => 107936,
                    'instr' => 120953,
                    'dobsuh' => 107935,
                ];
                static::$brandsAndCategories = [
                    'grunty' => '102922,103081,103082,103462,103463,107934',
                    // 'voddis' => '103255',
                    'pokder' => '103193,103194,103471,106607,112002,112003,115691',
                    'emali' => '117397',
                    'laki' => '113157',
                    'rastvoch' => '112001,120195,120210',
                    'coleri' => '119822',
                    'shpat' => '107936,117692',
                    'instr' => '120953',
                    'dobsuh' => '107935',
                ];

                // static::$brandsAndCategories = [];
                foreach (static::$brandsIds as $key => $value) {
                    $childCats = $modx->runSnippet('pdoResources', [
                        // 'tpl' => '@INLINE {$id},',
                        'returnIds' => 1,
                        'parents' => $value,
                        'limit' => 0,
                        'select' => 'id',
                        'depth' => 999,
                        'where' => '{"class_key":"msCategory"}'
                    ]);
                    static::$brandsAndCategories[$key] = $childCats ? static::$brandsIds[$key] . ',' . $childCats : static::$brandsIds[$key];
                }
                // var_dump(static::$brandsAndCategories);
                break;

            case 'suhiesmesi':
                static::$brandsIds = [
                    //123488, 123489, 123490,  123491,  123492,  123493,  123494,  123495,  123496,  123497,  123498, 123499
                    'cement' => 123488,
                    'cps' => 123489,
                    'cley_gazobeton' => 123490,
                    'cley_uteplitel' => 123491,
                    'cley_pgp' => 123492,
                    'cley_plitka' => 123493,
                    'cladochnie_smesi' => 123494,

                    'shtukaturka' => 123495,
                    'gruntovka' => 123496,
                    'smesi_pol' => 123497,
                    'shpatlevka' => 123498,
                    'dobavki' => 123499,
                ];
                static::$brandsAndCategories = static::$brandsIds;
                break;

            case 'beltermo':
                static::$brandsIds = [


                    'top' => 183965,
                    'floor' => 183966,
                    'ultra' => 183967,
                    'acoustic' => 183968,
                    'underfloor' => 183969,
                    'protection' => 183970,
                    'room' => 183971,
                    'kombi' => 183972,
                    'universal' => 183973,
                    'flex' => 183974,
                    'multi' => 183975,
                    'safe' => 183976,
                    'instal' => 183977,
                    'zell' => 183978,
                    'mulcha' => 183979,
                ];
                static::$brandsAndCategories = static::$brandsIds;
                break;

            case 'krovelnyjstroymarket':
                static::$brandsIds = [
                    'cherepitsa' => 125530,
                    'gibkayacherepitsa' => 125532,
                    'proflist' => 125537,
                    'shtaketnik' => 125541,
                    'rulonaykrovlay' => 125538,
                    'cementnoPesochnayCherepitsa' => 125536,
                    'keramichheskayCherepitsa' => 125534,
                    'faltsevayKrovlay' => 125535,
                    'ondulin' => 125531,
                    'shifer' => 125540,
                    'vodostochnaySystema' => 125528,
                    'sofiti' => 125539,
                    'dobornieElementiKrovly' => 125533,
                    'komplektuyshie' => 125529,
                ];
                static::$brandsAndCategories = [
                    'cherepitsa' => '125628,125629,125630,125631,125632,125633,166018,166019,166020,166021,166022,166023,166024,166025,166026,166027,166028,166029,166997,166998',
                    'gibkayacherepitsa' => '125581,125582,125583,125584,125585,125586,125587,125588,125548,125549,125550,125551,125552,125553,125608,125609,125614,125615,125616,125610,125611,125612,125613,125594,125595,125596,125597,125598,125599,125600,125601,125602,125603,125604,125605,125606,125607,125589,125590,125591,125592,125593,125643,125644,125645,125646,125647,125639,125640,125641,125642,125634,125635,125636,125637,125638,125542,125543,125544,125545,125546,125547',
                    'proflist' => '126301,126302,126303,126304,126305,126306,126307,126308,126309,126310',
                    'shtaketnik' => 126138,
                    'rulonaykrovlay' => 125759,
                    'cementnoPesochnayCherepitsa' => '125741,125742,125743',
                    'keramichheskayCherepitsa' => '126077,126078,126079,126080,126081,126082,126083,126084,126085,126086,126087,126088,126089,126090,126091,125745,125746',
                    'faltsevayKrovlay' => 125728,
                    'ondulin' => '125621',
                    'shifer' => 125540,
                    'sofiti' => 126039,
                    'dobornieElementiKrovly' => '126659,126660,126658,125999,126000,125998,125996,125997,125995,126068,126069,125993,125994,125658,125659,125660,125656,125657,126058,126059,126060,125972,125969,125970,125971,125648,125649,125575,125576,125577,125578,125579,125580,125982,125983,125981,126066,126067,125987,125988,125989,125990,125991,125985,125986,125992,125984,125980,125979,126063,126064,126065,126321,126322,126323,126244,126245,126246,126247,126248,126249,126250,126251,126252,126253,125654,125655,125568,125569,125570,125571,125572,125573,125574,126061,126062,125652,125653,125650,125651,126056,126057,126055,125975,125976,125977,125978,125973,125974,125946,125947,125948,125944,125945,125943,125937,125938,125939,125940,125941,125942,125936,126215,126216,126217,126218,126219,126213,126214,125959,125960,125961,125968,125966,125967,125962,125963,125964,125965,125954,125955,125956,125957,125958,125949,125950,125951,125952,125953,125554,125555,125556,125557,125558,125559,125560,125561,125562,125563,125564,125565,125566,125567,126657',
                    'komplektuyshie' => '126524,126522,126523,126516,126517,126518,126519,126520,126521,126511,126512,126513,126514,126515,126510,126505,126506,126507,126508,126509,126502,126503,126504,126500,126501,126494,126495,126496,126497,126498,126499,126488,126489,126490,126491,126492,126493,126032,126033,126027,126028,126029,126030,126031,126227,126228,126229,126230,126231,126532,126242,126238,126239,126240,126241,126021,126022,126023,126024,126025,126026,126473,126474,126475,126476,126477,126478,126479,126480,126481,126482,126483,126484,126485,126486,126487,126043,126530,126531,126537,126538,126536,126236,126237,126158,126092,126093,126094,126095,126096,126097,126098,126099,126100,126101,126102,126103,126104,126105,126106,126107,126108,126109,126110,126111,126112,126113,126114,126115,126116,126117,126118,126119,126120,126121,126122,126337,126338,126339,126340,126335,126336,126334,126327,126328,126329,126330,126331,126332,126333,126324,126325,126326,126651,126652,126653,126648,126649,126650,126642,126643,126644,126645,126646,126647,126634,126635,126636,126637,126638,126639,126640,126641,126654,126655,126656,126630,126631,126632,126633,126623,126624,126625,126626,126627,126628,126629,126528,126232,126053,126049,126050,126051,126052,126352,126353,126349,126350,126351,126588,126589,126590,126580,126581,126582,126583,126584,126585,126586,126587,126591,126592,126593,126594,126595,126596,126597,126598,126575,126576,126577,126578,126579,126570,126571,126572,126573,126574,126600,126599,126526,126525,126343,126344,126345,126346,126607,126608,126609,126610,126611,126612,126613,126614,126615,126616,126617,126618,126619,126620,126621,126622,126601,126602,126603,126604,126605,126606,126527,126288,126534,126569,126284,126285,126286,126287,126130,126131,126132,126133,126134,126135,126136,126137',
                ];
                break;

            case 'fibrofasad':
                static::$brandsIds = [
                    // 'ondulin' => 171056,
                    // 'shifer' => 171090,
                    // 'cherepitsa' => 171123,
                    // 'gibkayacherepitsa' => 171124,
                    // 'rulonaykrovlay' => 171126,
                    // 'cementnoPesochnayCherepitsa' => 171127,
                    // 'keramichheskayCherepitsa' => 171128,
                    // 'faltsevayKrovlay' => 171130,
                    // 'proflist' => 171132,
                    // 'shtaketnik' => 171133,
                    // 'vodostochnaySystema' => 171103,
                    // 'sofiti' => 171137,

                    // 'komplektuyshie1' => 171135,
                    // 'komplektuyshie2' => 171162,
                    // 'komplektuyshie3' => 171178,
                    // 'komplektuyshie4' => 171186,
                    
                    'ondulin' => 171090,
                    'shifer' => 171056,
                    'cherepitsa' => 171133,
                    'gibkayacherepitsa' => 171128,
                    'rulonaykrovlay' => 171123,
                    'cementnoPesochnayCherepitsa' => 171124,
                    'keramichheskayCherepitsa' => 171126,
                    'faltsevayKrovlay' => 171127,
                    'proflist' => 171130,
                    'shtaketnik' => 171132,
                ];
                
                static::$customPrices = [
                    'ondulin' => 476,
                    'shifer' => 790,
                    'cherepitsa' => 260,
                    'gibkayacherepitsa' => 448,
                    'rulonaykrovlay' => 3213,
                    'cementnoPesochnayCherepitsa' => 171,
                    'keramichheskayCherepitsa' => 1120,
                    'faltsevayKrovlay' => 690,
                    'proflist' => 420,
                    'shtaketnik' => 375
                ];
                static::$brandsAndCategories = static::$brandsIds;
                break;
                // тут не понятно, что вывести, пока оставлю (ted)
                // case 'tagnerud':
                //     static::$brandsIds = [
                //         'catalog' => 196905,
                //     ];
                //     static::$brandsAndCategories = static::$brandsIds;
                //     break;
            case 'kirpich-m5':
                /*
                    Ключ - алиас для таблицы с товарами, может быть любым
                    значение - одна категория, либо список через запятую. Категории будут выведены на фронтенд
                */
                static::$brandsIds = [
                    'oblicovochnyi' => 231027,
                    'stroitelnyi' => 231028,
                    'bruschatka' => 231029,
                    'dekor' => 231030,
                    'kamen' => 231031,
                    'kerambloki' => 231032,
                    'pechnoi' => 231033,
                    'kladochsmes' => 231034,
                    'lsr_kirpich' => 231035,
                    'peregorod_blok' => 231036,
                    'plitka_naves' => 231037,
                    'plitka_pechi_kam' => 231038,
                    'silikat_kirpich' => 231039,
                    'fasad_plit' => 231040,
                    'fasad_dekor' => 231041
                ];
                /*
                    Ключ - алиас для таблицы с товарами, может быть любым
                    значение - одна категория, лиюо список через запятую, по товарам которой определяется минимальная цена
                */
                static::$brandsAndCategories = [
                    'oblicovochnyi' => 231027,
                    'stroitelnyi' => 231028,
                    'bruschatka' => '231088,231089,231090',//231029,
                    'dekor' => 231030,
                    'kamen' => 231031,
                    'kerambloki' => 231032,
                    'pechnoi' => '231068,231069,231070,231071',//231033,
                    'kladochsmes' => '231083,231084,231085,231086,231087',//231034,
                    'lsr_kirpich' => '231074,231075',//231035,
                    
                    'peregorod_blok' => 231036,

                    'plitka_naves' => 231037,
                    'plitka_pechi_kam' => 231038,
                    'silikat_kirpich' => 231039,
                    'fasad_plit' => '231078,231079,231080',//231040,
                    'fasad_dekor' => '231081,321082'//231041 
                ];//static::$brandsIds;
                break;
            default:
                // тут надо бы какую-то базовую логику, тоже пока не понятно, повисит для мотивации (ted)
                // $catalogId = $modx->getObject('modResource', ['alias' => 'catalog'])->id;
                // $categories = $modx->runSnippet('pdoResources',[
                //     'returnIds' => 1,
                //     'depth' => 1,
                //     'where' => '{"class_key:=":"msCategory"}',
                // ]);
                // static::$brandsIds = [
                //     'catalog' => $catalogId,
                // ];
                // static::$brandsAndCategories = static::$brandsIds;
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
