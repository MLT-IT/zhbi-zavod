<fieldset id="mse2_{$table ~ $delimeter ~ $filter}" class="filter-number">
    <h4 class="filter-number__title">{('mse2_filter_' ~ $table ~ '_' ~ $filter) | lexicon}</h4>
    <div class="mse2_number_slider filter-number__slider"></div>
    <div class="mse2_number_inputs filter-number__row">
        {$rows}
    </div>
</fieldset>
