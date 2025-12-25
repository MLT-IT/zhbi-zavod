<div class="cart-page__items mb-24">
    {if !$products}
        Пусто
    {else}
        {foreach $products as $product}
            {include "file:modules/product-cards/chunks/v3/wrapper.tpl" product=$product}
        {/foreach}
    {/if}
</div>