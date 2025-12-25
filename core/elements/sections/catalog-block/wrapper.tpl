<section class="catalog-block section-margin">
    <div class="container">
        <div class="catalog-block__wrapper">
            {if $_modx->getPlaceholder('context.catalog_id') != $_modx->resource.id}
                {include "file:sections/catalog-block/sidebar.tpl"}
            {/if}
            
            {include "file:sections/catalog-block/categories.tpl"} 
        </div>
    </div>
</section>