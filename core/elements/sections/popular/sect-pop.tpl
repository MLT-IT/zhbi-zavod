<section class="product-slider sect-pop{if $class?} {$class}{/if}">
    <div class="wrapper sect-pop__wrapper">
        <div class="sect-pop__title title-1">{$title ?: "Популярные товары"}</div>
        <div class="swiper-buttons sect-pop__swiper-buttons">
            <div class="swiper-button-prev"></div>
            <div class="swiper-button-next"></div>
        </div>
        <div class="swiper-container">
            <div class="swiper-wrapper">
                {'!msProducts' | snippet : [
                    'parents' => 0,
                    'resources' => $_modx->config['popular_ids'],
                    'tplWrapper' => '@INLINE {{+output}}',
                    'tpl' => '@FILE sections/popular/pop-item.tpl',
                    'limit' => 0,
                    'where' => '{"context_key:=": "'~$_modx->resource.context_key~'"}'
                ]}
            </div>
        </div>
    </div>
</section>
