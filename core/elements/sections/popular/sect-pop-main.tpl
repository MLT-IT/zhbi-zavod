{if $jsClass is empty}
    {set $jsClass = 'product-slider-1'}
{/if}

<section class="product-slider {$jsClass} sect-pop">
  <div class="wrapper sect-pop__wrapper">
    <h2 class="sect-pop__title title-2">{$title ?: "Популярные товары"}</h2>
    <div class="swiper-buttons sect-pop__swiper-buttons" style="display: none;">
      <div class="swiper-button-prev"></div>
      <div class="swiper-button-next"></div>
    </div>
    <div class="swiper-container">
      <div class="swiper-wrapper sect-pop__slider">
          {if $resources is empty}
              {* Если popular_ids не заполнено, то resources будет пустой. И будут выводиться все товары подряд *}
              {set $resources = $_modx->config['popular_ids']}
          {/if}
          {'!msProducts' | snippet : [
          'parents' => 0,
          'depth' => 50,
          'limit' => 42,
          'sortby' => '',
          'sortdir' => '',
          'resources' => $resources,
          'tpl' => '@FILE sections/popular/pop-slide.tpl',
          'where' => '{"context_key:=": "'~$_modx->resource.context_key~'"}',
          'includeTVs' => 'isFractional,productNotAvailable',
          ]}
      </div>
      <div class="swiper-scrollbar"></div>
    </div>
  </div>
</section>
