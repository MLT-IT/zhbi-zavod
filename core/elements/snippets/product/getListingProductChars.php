<?php

$cacheFolder = 'getListingProductChars';
$cacheName = $src['id'];
$cacheOptions = [
    xPDO::OPT_CACHE_KEY => 'default/file_snippets/' . $cacheFolder . '/' . $src['context_key'] . '/',
];

// TODO: кешировать лучше не html, а массив. Меньше места будет заниматься.

//if (!$result = $modx->cacheManager->get($cacheName, $cacheOptions)) {
    // Определяем, какие опции будут выводиться
    switch (true) {
        // Газосиликат
        case $modx->resource->context_key == 'gazosilikatstroy':
            $charsValues = [
                'Размер, мм' => ['val' => $src['razmer-mm']],
                'Кол-во на поддоне, шт' => ['val' => $src['pallet_num']],
            ];
            break;
            
            
        // Краски
        case $modx->resource->context_key == 'kraska':
            if (in_array($src['parent'], [103255, 165702, 165703, 165704, 165705, 165706, 165707, 165708, 165709, 165710, 165711, 165712, 165713, 165714, 165715, 165716, 165717, 165718, 165719, 165720, 165721, 165722, 165723, 165725, 165726, 165727, 165730, 165731, 165734, 165735, 165736, 165737, 165738, 165739, 165740, 165741, 165742, 165743, 165744, 165745, 165746, 165747, 165750, 165751, 165752, 165753, 165754, 165755, 165756, 165757, 165758, 165759, 165760, 165761, 165762, 165763, 165764, 165765, 165766, 165767, 165768, 165769, 165770, 165771, 165772, 165773, 165774, 165775, 165776, 165777, 165778, 165779, 165780, 165781, 165782, 165783, 165784, 165785, 165786, 165787, 165788, 165789, 165790, 165791, 165792, 165793, 165794, 165795, 165796, 165797, 165798, 165799, 165800, 165801, 165802, 165803, 165804, 165805, 165806, 165807, 165905, 165906, 165907, 165908, 165909, 165910, 165911, 165912, 165913, 165914, 165915, 165916, 165917, 165918, 165919, 165920, 165921, 165922, 165923, 165924, 165925, 165926, 165927, 165928, 165929, 165930, 165931, 165932, 165933, 165934, 165935, 165936, 165937, 165938, 165939, 165940, 165941, 165942, 165943, 165944, 165945, 165946, 165947, 165948, 165949, 165950, 165951, 165952, 165953, 165954, 165955, 165956, 165957, 165958, 165959, 165960, 165961, 165962, 165963, 165964, 165965, 165966, 165967, 165968, 165969, 165970, 165971, 165972, 165973, 165974, 165975, 165976, 165977, 165978, 165979, 165980, 165981])) {
                $charsValues = [];
                
                if (!empty($src['stockNum'])) {
                    $charsValues = ['В наличии' => ['val' => [$src['stockNum'] . ' шт.']]];
                }

                $samovivoz = date('G') > 17 ? 'завтра' : 'сегодня';
                
                $charsValues = array_merge($charsValues, [
                    'Срок поставки' => ['val' => ['1-2 дня']],
                    'Самовывоз' => ['val' => [$samovivoz]],
                    'Цвет' => ['val' => $src['cvet']],
                    'Оттенок' => ['val' => $src['ottenok']],
                    'Применение' => ['val' => $src['primenenie']],
                    'Объем' => ['val' => $src['obem-l']],
                    'Без запаха' => ['val' => $src['bez-zapaha']],
                    'Возможность колеровки' => ['val' => $src['vozmozhnost-kolerovki']],
                ]);
            }
            break;
        

        // В остальных случаях
        default:
            $charsValues = [
                'Применение' => ['val' => $src['primenenie']],
                'Плотность, кг/м3' => ['val' => $src['plotnost']],
                'Теплопроводность' => ['val' => $src['teploprovodnost']],
                'Площадь, м2' => ['val' => $src['ploshad_m2']],
                'Объем, м3' => ['val' => $src['obyem_m3']],
                'Кол-во в упаковке, шт' => ['val' => $src['v_upakovke']],
                'Кол-во в упаковке, п.м.' => ['val' => $pm],
            ];

            if (in_array($modx->resource->context_key, ['web'])) {
                $charsValues['Применение']['composite'] = true;
            }
            break;
    }

    // Получаем и обрабатываем составные опции. Это те, у которых несколько значений
    $compositeTmp = array_filter($charsValues, function ($elem) {
        if (!empty($elem['composite'])) {
            return true;
        }
        return false;
    });
    foreach ($compositeTmp as $key => $val) {
        $charsValues[$key]['val'] = $val['val'][0];

        $countVal = count($val['val']);
        if ($countVal > 1) {
            $charsValues[$key]['val'] .= '...';
            for ($i = 1; $i < $countVal; $i++) {
                $charsValues[$key]['extra'][] = $val['val'][$i];
            }
        }
    }
    unset($compositeTmp);
    $charsValues = array_filter($charsValues, function ($elem) {
        return !empty($elem['val']);
    });

    // Вывод
    $result = '';
    foreach ($charsValues as $key => $value) {
        $inner = '';

        if (!empty($value['composite'])) {
            $inner = $value['val'];

            if (!empty($value['extra'])) {
                $inner .= '
            <div class="product-card__chars-val-info-wrap">
                <span class="product-card__chars-val-info-btn">
                    <svg class="svg icon-info" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink"
                         version="1.1">
                        <use xlink:href="' . $modx->config['template_path'] . 'img/svg-sprite.svg#icon-info"></use>
                    </svg>
                </span>
                <div class="product-card__chars-val-info">
                  ' . implode(', ', $value['extra']) . '
                </div>
            </div>
            ';
            }
        } else {
            $inner .= implode(', ', $value['val']);
        }

        $result .= '<div class="product-card__chars-line">
                   <span class="product-card__chars-span">
                   ' . $key . '
                   </span>
                   <span class="product-card__chars-val">
                   ' . $inner . '
                   </span>
               </div>';
    }

    //$modx->cacheManager->set($cacheName, $result, 0, $cacheOptions);
//}

return $result;
