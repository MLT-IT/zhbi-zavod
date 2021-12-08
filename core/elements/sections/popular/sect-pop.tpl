<section class="product-slider sect-pop">
    <div class="wrapper sect-pop__wrapper">
        <h2 class="sect-pop__title title-2">{$title ?: "Популярные товары"}</h2>
        <div class="swiper-buttons sect-pop__swiper-buttons">
            <div class="swiper-button-prev"></div>
            <div class="swiper-button-next"></div>
        </div>
        <div class="swiper-container">
            <div class="swiper-wrapper">
                {if $resources is empty}
                    {* Если popular_ids не заполнено, то resources будет пустой. И будут выводиться все товары подряд *}
                    {set $resources = $_modx->config['popular_ids']}
                {/if}

                {'!msProducts' | snippet : [
                    'parents' => 0,
                    'depth' => 50,
                    'limit' => 42,
                    'resources' => $resources,
                    'tplWrapper' => '@INLINE {{+output}}',
                    'tpl' => '@FILE sections/popular/pop-item.tpl',
                    'where' => '{"context_key:=": "'~$_modx->resource.context_key~'"}'
                ]}
            </div>
        </div>
    </div>
</section>
