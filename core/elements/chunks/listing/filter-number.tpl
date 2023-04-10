<div class="filter-number filter-item{if $keyClass?} filter-item_type_{$keyClass}{/if}" id="mse2_{$key}" data-dropdown="responsive">
  <div class="filter-item__top active"><span class="filter-item__title">{('mse2_filter_' ~ $table ~ '_' ~ $filter) | lexicon}:</span></div>
  <div class="filter-item__dropdown">
    <fieldset class="filter-number__inner listing__filter-block-content" id="mse2_{$table ~ $delimeter ~ $filter}">
      <div class="mse2_number_inputs filter-number__row">
          {$rows}
      </div>
      <div class="mse2_number_slider filter-number__slider"></div>
    </fieldset>
  </div>
</div>
