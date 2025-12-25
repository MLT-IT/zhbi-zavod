{set $categories = "@FILE modules/map-resources/mapGetResourcesByWhere.php" | snippet : [
    'data' => $_modx->getPlaceholder('map-resources.category'),
    'where' => '{"parent":'~$_modx->getPlaceholder('context.catalog_id')~'}'
]}

<nav class="catalog-block__sidebar">
    <ul class="catalog-block__sidebar-list">
        {foreach $categories as $index => $category}
            <li class="catalog-block__sidebar-item">
                <a href="{$category['uri']}" class="
                    catalog-block__sidebar-link
                    {if $category['id'] == $_modx->resource.id}active{/if}
                    ">
                    <img class="catalog-block__sidebar-icon" src="{$category['main_image']}" />
                    <span class="catalog-block__sidebar-text">{$category['menutitle']}</span>
                </a>
            </li>
        {/foreach}
    </ul>
</nav>