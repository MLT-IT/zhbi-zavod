<div class="header__cart-wrap">
    <a class="header__cart" href="/cart/">
        <div class="header__cart-button">
            <svg class="svg icon-cart-2" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
                 version="1.1">
                <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-cart-2"></use>
            </svg>
            <div class="header__cart-value hidden">{$total_count | round}</div>
        </div>
        <span class="header__cart-text">Корзина</span>
    </a>

    <div class="header__info">
        <span class="header__info-line">
            <span class="header__info-text">В корзине: </span>
            <span class="header__info-val header__info-val_type_count-val">{$total_count | round}</span>
            <span class="header__info-val header__info-val_type_count-text">
                {'@FILE snippets/formOfWord.php' | snippet : [
                'n' => $total_count,
                'f1' => 'товар',
                'f2' => 'товара',
                'f5' => 'товаров'
                ]}
            </span>
        </span>
        <span class="header__info-line">
            <span class="header__info-text">Итого: </span>
            <span class="header__info-val header__info-val_type_cost-val">{$total_cost | round | replace : '.' : ','}</span>
            <span class="header__info-val"> руб</span>
        </span>
        <a class="header__info-btn header__info-btn_to-cart custom-btn" href="/cart">Перейти в корзину</a>
        <a class="header__info-btn custom-btn" data-fancybox href="#order">Перейти к оформлению</a>
    </div>
</div>
