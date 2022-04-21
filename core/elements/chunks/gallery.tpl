{if $files?}
    {set $imgTitle = $_modx->resource.menutitle ?: $_modx->resource.pagetitle}
    {foreach $files as $key => $file}
        <a class="swiper-slide product-card__gallery-item{if $key == 0} active{/if}" href="{$file['url']}" target="_blank">
            <img class="product-card__gallery-item-img" src="{$file['small']}" alt="{$imgTitle} - фото {$key + 1}" title="{$imgTitle} - фото {$key + 1}">
        </a>
    {/foreach}
{/if}

