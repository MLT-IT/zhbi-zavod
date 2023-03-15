{var $key = $table ~ $delimeter ~ $filter}
<div class="filter-item {if $keyClass?} filter_type_{$keyClass}{/if}" id="mse2_{$key}" data-dropdown="responsive">
  <div class="filter-item__top active"><span class="filter-item__title">{('mse2_filter_' ~ $table ~ '_' ~ $filter) | lexicon}:</span></div>
  <div class="filter-item__dropdown">
    <div class="filter-item__options">
      {$rows}
      <button class="btn btn_style_trans filter-item__more" data-text="Скрыть">Показать все</button>
    </div>
  </div>
</div>
