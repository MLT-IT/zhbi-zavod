{if ($files | count) > 1}
    <div class="product-card__gallery-btns-wrap swiper-buttons">
        <div class="product-card__gallery-btn product-card__gallery-btn_dir_prev"></div>
        <div class="product-card__gallery-btn product-card__gallery-btn_dir_next"></div>
    </div>
    <div class="product-card__gallery-slider swiper-container">
        <div class="swiper-wrapper">
            {set $imgTitle = $_modx->resource.menutitle ?: $_modx->resource.pagetitle}
            {foreach $files as $key => $file}
                <a class="swiper-slide product-card__gallery-item{if $key == 0} active{/if}" href="{$file['url']}" target="_blank">
                    <img class="product-card__gallery-item-img" src="{$file['small']}" alt="{$imgTitle} - фото {$key + 1}" title="{$imgTitle} - фото {$key + 1}">
                </a>
            {/foreach}
        </div>
    </div>
{/if}
