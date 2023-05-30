{if $files | length == 0}
    {set $files = [
      ['small' => '/assets/images/no_image.jpg']
    ]}
{/if}
{set $altTitle = $_modx->resource.menutitle ?: $_modx->resource.pagetitle}

<div class="product__pictures">
  <div class="swiper-container product__pictures-thumbs">
    <div class="swiper-wrapper">
      {foreach $files as $key => $file}
        {set $alt = $altTitle}
        {if $key > 0}
            {set $alt = $alt ~ ' фото ' ~ ($key + 1)}
        {/if}

        <div class="swiper-slide product__pictures-thumb">
          <img class="product__pictures-image" src="{'site_url' | option}{$file['small']}" alt="{$alt}">
        </div>
      {/foreach}
    </div>
  </div>

  <div class="product__picture">
    <div class="swiper-container product__pictures-slider">
      <div class="swiper-wrapper">
        {foreach $files as $key => $file}
          {set $alt = $altTitle}
          {if $key > 0}
              {set $alt = $alt ~ ' фото ' ~ ($key + 1)}
          {/if}

          <div class="swiper-slide product__pictures-thumb">
            <a href="{'site_url' | option}{$file['url']}" data-fancybox class="zoom-here" itemscope itemtype="http://schema.org/ImageObject">
              <img class="product__pictures-image" src="{'site_url' | option}{$file['small']}" alt="{$alt}">
            </a>
          </div>
        {/foreach}
      </div>
    </div>
    <div class="product__actions">
      <button class="product-action product-action_favorite js-product__btn-fav{if $checkItems['fav'][$_modx->resource['id']]?} active{/if}"></button>
      {*
      <button class="product-action product-action_compare js-product__btn-compare{if $checkItems['comp'][$_modx->resource['id']]?} active{/if}"></button>
      *}
    </div>
  </div>
</div>
