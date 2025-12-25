<div class="footer__menu">
  <div class="footer__menu-section">
    <div class="footer__menu-section-title fw-700">Каталог</div>
    <ul class="footer__menu-section-items">
        {if $_modx->getPlaceholder('context.footer_menu_ids')}
            {set $items = "@FILE modules/map-resources/mapSeparateResources.php" | snippet : [
                'data' => $_modx->getPlaceholder('map-resources.menu'),
                'ids' => $_modx->getPlaceholder('context.footer_menu_ids')
            ]}

            {foreach $items as $item}
                <li><a class="color-white" href="{$item['uri']}">{$item['menutitle']}</a></li>
            {/foreach}
        {/if}
    </ul>
  </div>
  <div class="footer__menu-section">
    <div class="footer__menu-section-title fw-700 color-red">Популярные категории</div>
    <ul class="footer__menu-section-items colums-3">
        {if $_modx->getPlaceholder('context.footer_category_ids')}
            {set $items = "@FILE modules/map-resources/mapSeparateResources.php" | snippet : [
                'data' => $_modx->getPlaceholder('map-resources.category'),
                'ids' => $_modx->getPlaceholder('context.footer_category_ids')
            ]}

            {foreach $items as $item}
                <li><a class="color-red" href="{$item['uri']}">{$item['menutitle']}</a></li>
            {/foreach}
        {/if}
    </ul>
  </div>
</div>