{set $reviews = '@FILE snippets/getReviews.php' | snippet | fromJSON}

<div class="product-card__content">

    {if $_modx->resource.template in list [17, 20]}
        {* Кровля *}
        {include "file:sections/product/card-info-relinking-selects.tpl"}
    {elseif $_modx->resource.template == 21}
        {* Фанера *}
        {include "file:sections/product/card-info-relinking-btns.tpl"}
    {else}
        {* Обычная карточка *}
        {include "file:sections/product/card-info.tpl"}
    {/if}

    {if $_modx->resource.introtext?}
        <div class="product-card__about">
            {$_modx->resource.introtext}
        </div>
    {/if}
    {include "file:sections/product/card-tabs.tpl"}
</div>
