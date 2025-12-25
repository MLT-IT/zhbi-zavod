{set $categories = "@FILE modules/map-resources/mapGetResourcesByWhere.php" | snippet : [
    'data' => $_modx->getPlaceholder('map-resources.category'),
    'where' => '{"parent":'~$_modx->resource.id~'}'
]}

<div class="main-category__categories">
    <div class="main-category__categories-content active">
        <div class="main-category__categories-grid">
            {foreach $categories as $category}
                {include "file:sections/main-category/category-item.tpl" 
                    url="{$category['uri']}" 
                    title="{$category['menutitle']}" 
                    image="{$category['main_image']}"
                }
            {/foreach}
        </div>
    </div>
</div>