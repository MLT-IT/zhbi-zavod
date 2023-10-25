{if $title is empty}
    {set $title = 'Похожие товары'}
{/if}
{if $output is not empty}
<article class="other-products section section_view_bg" id="simillar-products">
  <div class="other-products__container">
    <h2 class="other-products__title section__title">{$title}</h2>
    <div class="other-products__slider">
      <div class="swiper-container swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events">
        <div class="swiper-wrapper" style="transform: translate3d(0px, 0px, 0px); transition-duration: 0ms;">
            {$output}
        </div>
      </div>
      <div class="swiper-buttons">
        <div class="swiper-button swiper-button-prev swiper-button-disabled"></div>
        <div class="swiper-button swiper-button-next swiper-button-disabled"></div>
      </div>
    </div>
  </div>
</article>
{/if}
