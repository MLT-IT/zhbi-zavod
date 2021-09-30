<div class="product-card__content">
    {include "file:sections/product/card-info.tpl"}
    <div class="product-card__about">
        {if $_modx->resource.introtext}
            {$_modx->resource.introtext}
        {/if}
    </div>
    {include "file:sections/product/card-tabs.tpl"}
</div>