{var $key = $table ~ $delimeter ~ $filter}
{*с данными контекстами открытых фильтров будет 5... с другими 4... хз так сказали сделать*}
{set $limitActive = $_modx->context.key | in : ['web', 'rockwool', 'tn', 'penoplex', 'isover', 'paroc', 'ursa'] ? 4 : 3}

{if $_modx->getPlaceholder('filter_iterator') ?}
    {$_modx->setPlaceholder('filter_iterator', $_modx->getPlaceholder('filter_iterator') + 1)}
    {if $_modx->getPlaceholder('filter_iterator') > $limitActive}
        {set $dontActive = true}
    {/if}
{else}
    {$_modx->setPlaceholder('filter_iterator', 1)}
{/if}

{switch $key}
    {case 'msoption|razmer'}
        {set $keyClass = 'razmer'}
    {case 'msoption|razmery'}
        {set $keyClass = 'razmer'}
    {case 'msoption|item_thickness'}
        {set $keyClass = 'thickness'}
    {case 'msoption|item_width'}
        {set $keyClass = 'width'}
    {case 'msoption|item_length'}
        {set $keyClass = 'length'}
    {case 'msoption|cvet'}
        {set $keyClass = 'cvet'}
    {case 'msoption|surface'}
        {set $keyClass = 'surface'}
    {case 'msoption|proizvoditel'}
        {set $keyClass = 'proizvoditel'}
    {case 'msoption|brand'}
        {set $keyClass = 'brand'}
{/switch}

{* На определенных категориях у оттенков в фильтре тоже будет выводиться квадратик с цветом *}
{if ($_modx->resource.id in list [
18186,18189,18193,18181,16805,36871,16784,16786,16783,
66724,66873,66865,66862,66861,66772,66771,66770,66769,66768,66748,66747,66740,22597,64797,64785,64780,64773,64768,64693,64690,64683,64679,64676,22598,22596,
66810,66802,66803,66804,66805,66806,66807,66808,66809,66801,66811,66812,66813,66814,66857,66858,66859,66860,66793,64822,64846,64851,64854,64859,64868,66725,66773,22600,66794,66795,66796,66797,66798,66799,66800,22599
]) && ($key === 'msoption|ottenok')}
    {set $keyClass = 'cvet'}
{/if}

{if $key === 'msoption|brand' && $_modx->resource.context_key === 'kirpich-m'}
    {set $dontActive = true}
{/if}

<div class="listing__filter-block{if $keyClass?} filter_type_{$keyClass}{/if}{if $dontActive?}{else} active{/if}" id="mse2_{$key}">
    <div class="listing__filter-block-header">
        <div class="listing__filter-block-title filter_title">{('mse2_filter_' ~ $table ~ '_' ~ $filter) | lexicon}</div>
        <div class="listing__filter-block-arrow"></div>
    </div>
    <div class="listing__filter-block-content js-custom-scrollbar">
        {$rows}
    </div>
</div>
