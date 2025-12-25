<section class="main-category section-margin">
    <div class="container">
        <h1 class="page-title mb-16">{$_modx->resource.pagetitle}</h1>
        <div class="main-category__wrapper">
            {if $_modx->getPlaceholder('context.catalog_id') != $_modx->resource.id}
                {include "file:sections/main-category/sidebar.tpl"}
            {/if}
            
            <div class="main-category__content">
                {if $_modx->getPlaceholder('context.catalog_id') != $_modx->resource.id}
                    <a href="{$_modx->makeUrl($_modx->getPlaceholder('context.catalog_id'))}" class="main-category__back">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                            <path d="M15 18L9 12L15 6" stroke="currentColor" stroke-width="2"/>
                        </svg>
                        <span>Назад в каталог</span>
                    </a>
                {/if}
                {include "file:sections/main-category/categories.tpl"} 
            </div>
        </div>
    </div>
</section>