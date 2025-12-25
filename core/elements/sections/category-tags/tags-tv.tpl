{* Теги из TV поля tags *}
{foreach $_modx->resource.tags | fromJSON as $group_index => $tag}
    {if $tag['ids']}
        {set $categories = "@FILE modules/map-resources/mapSeparateResources.php" | snippet : [
            'data' => $_modx->getPlaceholder('map-resources.category'),
            'ids' => $tag['ids']
        ]}
    {/if}
    
    <div class="category-tags__group">
        {if $tag['group_name']}
            <div class="category-tags__group-name">{$tag['group_name']}</div>
        {/if}

        {include "file:sections/category-tags/items.tpl" items=$categories group_index=$group_index}
    </div>
{/foreach}