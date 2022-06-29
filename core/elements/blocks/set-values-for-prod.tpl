{* id товара, нужен для добавления товара в корзину *}
{set $prodId = $src['id']}

{* Ключ товара, нужен для изменения товара в корзине *}
{set $productKey = ($src['id'] ~ $src['price'] ~ $src['weight'] ~ '[]') | replace : ' ' : ''}

{* Цена по умолчанию - нужна для расчета других цен на JS *}
{set $defaultPrice = $src['price'] | replace : ',' : '.' | replace : ' ' : ''}
{* Цена для красивого вывода *}
{set $outputPrice = $src['price'] | preg_replace : '/\B(?=(\d{3})+(?!\d))/': ' ' | replace : ',' : '.'}
{* Старая цена *}
{if $src['old_price']?}
    {set $defaultOldPrice = $src['old_price'] | replace : ',' : '.' | replace : ' ' : ''}
    {set $outputOldPrice = $src['old_price'] | preg_replace : '/\B(?=(\d{3})+(?!\d))/': ' ' | replace : ',' : '.'}
{/if}

{*
Для некоторых опций применяется модификатор replace : ',' : '.', а для некоторых - нет. Потому что у некоторых опций тип - числовое поле, а у некоторых - текстовое. Что может быть в текстовом - неизвестно. Но значение будет использоваться для вычислений. Поэтому надо применить replace : ',' : '.'.
*}

{* Есть ли товар в избранном, в сравнении *}
{set $checkItems = $_modx->getPlaceholder('checkItems')}
{* Кол-во товара в корзине *}
{set $itemInCart = $checkItems['cart'][$src['id']]}

{* Единицы измерения для утеплителей *}
{if $src['context_key'] in list ['rockwool', 'penoplex', 'web', 'tn', 'ursa', 'isover', 'paroc']}
    {set $pm = $src['kolvo-pm'][0] | replace : ',' : '.'}
    {set $m2 = $src['ploshad_m2'][0]}
    {set $m3 = $src['obyem_m3'][0] | replace : ',' : '.'}
    {if $src['v_upakovke'][0]? && $src['context_key'] == 'penoplex'}
        {set $list = $src['v_upakovke'][0]}
    {/if}
{/if}

{* Единицы измерения - дополнительные рассчеты для web и penoplex *}
{if $src['v_upakovke'][0]? && $src['context_key'] in list ['web', 'penoplex']}
    {set $m2 = $m2 * $src['v_upakovke'][0]}
{/if}

{* Единицы измерения для арматуры *}
{if $src['context_key'] === 'armatura-178'}
    {set $metrov_v_tonne = $src['kolichestvo-metrov-v-1-tonne'][0] | replace : ',' : '.'}
    {set $dlina_m = $src['dlina-m'][0] | replace : ',' : '.'}
    {if $metrov_v_tonne > 0}
        {if $dlina_m > 0}
            {set $thing = $metrov_v_tonne / $dlina_m}
        {/if}
        {set $pm = $metrov_v_tonne}
    {/if}
{/if}

{* Единицы измерения для пиломата *}
{if $src['context_key'] === 'pilomat'}
    {set $pilomat_thing = $src['kol-vokub-sh'][0] | replace : ',' : '.'}
{/if}

{* Единицы измерения для кирпича *}
{if $src['context_key'] === 'kirpich-m'}
    {set $k_m3seam = 1 / ($src['k_m3seam'][0] | replace : ',' : '.')}
    {set $k_m2seam = 1 / ($src['k_m2seam'][0] | replace : ',' : '.')}
{/if}

{* Единицы измерения для плит ОСБ и фанеры *}
{if $src['context_key'] in list ['plitaosb', 'pro-fanera']}
    {set $m2 = $src['ploshad_m2'][0]}
{/if}

{* Единицы измерения для Ондулина и Ондулина Смарт (krovlyasp) *}
{if ($src['parent'] in list [16805, 36871]) && ($src['ploshad_m2'][0] is not empty)}
    {set $list = 1 / $src['ploshad_m2'][0]}
{/if}

{* Единицы измерения для Уголвков (armatura-178) *}
{if ($src['parent'] in list [71771, 71772, 71774]) && ($src['metrov-v-tonne'][0] is not empty)}
    {set $meter =  $src['metrov-v-tonne'][0] | replace : ',' : '.'}
{/if}

{* Единицы измерения для Труб (armatura-178) *}
{if ($src['parent'] in list [79636, 71768, 79637, 79638, 79639, 71769, 71770, 71766, 71767]) && ($src['massa-1m-kg'][0] is not empty)}
    {set $pm = ($src['massa-1m-kg'][0] | replace : ',' : '.') / 1000}

    {if $src['dlina-m'][0] is not empty}
        {set $tmp = $src['dlina-m'][0] | replace : ',' : '.'}
        {if $tmp > 0}
            {set $thing = 1 / ($pm * $tmp)}
        {/if}
    {/if}

    {set $pm = 1 / $pm}
{/if}

{* Единицы измерения fasady-pro *}
{if $src['context_key'] === 'fasady-pro'}
    {set $m2 = $src['obschaya-ploshad'][0] | replace : ',' : '.' | replace : ' ' : ''}
    {set $m3 =  1 / ($src['kol-vokub-sh'][0] | replace : ',' : '.' | replace : ' ' : '')}
    {set $upk = 1 / $src['v_upakovke'][0]}
{/if}

{* Единицы измерения krovlya *}
{* Для Цементно-песчаная черепица (22596) и Керамическая черепица (22599) нужно вывести цену за м2 *}
{if $src['context_key'] === 'krovlya' && $src['parent'] in list [22596,22599,66808,66794,66795,66796,66797,66798,66799,66800,66801,66802,66803,66804,66805,66806,66807,66793,66809,66810,66811,66812,66813,66814,66857,66858,66859,66860,66861,66862,66865,66873,64851,22598,22600,64676,64679,64683,64690,64693,64768,64773,64780,64785,64797,64822,64846,22597,64854,64859,64868,66724,66725,66740,66747,66748,66768,66769,66770,66771,66772,66773]}
    {set $length = $src['item_length'][0]}
    {set $width = $src['item_width'][0]}
    {if ($length is not empty) && ($width is not empty)}
        {set $m2 = $length * $width / 1000000}
    {/if}
{/if}

{* Единицы измерения для plity-mdvp *}
{if $src['context_key'] === 'plity-mdvp'}
    {* round нужен, т.к. на странице с перелинковкой через fenom выводится (расчитывается) цена за м2. А в каталоге, например, при смене единицы измерения рассчеты происходят через JS. И результат расчета на fenom отличается от результата на JS. А если округлить, то все норм *}
    {set $m2 = (1 / $src['ploshad_m2'][0]) | round}
{/if}

{* Цена за ... *}
{set $unit = $src['unit'][0]}
{if ($unit is empty) || ($unit == 'упаковка')}
    {set $pricePer = 'упаковку'}
{elseif $unit == 'тонна'}
    {set $pricePer = 'тонну'}
{else}
    {set $pricePer = $unit}
{/if}

{*
Выводить ли возможность выбирать единицу измерения для добавления товара в корзину
Условия...
- Должен быть правильный контекст.
- Родитель не должен быть сопутствующими товарами ИЛИ Родитель должен быть Ондулином или Ондулином Смарт (krovlyasp)
*}
{set $condition = (($src['context_key'] in list ['rockwool', 'penoplex', 'web', 'tn', 'ursa', 'isover', 'paroc', 'armatura-178', 'pilomat', 'kirpich-m', 'plitaosb', 'pro-fanera', 'fasady-pro', 'krovlya', 'plity-mdvp']) &&
($src['parent'] not in list [9052,9125,14193,14269,10998,12018,12819,15201,15202])) || ($src['parent'] in list [16805, 36871])}

{* Дробное добавление товара в корзину *}
{if $_modx->resource.template in list [17, 20, 6, 21, 22]}
    {set $isFractional = $_modx->resource['isFractional']}
{else}
    {set $isFractional = $src['isFractional']}
{/if}
{if $isFractional == 1}
    {set $extraClass = ' custom-counter_type_fractional'}
    {set $dataMin = '0.01'}
{else}
    {set $extraClass = ''}
    {set $dataMin = '1'}
{/if}

{* Установка itemUnits *}
{set $inf = 999999999999999999}
{set $itemUnits = []}
{if ($m2 is not empty) && ($m2 > 0) && ($m2 < $inf)}
    {set $itemUnits['m2'] = ['val' => $m2, 'title' => 'м2', 'id' => '2']}
{/if}
{if ($m3 is not empty) && ($m3 > 0) && ($m3 < $inf)}
    {set $itemUnits['m3'] = ['val' => $m3, 'title' => 'м3', 'id' => '3']}
{/if}
{if ($pm is not empty) && ($pm > 0) && ($pm < $inf)}
    {set $itemUnits['pm'] = ['val' => $pm, 'title' => 'п.м.', 'id' => '4']}
{/if}
{if ($list is not empty) && ($list > 0) && ($list < $inf)}
    {set $itemUnits['list'] = ['val' => $list, 'title' => 'лист', 'id' => '5']}
{/if}
{if ($thing is not empty) && ($thing > 0) && ($thing < $inf)}
    {set $itemUnits['thing'] = ['val' => $thing, 'title' => 'штуку', 'id' => '6']}
{/if}
{if ($pilomat_thing is not empty) && ($pilomat_thing > 0) && ($pilomat_thing < $inf)}
    {set $itemUnits['pilomat_thing'] = ['val' => $pilomat_thing, 'title' => 'штуку', 'id' => '7']}
{/if}
{if ($k_m2seam is not empty) && ($k_m2seam > 0) && ($k_m2seam < $inf)}
    {set $itemUnits['k_m2seam'] = ['val' => $k_m2seam, 'title' => 'м2', 'id' => '8']}
{/if}
{if ($k_m3seam is not empty) && ($k_m3seam > 0) && ($k_m3seam < $inf)}
    {set $itemUnits['k_m3seam'] = ['val' => $k_m3seam, 'title' => 'м3', 'id' => '9']}
{/if}
{if ($meter is not empty) && ($meter > 0) && ($meter < $inf)}
    {set $itemUnits['meter'] = ['val' => $meter, 'title' => 'метр', 'id' => '10']}
{/if}
{if ($upk is not empty) && ($upk > 0) && ($upk < $inf)}
    {set $itemUnits['upk'] = ['val' => $upk, 'title' => 'упаковка', 'id' => '11']}
{/if}


{*
Fenom на Windows неправильно выводит float числа. Именно выводит неправильно. И именно числа. При выводе он меняет точку на запятую. Пример кода:
{set $p = 3.14}
{$p}
Выведет 3,14
Поэтому перед выводом нужно число превратить в строку, а у строки заменить запятую на точку.

Ключ товара. Если запускать сайт на Windows, то дробные числа должны быть с запятой, иначе ключ рассчитается неправильно и будет невозможно изменить кол-во товара (на неглавных контекстах - это все, кроме web). Если на Linux, то с точкой.
*}
{if $_modx->getPlaceholder('checkFloatTrouble') ?}
    {foreach $itemUnits as $key => $val}
        {* Здесь происходит неявное приведение типов - числа в строку (функция replace ведь работает со строками). И замена запятой на точку *}
        {set $itemUnits[$key] = $val | replace : ',' : '.'}
    {/foreach}
    {set $productKey = $productKey | replace : '.' : ','}
{/if}

{* Если нет доп. цен, то и не надо выводить список с выбором цен *}
{if $itemUnits | length < 1}
    {set $condition = false}
{/if}

{set $productKey = $productKey | md5}
