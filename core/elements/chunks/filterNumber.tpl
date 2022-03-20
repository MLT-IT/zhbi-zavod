<div class="listing__filter-block active filter-number">
    <div class="listing__filter-block-header">
        <div class="listing__filter-block-title filter_title">{('mse2_filter_' ~ $table ~ '_' ~ $filter) | lexicon}</div>
        <div class="listing__filter-block-arrow"></div>
    </div>
    <fieldset class="filter-number__inner listing__filter-block-content" id="mse2_{$table ~ $delimeter ~ $filter}">
        <div class="mse2_number_inputs filter-number__row">
            {$rows}
        </div>
        <div class="mse2_number_slider filter-number__slider"></div>
    </fieldset>
</div>
