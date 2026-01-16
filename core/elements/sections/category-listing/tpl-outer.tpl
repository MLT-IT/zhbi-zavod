<div class="category-listing section-margin" id="mse2_mfilter">
  <div class="container">
    <div class="category-listing__row">
      <div class="category-listing__filters" data-opened-element="filters">
        <div>
          <span class="category-listing__filters-close" data-opened-btn="filters"></span>

          <form
            class="form category-listing__filters-row"
            action="{$_modx->resource.id | url}"
            method="post"
            id="mse2_filters"
          >
            {$filters}
          </form>
        </div>
        <div class="category-listing__filters__mobile-controls">
          <button class="btn btn-bordered" onclick="mSearch2.reset();">Сбросить</button>
          <button class="btn btn-primary" data-opened-btn="filters">Применить</button>
        </div>

        {include "file:sections/sidebar-banner/wrapper.tpl"}
      </div>

      <div class="category-listing__content">
        <div class="section-margin">
          {include "file:modules/tags-store/chunks/small-tags/wrapper.tpl"}

          <div class="category-listing__controls">
            <div class="category-listing__controls-item" id="mse2_sort" data-opened-element="sorted">
              <span class="category-listing__controls-item-title" data-opened-btn="sorted">Сортировать по</span>
              {include "file:chunks/sorted-list.tpl"}
            </div>

            <button class="btn btn-primary category-listing__controls-filter-open" data-opened-btn="filters">
              <svg class="icon-btn__icon" aria-hidden="true"><use xlink:href="/assets/template/images/icons.svg#svg-burger"></use></svg>
              Фильтры
            </button>
          </div>

          <div class="chips">
            <div class="chips__row" id="mse2_selected" style="display: none;"></div>
          </div>

          <div class="category-listing__products" id="mse2_results">
            {$results}
          </div>

          <div class="mse2_pagination">{'page.nav' | placeholder}</div>
        
          {include "file:sections/promo-banner/wrapper.tpl"}
        </div>

        
      </div>
    </div>
  </div>
</div>
