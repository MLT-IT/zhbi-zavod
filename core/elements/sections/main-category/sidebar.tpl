{set $categories = "@FILE modules/map-resources/mapGetResourcesByWhere.php" | snippet : [
    'data' => $_modx->getPlaceholder('map-resources.category'),
    'where' => '{"parent":'~$_modx->getPlaceholder('context.catalog_id')~'}'
]}

<nav class="main-category__sidebar">
    <ul class="main-category__sidebar-list">
        {foreach $categories as $index => $category}
            <li class="main-category__sidebar-item">
                <a href="{$category['uri']}" class="
                    main-category__sidebar-link
                    {if $category['id'] == $_modx->resource.id}active{/if}
                    ">
                    <svg><use xlink:href="{$category['icon']}"></use></svg>
                    <span class="main-category__sidebar-text">{$category['menutitle']}</span>
                </a>
            </li>
        {/foreach}
    </ul>
</nav>