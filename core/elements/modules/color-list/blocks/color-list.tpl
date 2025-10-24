{set $optval = '@FILE snippets/getOptionProduct2.php' | snippet : [
    'name' => 'ottenok'
  ]}
{set $data = '@FILE modules/color-list/snippets/getBlockData.php' | snippet : [
  'ottenokItems' => $linksData.ottenok.items
]}
<div class="product-info__color-list">
  <p class="product-info__color-list-caption">Оттенок <b><span class="placeholder">{$optval[0]}</span></b></p>
  <div class="product-info__color-list-slider swiper-container">
    <div class="swiper-wrapper">
      {foreach $data.ottenokItems as $item}
        <div class="swiper-slide" ><a href="{$item.id | url}" data-product="{$item.id}"><img class="product-info__color-list-img" src="{$item.thumb}" alt="Вариант цвета"></a></div>
      {/foreach}
      <div class="swiper-slide">Slide 1</div>
      <div class="swiper-slide">Slide 2</div>
      <div class="swiper-slide"><a href="#" class="show-more">Показать еще</a></div>
    </div>
    <div class="swiper-button-prev"></div>
    <div class="swiper-button-next"></div>
  </div>
</div>
