{set $recentlyViewed = '@FILE snippets/getRecentlyViewed.php' | snippet}

{if count($recentlyViewed)}
    <section class="product-slider sect-recent">
        <div class="wrapper">
            <span class="title-2">Вы недавно смотрели</span>
            <div class="swiper-container">
                <div class="swiper-buttons" style="display: none;">
                    <div class="swiper-button-prev"></div>
                    <div class="swiper-button-next"></div>
                </div>
                <div class="swiper-wrapper" data-items="{$recentlyViewed | dump}">
                    {'!msProducts' | snippet : [
                        'parents' => 0,
                        'depth' => 100,
                        'limit' => 42,
                        'sortby' => '',
                        'sortdir' => '',
                        'resources' => $recentlyViewed,
                        'tpl' => '@FILE sections/popular/popular-item.tpl',
                        'where' => '{"context_key:=": "'~$_modx->resource.context_key~'"}'
                    ]}
                </div>
            </div>
        </div>
    </section>
{/if}
