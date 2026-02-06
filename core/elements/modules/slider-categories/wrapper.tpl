{set $items = "@FILE modules/slider-categories/snippets/getCategories.php" | snippet}

<div class="slider-categories section-margin">
  <div class="container">
    <h1 class="section-title">{$_modx->getPlaceholder('words.materials')[1]} в Санкт-Петербурге</h1>
    <div class="swiper" data-slider="slider-categories">
      <div class="slider-categories__row swiper-wrapper">
        {foreach $items as $item}
          <a class="slider-categories__item swiper-slide" href="{$item['uri']}">
            <div class="slider-categories__item-image">
              <img src="{$item['main_image']}" />
            </div>
            <div class="slider-categories__item-title fw-700">{$item['menutitle']}</div>
            {if $item['price']}
              <div class="slider-categories__item-price fw-700">от {$item['price']} ₽</div>
              <div class="slider-categories__item-unit fs-14 color-gray">{$item['unit']}</div>
            {/if}
            <button class="btn btn-primary" href="{$item['uri']}">Перейти</button>
          </a>
        {/foreach}
      </div>
      <div class="swiper-button-prev base-box-shadow"></div>
      <div class="swiper-button-next base-box-shadow"></div>
    </div>
  </div>
</div>