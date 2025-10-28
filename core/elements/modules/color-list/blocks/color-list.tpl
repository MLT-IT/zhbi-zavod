{set $optval = '@FILE snippets/getOptionProduct2.php' | snippet : [
    'name' => 'ottenok'
  ]}
{set $data = '@FILE modules/color-list/snippets/getBlockData.php' | snippet : [
  'ottenokItems' => $linksData.ottenok.items
]}
<div class="product-info__color-list">
  <p class="product-info__color-list-caption">Оттенок: <b><span class="placeholder">{$data.ottenok}</span></b></p>
  <div class="product-info__color-list-slider swiper-container">
    <div class="swiper-wrapper product-info__color-list-wrap">
      {foreach $data.ottenokItems as $item}
        <div class="swiper-slide">
          <div class="product-info__color-list-item"><a class="product-info__color-list-item-a" href="{$item.id | url}" data-product="{$item.id}" data-color-title="{$item.title}"><img class="product-info__color-list-img" src="{$item.thumb}" alt="Вариант цвета"></a>
          </div>
        </div>
      {/foreach}

      <div class="swiper-slide product-info__color-list-item"><a href="#" class="product-info__color-list-show-more">Показать<br> еще</a></div>
    </div>
     <div class="product-info__color-list-scroll swiper-scrollbar"></div>
  </div>
  <div class="product-info__color-list-nav">
    <div class="product-info__color-list-nav-btn swiper-button-prev"></div>
    <div class="product-info__color-list-nav-btn swiper-button-next"></div>
  </div>
</div>
