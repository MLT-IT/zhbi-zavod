<!-- {set $data = "@FILE snippets/getJsonData.php" | snippet : [
    "path" => $path
]} -->

{if $data['status'] == 'success'}
<div class="main-banner-slider bg-light-gray-2">
  <div class="container">
    <div class="swiper" data-slider="main-banner-slider">
      <div class="advertisement_note">Реклама</div>
      <div class="main-banner-slider__row swiper-wrapper">
        {foreach $data['data'] as $slide}
        <div class="slider-item swiper-slide cursor-pointer">
          <picture>
            <source srcset="{$slide['images']['xl']}" media="(min-width: 981px)" />
            <source srcset="{$slide['images']['lg']}" media="(min-width: 749px)" />
            <source srcset="{$slide['images']['md']}" media="(min-width: 461px)" />
            <source srcset="{$slide['images']['sm']}" media="(max-width: 460px)" />
            <img src="{$slide['images']['xl']}" />
          </picture>

          {if $slide['options']['modal-callback']}
          <button class="btn btn-beauty main-banner-slider__callback-btn"
            onclick="modals.events.open('modal-callback')">Заказать со скидкой</button>
          {/if}
        </div>
        {/foreach}
      </div>

      <div class="swiper-button-prev base-box-shadow"></div>
      <div class="swiper-button-next base-box-shadow"></div>
    </div>
  </div>
</div>
{/if}