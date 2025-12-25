{set $key = $table ~ $delimeter ~ $filter}
<fieldset class="category-listing__filter base-box-shadow filter-item opened" id="mse2_{$key}" data-opened-element="opened-{$key}">
  <div class="category-listing__filter-title filter_title fw-600 active" data-opened-btn="opened-{$key}">
    {('mse2_filter_' ~ $table ~ '_' ~ $filter) | lexicon}
  </div>
  
  <div class="category-listing__filter-wrapped">
    <div class="search-by-words">
      <input placeholder="Введите значение" type="text" data-search-by-words="{$key}" />
    </div>

    <div
      class="category-listing__filter-row"
      data-opened-element="filter-{$key}"
      data-search-by-words-container="{$key}"
    >
      {$rows}
    </div>

    {* Плейсхолдер записывается в чанке sections\category-listing\chunks\filters\tpl-filter-row.tpl*}
    {if $_modx->getPlaceholder('category-listing-show-btn-more')}
    <div
      class="category-listing__filter-more-btn btn btn-bordered"
      data-opened-btn="filter-{$key}"
      data-active-text="Скрыть"
    >
      Показать все
    </div>
    {/if}
  </div>
</fieldset>
