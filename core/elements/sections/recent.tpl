{set $recentlyViewed = '@FILE snippets/getRecentlyViewed.php' | snippet}
{if count($recentlyViewed)}
    <section class="product-slider sect-recent">
        <div class="wrapper">
            <span class="title-2">Вы недавно смотрели</span>
            <div class="swiper-container">
                <div class="swiper-buttons">
                    <div class="swiper-button-prev"></div>
                    <div class="swiper-button-next"></div>
                </div>
                <div class="swiper-wrapper">
                    {foreach $recentlyViewed as $rv}
                        {$_modx->getChunk('@FILE sections/popular/popular-item.tpl', [
                        'uri' => $rv.url,
                        'thumb' => $rv.thumb,
                        'menutitle' => $rv.name,
                        'price' => $rv.price,
                        'id' => $rv.id
                        ])}
                    {/foreach}
                </div>
            </div>
        </div>
    </section>
{/if}
