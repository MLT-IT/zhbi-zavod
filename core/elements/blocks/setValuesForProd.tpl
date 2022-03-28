

$res



{* Ключ товара, нужен для добавления товара в корзину *}
{set $productKey = ($_modx->resource['id'] ~ $_modx->resource['price'] ~ $weight ~ '[]') | md5}
{* Кол-во товара в корзине *}
{set $itemInCart = $checkItems['cart'][$_modx->resource['id']]}

{* Единицы измерения для утеплителей *}
{if $_modx->resource.context_key in list ['rockwool', 'penoplex', 'web', 'tn', 'ursa', 'isover', 'paroc']}
    {set $pm = $_modx->resource['kolvo-pm'][0]}
    {set $m2 = $_modx->resource['ploshad_m2'][0]}
    {set $m3 = $_modx->resource['obyem_m3'][0]}
    {if $_modx->resource['v_upakovke'][0]? && $price? && $_modx->resource.context_key == 'penoplex'}
        {set $list = $price * $_modx->resource['v_upakovke'][0]}
        {set $list = $list | round}
    {/if}
{/if}

{* Единицы измерения - дополнительные рассчеты для web и penoplex *}
{if $_modx->resource['v_upakovke']? && $_modx->resource.context_key in list ['web', 'penoplex']}
    {set $m2 = $m2 * $_modx->resource['v_upakovke'][0]}
    {set $m2 = $m2 | replace : ',' : '.'}
{/if}

{* Единицы измерения для арматуры *}
{if $_modx->resource.context_key === 'armatura-178'}
    {set $metrov_v_tonne = $_modx->resource['kolichestvo-metrov-v-1-tonne'][0] | floatval}
    {set $dlina_m = $_modx->resource['dlina-m'][0] | floatval}
    {if $metrov_v_tonne > 0}
        {if $dlina_m > 0}
            {set $thing = ($metrov_v_tonne / $dlina_m) | replace : ',' : '.'}
        {/if}
        {set $pm = $metrov_v_tonne | replace : ',' : '.'}
    {/if}
{/if}

{* Единицы измерения для пиломата *}
{if $_modx->resource.context_key === 'pilomat'}
    {set $kub = $_modx->resource['kol-vokub-sh'][0] | replace : ',' : '.'}
{/if}

{* Цена за ... *}
{set $unit = $_modx->resource.unit}
{if ($unit[0] is empty) || ($unit[0] == 'упаковка')}
    {set $pricePer = 'упаковку'}
{elseif $unit[0] == 'тонна'}
    {set $pricePer = 'тонну'}
{else}
    {set $pricePer = $unit[0]}
{/if}
