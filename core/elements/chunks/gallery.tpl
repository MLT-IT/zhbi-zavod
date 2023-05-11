{if $files | length == 0}
    {set $files = [
      ['small' => '/assets/images/no_image.jpg']
    ]}
{/if}

<div class="product__pictures">
  <div class="swiper-container product__pictures-thumbs">
    <div class="swiper-wrapper">
      {foreach $files as $key => $file}
        <div class="swiper-slide product__pictures-thumb">
          <img class="product__pictures-image" src="{'site_url' | option}{$file['small']}" alt="{$imgTitle} - фото {$key + 1}">
        </div>
      {/foreach}
    </div>
  </div>

  <div class="product__picture">
    <div class="swiper-container product__pictures-slider">
      <div class="swiper-wrapper">
        {foreach $files as $key => $file}
          <a href="{'site_url' | option}{$file['small']}" data-fancybox class="swiper-slide product__pictures-thumb" itemscope itemtype="http://schema.org/ImageObject">
            <img class="product__pictures-image" src="{'site_url' | option}{$file['small']}" alt="{$imgTitle} - фото {$key + 1}">
          </a>
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
