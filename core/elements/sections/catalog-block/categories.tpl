{set $categories = "@FILE modules/map-resources/mapGetResourcesByWhere.php" | snippet : [
    'data' => $_modx->getPlaceholder('map-resources.category'),
    'where' => '{"parent":'~$_modx->resource.id~'}'
]}

<div class="catalog-block__categories">
    <div class="catalog-block__categories-content active">
        <div class="catalog-block__categories-grid">
            {foreach $categories as $category}
                {include "file:sections/catalog-block/category-item.tpl" 
                    url="{$category['uri']}" 
                    title="{$category['menutitle']}" 
                    image="{$category['main_image']}"
                }
            {/foreach}
        </div>
    </div>
</div>