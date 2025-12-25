{set $categories = "@FILE modules/map-resources/mapGetResourcesByWhere.php" | snippet : [
    'data' => $_modx->getPlaceholder('map-resources.category'),
    'where' => '{"parent":'~$_modx->resource.id~'}'
]}

<div class="catalog__categories">
    <div class="catalog__categories-content active">
        <div class="catalog__categories-grid">
            {foreach $categories as $category}
                {include "file:sections/catalog/category-item.tpl" 
                    url="{$category['uri']}" 
                    title="{$category['menutitle']}" 
                    image="{$category['main_image']}"
                }
            {/foreach}
        </div>
    </div>
</div>