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
{/switch}

<div class="listing__filter-block{if $keyClass?} filter_type_{$keyClass}{/if}{if $dontActive?}{else} active{/if}" id="mse2_{$key}">
    <div class="listing__filter-block-header">
        <div class="listing__filter-block-title filter_title">{('mse2_filter_' ~ $table ~ '_' ~ $filter) | lexicon}</div>
        <div class="listing__filter-block-arrow"></div>
    </div>
    <div class="listing__filter-block-content js-custom-scrollbar">
        {$rows}
    </div>
</div>
