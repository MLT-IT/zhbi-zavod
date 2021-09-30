{var $key = $table ~ $delimeter ~ $filter}
<div class="listing__filter-block active" id="mse2_{$key}">
    <div class="listing__filter-block-header">
        <div class="listing__filter-block-title">{('mse2_filter_' ~ $table ~ '_' ~ $filter) | lexicon}</div>
        <div class="listing__filter-block-arrow"></div>
    </div>
    <div class="listing__filter-block-content">
        {$rows}
    </div>
</div>