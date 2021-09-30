<div class="product-card__tabs">
    <div class="product-card__tabs-buttons" data-tabs="product-card__tabs-pages">
{*        {if $_modx->resource.content}*}
            <div class="product-card__tabs-button active" data-tab-page="0">Описание</div>
{*        {/if}*}
        <div class="product-card__tabs-button" data-tab-page="1">Характеристики</div>

        <div class="product-card__tabs-button" data-tab-page="2"> Отзывы (<span>0</span>)</div>
    </div>
    <div class="product-card__tabs-pages">
        <div class="product-card__tabs-page active">
            {include 'file:sections/product/card-content-tab.tpl'}
        </div>
{*        {/if}*}
        <div class="product-card__tabs-page content-block">
            {include 'file:sections/product/card-specs-tab.tpl'}
        </div>
        <div class="product-card__tabs-page">
            {include 'file:sections/product/card-reviews-tab.tpl'}
        </div>
    </div>
</div>