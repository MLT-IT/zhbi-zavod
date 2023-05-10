<article class="products-preview section">
  <div class="products-preview__container">
    <h1 class="section__title products-preview__title">
      {switch $_modx->resource.context_key}
        {case 'web'}
          {set $text = 'утеплителей'}
        {case 'gazosilikatstroy'}
          {set $text = 'газобетона'}
      {/switch}
      Продажа {$text} в Санкт-Петербурге
    </h1>
    <div class="products-preview__slider">
      <div class="swiper-container">
        <div class="swiper-wrapper">
            {if $resources is empty}
                {* Если popular_ids не заполнено, то resources будет пустой. И будут выводиться все товары подряд *}
                {set $resources = $_modx->config['popular_ids']}
            {/if}

            {'@FILE snippets/getCategoriesWithMinPrice.php' | snippet}
        </div>
      </div>
      <div class="swiper-buttons">
        <div class="swiper-button swiper-button-prev"></div>
        <div class="swiper-button swiper-button-next"></div>
      </div>
    </div>
  </div>
</article>
