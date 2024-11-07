{set $images = '@FILE snippets/migx/getRecurGallery.php' | snippet : ['id' => $_modx->resource.id, 'cache' => false]}
{if $images}
<h3 class="page-title line">Фото наших покупателей</h3>
<div class="ugg container">
  <div class="swiper-container ugg__container">
    <div class="swiper-wrapper ugg__wrapper">
    {foreach $images as $img}
      {set $thumb = 'phpthumbon' | snippet : [
        'input' => "/assets/{$img}",
        'options' => '&w=200&h=170&zc=1'
      ]}
      <div class="swiper-slide ugg__slide">
        <div class="ugg__slide-wrapper">
          <a data-fancybox="ugg" href="/assets/{$img}"><img src="{$thumb}" alt="" /></a>
        </div>
      </div>
    {/foreach}
    </div>
  </div>
  <div class="slider-arrows">
    <div class="arrow arrow-prev swiper-button-prev"></div>
    <div class="arrow arrow-next swiper-button-next"></div>
  </div>
</div>
{/if}
