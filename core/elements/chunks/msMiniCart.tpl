<a class="header__cart" href="/cart/">
    <div class="header__cart-button">
        <svg class="svg icon-cart-2" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
            <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-cart-2"></use>
        </svg>
        {if $total_count > 0}
            <div class="header__cart-value">{$total_count}</div>
        {/if}
    </div>
    <span class="header__cart-text">Корзина</span>
</a>
