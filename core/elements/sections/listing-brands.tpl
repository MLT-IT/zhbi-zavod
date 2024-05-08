<article class="products-preview section">
  <div class="products-preview__container">
    <h1 class="section__title products-preview__title">
      {switch $_modx->resource.context_key}
        {case 'web'}
          {set $text = 'утеплителей'}
        {case 'plitnye'}
          {set $text = 'плит'}
        {case 'stenovye'}
          {set $text = 'стеновых материалов'}
        {case 'gazosilikatstroy'}
          {set $text = 'газобетона'}
        {case 'kraska'}
          {set $text = 'лакокрасочных материалов'}
        {case 'suhiesmesi'}
          {set $text = 'сухих смесей'}
        {case 'beltermo'}
          {set $text = 'сухих смесей'}
        {case 'fibrofasad'}
          {set $text = 'фиброфасадов'}
        {case 'krovelnyjstroymarket'}
          {set $text = $_modx->resource.pagetitle}
      {/switch}
      {if $_modx->context.key == 'krovelnyjstroymarket'}
          {$text}
        {else}
        Продажа {$text} в Санкт-Петербурге
      {/if}
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
