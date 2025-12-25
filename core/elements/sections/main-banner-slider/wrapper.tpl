<!-- {set $data = "@FILE snippets/getJsonData.php" | snippet : [
    "path" => "/assets/template/json/main-banner-slider/"~$_modx->context.key~".json"
]} -->

{if $data['status'] == 'success'}
<div class="main-banner-slider bg-light-gray-2">
  <div class="container">
    <div class="swiper" data-slider="main-banner-slider">
      <div class="main-banner-slider__row swiper-wrapper">
        {foreach $data['data'] as $slide}
        <div class="slider-item swiper-slide cursor-pointer" {if $slide['options']['modal-callback']}onclick="modals.events.open('modal-callback')"{/if}>
          <picture>
            <source srcset="{$slide['images']['xl']}" media="(min-width: 981px)" />
            <source srcset="{$slide['images']['lg']}" media="(min-width: 749px)" />
            <source srcset="{$slide['images']['md']}" media="(min-width: 461px)" />
            <source srcset="{$slide['images']['sm']}" media="(max-width: 460px)" />
            <img src="{$slide['images']['xl']}" />
          </picture>
        </div>
        {/foreach}
      </div>

      <div class="swiper-button-prev base-box-shadow"></div>
      <div class="swiper-button-next base-box-shadow"></div>
    </div>
  </div>
</div>
{/if}
