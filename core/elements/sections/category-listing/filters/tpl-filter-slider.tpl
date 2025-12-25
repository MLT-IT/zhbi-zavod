{set $key = $table ~ $delimeter ~ $filter}
<fieldset
  class="category-listing__filter base-box-shadow filter-item opened"
  id="mse2_{$key}"
  data-opened-element="opened-{$key}"
>
  <div class="category-listing__filter-title active fw-600"  data-opened-btn="opened-{$key}">Цена, руб.</div>
  <div class="category-listing__filter-wrapped">
    <div class="category-listing__filter-price-inputs fs-body-2">{$rows}</div>
    <div class="mse2_number_slider"></div>
  </div>
</fieldset>
