{if 'popular_ids' | option}
    <section class="product-slider">
        <div class="wrapper">
            <div class="title-1">{$title ?: "Популярные товары"}</div>
            <div class="swiper-container fadeInUp">
                <div class="swiper-buttons">
                    <div class="swiper-button-prev"></div>
                    <div class="swiper-button-next"></div>
                </div>
                <div class="swiper-wrapper">
                    {'!msProducts' | snippet : [
                        'parents' => 0,
                        'resources' => 'popular_ids' | option,
                        'tplWrapper' => '@INLINE {{+output}}',
                        'tpl' => '@FILE sections/popular/popular-item.tpl'
                    ]}
                </div>
            </div>
        </div>
    </section>
{/if}
