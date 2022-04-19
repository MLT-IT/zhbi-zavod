{* Ключ товара, нужен для добавления товара в корзину *}
{* Если запускать сайт на Windows, то дробные числа должны быть с запятой, иначе ключ рассчитается неправильно и будет невозможно изменить кол-во товара. Если на Linux, то с точкой. *}
{set $productKey = ($src['id'] ~ $src['price'] ~ $src['weight'] ~ '[]') | replace : ',' : '.' | replace : ' ' : '' | md5}

{* Цена по умолчанию - нужна для расчета других цен на JS. Тут наоборот нужна точка, т.к. функция parseFloat неправильно распарсит число с запятой *}
{set $defaultPrice = $src['price'] | replace : ',' : '.' | replace : ' ' : ''}

{* Цена для красивого вывода *}
{set $outputPrice = $src['price'] | preg_replace : '/\B(?=(\d{3})+(?!\d))/': ' ' | replace : ',' : '.'}

{* Информация о кол-ве товара в корзине, есть ли товар в избранном, в сравнении *}
{set $checkItems = $_modx->getPlaceholder('checkItems')}
{* Кол-во товара в корзине *}
{set $itemInCart = $checkItems['cart'][$src['id']]}

{* Единицы измерения для утеплителей *}
{if $src['context_key'] in list ['rockwool', 'penoplex', 'web', 'tn', 'ursa', 'isover', 'paroc']}
    {set $pm = $src['kolvo-pm'][0]}
    {set $m2 = $src['ploshad_m2'][0]}
    {set $m3 = $src['obyem_m3'][0]}
    {if $src['v_upakovke'][0]? && $price? && $src['context_key'] == 'penoplex'}
        {set $list = $price * $src['v_upakovke'][0]}
        {set $list = $list | round}
    {/if}
{/if}

{* Единицы измерения - дополнительные рассчеты для web и penoplex *}
{if $src['v_upakovke']? && $src['context_key'] in list ['web', 'penoplex']}
    {set $m2 = $m2 * $src['v_upakovke'][0]}
    {set $m2 = $m2 | replace : ',' : '.'}
{/if}

{* Единицы измерения для арматуры *}
{if $src['context_key'] === 'armatura-178'}
    {set $metrov_v_tonne = $src['kolichestvo-metrov-v-1-tonne'][0] | floatval}
    {set $dlina_m = $src['dlina-m'][0] | floatval}
    {if $metrov_v_tonne > 0}
        {if $dlina_m > 0}
            {set $thing = ($metrov_v_tonne / $dlina_m) | replace : ',' : '.'}
        {/if}
        {set $pm = $metrov_v_tonne | replace : ',' : '.'}
    {/if}
{/if}

{* Единицы измерения для пиломата *}
{if $src['context_key'] === 'pilomat'}
    {set $pilomat_thing = $src['kol-vokub-sh'][0] | replace : ',' : '.'}
{/if}

{* Единицы измерения для кирпича *}
{if $src['context_key'] === 'kirpich-m'}
    {set $k_m3seam = (1 / $src['k_m3seam'][0]) | replace : ',' : '.'}
    {set $k_m2seam = (1 / $src['k_m2seam'][0]) | replace : ',' : '.'}

    {set $coefficient = $src['pallet_num'][0] | replace : ',' : '.'}
{/if}

{* Единицы измерения для плит ОСБ *}
{if $src['context_key'] === 'plitaosb'}
    {set $m2 = (1 / $src['ploshad_m2'][0]) | replace : ',' : '.'}
{/if}

{* Цена за ... *}
{set $unit = $src['unit']}
{if ($unit[0] is empty) || ($unit[0] == 'упаковка')}
    {set $pricePer = 'упаковку'}
{elseif $unit[0] == 'тонна'}
    {set $pricePer = 'тонну'}
{else}
    {set $pricePer = $unit[0]}
{/if}

{* Условие - выводить ли возможность выбирать единицу измерения для добавления товара в корзину. Должен быть правильный контекст. Родитель не должен быть сопутствующими товарами *}
{set $condition = ($src['context_key'] in list ['rockwool', 'penoplex', 'web', 'tn', 'ursa', 'isover', 'paroc', 'armatura-178', 'pilomat', 'kirpich-m', 'plitaosb']) &&
($src['parent'] not in list [9052, 9125, 14193, 14269, 10998, 12018, 12819, 15201, 15202])}

{* Дробное добавление товара в корзину *}
{set $prodId = $src['id']}
{if $src['template'] === 17}
    {set $extraClass = ' custom-counter_type_fractional'}
    {set $dataMin = '0.01'}
{else}
    {set $extraClass = ''}
    {set $dataMin = '1'}
{/if}

{* Установка itemUnits *}
{set $itemUnits = []}
{if $m2?}
    {set $itemUnits['m2'] = ['val' => $m2, 'title' => 'м2', 'id' => '2']}
{/if}
{if $m3?}
    {set $itemUnits['m3'] = ['val' => $m3, 'title' => 'м3', 'id' => '3']}
{/if}
{if $pm?}
    {set $itemUnits['pm'] = ['val' => $pm, 'title' => 'п.м.', 'id' => '4']}
{/if}
{if $list?}
    {set $itemUnits['list'] = ['val' => $list, 'title' => 'лист', 'id' => '5']}
{/if}
{if $thing?}
    {set $itemUnits['thing'] = ['val' => $thing, 'title' => 'штуку', 'id' => '6']}
{/if}
{if $pilomat_thing?}
    {set $itemUnits['pilomat_thing'] = ['val' => $pilomat_thing, 'title' => 'штуку', 'id' => '7']}
{/if}
{if $k_m2seam?}
    {set $itemUnits['k_m2seam'] = ['val' => $k_m2seam, 'title' => 'м2', 'id' => '8']}
{/if}
{if $k_m3seam?}
    {set $itemUnits['k_m3seam'] = ['val' => $k_m3seam, 'title' => 'м3', 'id' => '9']}
{/if}
