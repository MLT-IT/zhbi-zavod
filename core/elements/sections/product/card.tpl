{set $reviews = '@FILE snippets/getReviews.php' | snippet | fromJSON}

<div class="product-card__content">
    {if $_modx->resource.context_key === 'krovlya'}
        {include "file:sections/product/card-info-krovlya.tpl"}
    {else}
        {include "file:sections/product/card-info.tpl"}
    {/if}

    <div class="product-card__about">
        {if $_modx->resource.introtext}
            {$_modx->resource.introtext}
        {/if}
    </div>
    {include "file:sections/product/card-tabs.tpl"}
</div>
