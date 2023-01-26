{* Вынес в отдельный чанк, чтобы удобнее было работать, т.к. тут много кода *}

<div class="listing__products-item-chars-wrap">
    <span class="listing__products-item-chars-btn">
        <svg class="svg icon-info" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
             version="1.1">
            <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-info"></use>
        </svg>
        Показать информацию
    </span>

    <div class="listing__products-item-chars">
        {*
            Массив со сложными опциями.
            Сложные - это те, где может быть больше 1 значения.
        *}
        {if $_modx->resource.context_key == 'armatura-178'}
            {set $compositeKeys = [
                'Марка стали' => 'marka-stali'
            ]}
        {/if}
        {if $_modx->resource.context_key not in list ['web', 'rockwool', 'tn', 'penoplex', 'isover', 'paroc', 'ursa']}
            {set $compositeKeys['Применение'] = 'primenenie'}
        {/if}
        {* Профлист в кровле *}
        {if $src['parent'] in list [86214,43730,81058,81057,81056,81055,81054,81053,81047,43790,43775,43760,43748,43720,43711,43536,41715,41709,41706,41701,41699,41690,41684,41628,37728,26581,81051,81052,26582,86228,86218,86215,86229,86227,86226,86225,86224,86223,86222,86221,86220,86219,86217,86216]}
            {set $compositeKeys['Цвет'] = 'cvet'}
        {/if}

        {* Получение значений опций *}
        {set $compositeValues = []}
        {set $compositeExtraValues = []}
        {set $compositeCount = []}
        {foreach $compositeKeys as $title => $key}
            {set $compositeCount[$key] = $src[$key] | count}
            {set $info = []}
            {if $compositeCount[$key] > 1}
                {set $compositeValues[$key] = $src[$key][0] ~ '...'}

                {foreach 1..($compositeCount[$key]-1) as $value}
                    {set $compositeExtraValues[$key][] = $src[$key][$value]}
                {/foreach}
            {else}
                {set $compositeValues[$key] = $src[$key][0]}
            {/if}
        {/foreach}

        {* Определяем, какие опции будут выводиться *}
        {if $src['context_key'] == 'armatura-178'}
            {set $charsValues = [
                $src['diametr-mm'][0],
                $src['dlina-m'][0],
                $src['surface'][0],
                $src['massa-1-m-profilya-kg'][0],
                $src['marka-stali'][0],
                $src['kolichestvo-metrov-v-1-tonne'][0],
            ]}
            {set $charsHeaders = [
                'Диаметр, мм',
                'Длина, м',
                'Поверхность'
                'Масса 1 п.м. профиля, кг'
                'Марка стали'
                'Количество п.м. в 1 тонне'
            ]}
        {elseif $src['context_key'] == 'pilomat'}
            {set $charsValues = [
                ([$src['item_thickness'][0], $src['item_width'][0], $src['item_length'][0]] | implode : 'x'),
                $src['vlazhnost'][0],
                $src['sort'][0],
                $src['vid-obrabotki'][0],
                $src['massa'][0],
                $src['kol-vokub-sh'][0],
            ]}
            {set $charsHeaders = [
                'Размер',
                'Влажность',
                'Сорт',
                'Вид обработки',
                'Вес, кг',
                'Кол-во в кубе, шт',
            ]}
        {elseif $src['context_key'] == 'kirpich-m'}
            {set $charsValues = [
                $src['voidness'][0],
                $src['proizvoditel'][0],
                $src['razmer-mm'][0],
                $src['strength_grade'][0],
                $src['pallet_num'][0],
                $src['plotnost'][0],
                $src['massa'][0],
                $src['format'][0],
            ]}
            {set $charsHeaders = [
                'Пустотность',
                'Производитель',
                'Размер, мм',
                'Марка прочности',
                'Кол-во на поддоне',
                'Плотность, кг/м3',
                'Вес, кг',
                'Формат',
            ]}
        {elseif $src['context_key'] == 'fasady-pro'}
            {set $charsValues = [
                $src['razmer-mm'][0],
                $src['sort'][0],
                $src['poroda-drevesiny'][0],
                $src['obyem_m3'][0],
                $src['obschaya-ploshad'][0],
            ]}
            {set $charsHeaders = [
                'Размер, мм',
                'Сорт',
                'Порода древесины',
                'Объем, м3',
                'Общая площадь, м2',
            ]}
        {elseif $src['context_key'] == 'policarbonat'}
            {set $charsValues = [
                $src['item_thickness'][0],
                $src['garantiya'][0],
                $src['stoykost-k-uf'][0],
                $src['tolshchina-zashchitnogo-sloya'][0],
                $src['massazam2'][0],
            ]}
            {set $charsHeaders = [
                'Толщина, мм',
                'Гарантия, лет',
                'Стойкость к УФ',
                'Толщина защитного слоя',
                'Вес, кг/м2',
            ]}
        {* Профлист в кровле *}
        {elseif $src['parent'] in list [86214,43730,81058,81057,81056,81055,81054,81053,81047,43790,43775,43760,43748,43720,43711,43536,41715,41709,41706,41701,41699,41690,41684,41628,37728,26581,81051,81052,26582,86228,86218,86215,86229,86227,86226,86225,86224,86223,86222,86221,86220,86219,86217,86216]}
            {set $charsValues = [
                $src['profil'][0],
                $src['item_thickness'][0],
                $src['cvet'],
                $src['obshaya-shirina'][0],
                $src['poleznaya-shirina'][0],
            ]}
            {set $charsHeaders = [
                'Профиль',
                'Толщина, мм',
                'Цвет'
                'Общая ширина, мм',
                'Полезная ширина, мм',
            ]}
        {* Ондулин на кровле *}
        {elseif $src['parent'] in list [16783,18186,18189,18193,18181,16805,36871,16784,16786]}
            {set $charsValues = [
                $src['ottenok'][0],
                $src['kolichestvo-voln'][0],
                $src['vysota-volny'],
                $src['item_thickness'][0],
                $src['item_width'][0],
                $src['item_length'][0],
                $src['ploshad_m2'][0],
            ]}
            {set $charsHeaders = [
                'Оттенок',
                'Количество волн',
                'Высота волны, мм'
                'Толщина, мм',
                'Ширина, мм',
                'Длина, мм'
                'Площадь, м2'
            ]}
        {* В остальных случаях *}
        {else}
            {set $charsValues = [
                $primenenie,
                $src['plotnost'][0],
                $src['teploprovodnost'][0],
                $src['ploshad_m2'][0],
                $src['obyem_m3'][0],
                $src['v_upakovke'][0],
                $pm,
            ]}
            {set $charsHeaders = [
                'Применение',
                'Плотность, кг/м3',
                'Теплопроводность',
                'Площадь, м2',
                'Объем, м3',
                'Кол-во в упаковке, шт',
                'Кол-во в упаковке, п.м.',
            ]}
        {/if}

        {* Вывод опций *}
        {foreach $charsValues as $key => $value}
            {if $value ?}
                <div class="listing__products-item-chars-line">
                    <span class="listing__products-item-chars-span">
                        {$charsHeaders[$key]}:
                    </span>
                    <span class="listing__products-item-chars-val">
                        {if $compositeValues[$compositeKeys[$charsHeaders[$key]]]}
                            {$compositeValues[$compositeKeys[$charsHeaders[$key]]]}

                            {if $compositeExtraValues[$compositeKeys[$charsHeaders[$key]]] | count > 0}
                                <div class="listing__products-item-chars-val-info-wrap">
                                    <span class="listing__products-item-chars-val-info-btn">
                                        <svg class="svg icon-info" xmlns="http://www.w3.org/2000/svg"
                                             xmlns:xlink="http://www.w3.org/1999/xlink"
                                             version="1.1">
                                            <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-info"></use>
                                        </svg>
                                    </span>
                                    <div class="listing__products-item-chars-val-info">
                                        {$compositeExtraValues[$compositeKeys[$charsHeaders[$key]]] | implode : ', '}
                                    </div>
                                </div>
                            {/if}
                        {else}
                            {* На всякий случай делаем join, вдруг значение - это массив. Ну а если нет, то со значением ничего не будет *}
                            {$value | join : ', '}
                        {/if}
                    </span>
                </div>
            {/if}
        {/foreach}
    </div>
</div>
