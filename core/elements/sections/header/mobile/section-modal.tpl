  <div class="header-mobile__modal__top">
    <div class="header-mobile__modal__top-scroll">
      {foreach $_modx->getPlaceholder('menu_items') as $item}
      <a class="fw-700" href="{$item['uri']}">{$item['menutitle']}</a>
      {/foreach}
    </div>
  </div>
  <div class="header-mobile__modal__main bg-light-gray-2">
    {include 'file:modules/fast-search/chunks/fast-search-mobile.tpl'}

    <div class="header-mobile__categories">
      {if $_modx->getPlaceholder('context.header_mobile_categories_ids')}
        {set $categories = "@FILE modules/map-resources/mapSeparateResources.php" | snippet : [
            'data' => $_modx->getPlaceholder('map-resources.category'),
            'ids' => $_modx->getPlaceholder('context.header_mobile_categories_ids')
        ]}

        {foreach $categories as $category}
          <div class="header-mobile__categories-item">
            <div class="header-mobile__categories-item-image">
              <img src="{$category['main_image']}" />
            </div>
            <div class="header-mobile__categories-item-content">
              <div class="fw-700">{$category['menutitle']}</div>
              <a class="btn btn-primary" href="{$category['uri']}">Перейти</a>
            </div>
          </div>
        {/foreach}
      {/if}
    </div>
  </div>