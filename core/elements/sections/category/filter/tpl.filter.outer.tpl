{var $key = $table ~ $delimeter ~ $filter}

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
{/switch}

<div class="listing__filter-block active{if $keyClass?} filter_type_{$keyClass}{/if}" id="mse2_{$key}">
    <div class="listing__filter-block-header">
        <div class="listing__filter-block-title">{('mse2_filter_' ~ $table ~ '_' ~ $filter) | lexicon}</div>
        <div class="listing__filter-block-arrow"></div>
    </div>
    <div class="listing__filter-block-content">
        {$rows}
    </div>
</div>
