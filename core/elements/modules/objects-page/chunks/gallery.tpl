{if $files | len}
  <div class="thumbs-gallery simple-gallery">
    <div thumbsSlider="" class="swiper mySwiper">
      <div class="swiper-wrapper">
      {foreach $files as $file}
        {set $thumb = 'phpthumbon' | snippet : [
            'input' => "{$path~$file.img}",
            'options' => '&w=400&h=250&zc=1'
        ]}
        <div class="swiper-slide">
          <a href="{$path~$file.img}" data-fancybox='object' target="_blank">
            <img src="{$thumb}" alt="">
          </a>
        </div>
      {/foreach}
      </div>
      <div class="swiper-nav">
        <div class="swiper-button-prev"></div>
        <div class="swiper-button-next"></div>
      </div>
    </div>
  </div>
{/if}
  