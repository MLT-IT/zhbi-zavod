<section class="product-slider">
    <div class="wrapper">
        <div class="title-1">{$title ?: "Популярные товары"}</div>
        <div class="swiper-container">
            <div class="swiper-buttons">
                <div class="swiper-button-prev"></div>
                <div class="swiper-button-next"></div>
            </div>
            <div class="swiper-wrapper">
                <div class="swiper-slide product-slider__slide">
                    <a class="product-slider__slide-img" href="#">
                        <img src="{$_modx->config['template_path']}img/beton/beton1.png" alt="">
                    </a>
                    <a class="product-slider__slide-title" href="#">Бетон товарный</a>
                    <div class="product-slider__slide-price"><span>32 000₽</span>
                        <div class="product-slider__slide-price-availability">В наличии</div>
                    </div>
                    <div class="product-slider__slide-button yellow-btn">
                        <svg class="svg icon-cart" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 19 19" width="19" height="19">
                            <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-cart"></use>
                        </svg>В КОРЗИНУ
                    </div>
                </div>
                <div class="swiper-slide product-slider__slide">
                    <a class="product-slider__slide-img" href="#">
                        <img src="{$_modx->config['template_path']}img/beton/beton2.png" alt="">
                    </a>
                    <a class="product-slider__slide-title" href="#">Бетон товарный Зернистый</a>
                    <div class="product-slider__slide-price"><span>2 000₽</span>
                        <div class="product-slider__slide-price-availability">В наличии</div>
                    </div>
                    <div class="product-slider__slide-button yellow-btn">
                        <svg class="svg icon-cart" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 19 19" width="19" height="19">
                            <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-cart"></use>
                        </svg>В КОРЗИНУ
                    </div>
                </div>
                <div class="swiper-slide product-slider__slide">
                    <a class="product-slider__slide-img" href="#">
                        <img src="{$_modx->config['template_path']}img/beton/beton3.png" alt="">
                    </a>
                    <a class="product-slider__slide-title" href="#">Бетон товарный товарный бетон</a>
                    <div class="product-slider__slide-price"><span>5 000₽</span>
                        <div class="product-slider__slide-price-availability">В наличии</div>
                    </div>
                    <div class="product-slider__slide-button yellow-btn">
                        <svg class="svg icon-cart" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 19 19" width="19" height="19">
                            <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-cart"></use>
                        </svg>В КОРЗИНУ
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
