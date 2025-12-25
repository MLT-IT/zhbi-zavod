<div class="category-tags section-margin bg-light-gray-2">
    <div class="container">
        <div class="category-tags__row">
            {if $_modx->resource.tags}
                {include "file:sections/category-tags/tags-tv.tpl"}
            {else}
                {include "file:sections/category-tags/tags-children.tpl"}
            {/if}
        </div>
    </div>
</div>