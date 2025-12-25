{extends "file:layouts/base.tpl"} 

{block 'page-content'} 

    {set $products = "@FILE modules/cart/backend/snippets/getProducts.php" | snippet}

    {include "file:sections/breadcrumbs/wrapper.tpl"}

    <div class="cart-page section-margin">
        <div class="container">
            {include "file:templates/cart/header.tpl" products=$products}
            
            {if count($products) > 0}
                {include "file:templates/cart/items.tpl" products=$products}
                {include "file:templates/cart/footer.tpl"}
            {else}
                <div class="d-grid gap-16 m-auto w-max-content">
                    <div class="fs-24 fw-700 text-center">Корзина пока пуста</div>
                    <a class="btn btn-primary" href="{$_modx->getPlaceholder('makeurls.catalog')}">вернуться к покупкам</a>
                </div>
            {/if}
        </div>
    </div>

    {include "file:sections/address-map/wrapper.tpl"}
{/block}
