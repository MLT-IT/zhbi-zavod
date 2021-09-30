{set $recentlyViewed = '@FILE snippets/getRecentlyViewed.php' | snippet}
{if count($recentlyViewed)}
    <section class="product-slider">
        <div class="wrapper">
            <span class="title-1">Вы недавно смотрели</span>
            <div class="swiper-container fadeInUp">
                <div class="swiper-buttons">
                    <div class="swiper-button-prev"></div>
                    <div class="swiper-button-next"></div>
                </div>
                <div class="swiper-wrapper">
                    {foreach $recentlyViewed as $rv}
                        <div class="swiper-slide product-slider__slide">
                            <a class="product-slider__slide-img" href="{$rv['image']}">
                                {if $rv['image']?}
                                    {set $img = $rv['image']}
                                {else}
                                    {set $img = '/assets/images/no_image.jpg'}
                                {/if}
                                <img src="{$img}">
                            </a>
                            <a class="product-slider__slide-title" href="#">{$rv['name']}</a>
                            <div class="product-slider__slide-price"><span>{$rv['price']}₽</span>
                                <div class="product-slider__slide-price-availability">В наличии</div>
                            </div>
                            <div class="product-slider__slide-button yellow-btn">
                                <svg class="svg icon-cart" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 19 19" width="19" height="19">
                                    <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-cart"></use>
                                </svg>В КОРЗИНУ
                            </div>
                        </div>
                    {/foreach}
                </div>
            </div>
        </div>
    </section>
{/if}
