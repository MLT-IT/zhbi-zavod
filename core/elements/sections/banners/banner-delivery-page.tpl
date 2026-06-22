{set $ctx = $_modx->resource.context_key}
{set $slides = $_modx->resource.pageSliders | fromJSON}

<article class="main-screen delivery-page section">
  <div class="main-screen__container">
<div class="main-screen__banners section">
  {set $params = [
    'krovelnyjstroymarket' => [
      'nav' => false
      'paging_class' => 'swiper-pagination--rounds'
      'slides' => $slides
    ]
  ]}
  <div class="main-screen__slider">
    <div class="swiper-container">
      <div class="swiper-wrapper">
        {foreach $params[$ctx].slides as $slide}
            <div class="swiper-slide banner">
            <div class="advertisement_note">Реклама</div>
            <div class="wrapper">
                <picture class="banner__bg">
                {set $images = $slide.images | fromJSON}
                {set $last = $images | count - 1}
                {set $images = '@FILE snippets/keySort.php' | snippet: ['input' => $images, 'key' => 'media']}
                {foreach $images as $source}
                {set $img = '@FILE snippets/fixSpaces.php' | snippet: ['input' => $source.image] }
                <source srcset="assets/template/pictures/main-screen/{$img}" media="screen and {$source.media}">
                {/foreach}
                <img class="banner__bg-img" src="assets/template/pictures/main-screen/{$images[$last].image}" alt="banner">
                </picture>
                <div class="banner__action"><span data-fancybox data-src="{$slide['button-link'] ?: '#callback'}" class="banner__btn btn btn_style_yellow">{$slide['button-text'] ?: 'Заказать со скидкой'}</span></div>
            </div>
            </div>
        {/foreach}
      </div>
      
    </div>
    <div class="swiper-pagination {$params[$ctx].paging_class}"></div>
    {if $params[$ctx].nav}
    <div class="swiper-buttons">
      <div class="swiper-button swiper-button-prev"></div>
      <div class="swiper-button swiper-button-next"></div>
    </div>
    {/if}
  </div>
</div>
</div>
</div>
