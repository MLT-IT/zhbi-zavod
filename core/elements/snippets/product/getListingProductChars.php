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
