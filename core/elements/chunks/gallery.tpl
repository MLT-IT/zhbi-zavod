{set $amountPhotos = $files | count}

{* У шаблонов 6, 21 стрелки выводятся, только если фоток больше 4. У шаблонов 17, 20 стрелки выводятся в зависимости от ширины экрана, поэтому изначально прячем их в любом случае *}
{set $hideButtons = (($amountPhotos < 5) && ($_modx->resource.template in list [6, 21])) ||
$_modx->resource.template in list [17, 20]}

{if $amountPhotos > 1}
    <div class="product-card__gallery-btns-wrap swiper-buttons"
        {if $hideButtons}
            style="display: none;"
        {/if}
    >
        <div class="product-card__gallery-btn product-card__gallery-btn_dir_prev"></div>
        <div class="product-card__gallery-btn product-card__gallery-btn_dir_next"></div>
    </div>
    <div class="product-card__gallery-slider swiper-container{if ($hideButtons) && ($_modx->resource.template in list [6, 21])} product-card__gallery-slider_without-buttons{/if}">
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
