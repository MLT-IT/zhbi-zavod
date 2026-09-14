{if $files | len}
  <div class="thumbs-gallery">
    <div style="--swiper-navigation-color: #fff; --swiper-pagination-color: #fff" class="swiper mySwiper2">
      <div class="swiper-wrapper">
      {foreach $files as $file}
        {set $thumb = 'phpthumbon' | snippet : [
            'input' => "{$path~$file.img}",
            'options' => '&w=300&h=200&zc=1'
        ]}
        <div class="swiper-slide">
          <a href="{$path~$file.img}" data-fancybox='object' target="_blank">
              <img src="{$thumb}" alt="">
          </a>
        </div>
      {/foreach}
      </div>
        <div class="swiper-button-next"></div>
        <div class="swiper-button-prev"></div>
    </div>
    <div thumbsSlider="" class="swiper mySwiper">
      <div class="swiper-wrapper">
      {foreach $files as $file}
        {set $thumb = 'phpthumbon' | snippet : [
            'input' => "{$path~$file.img}",
            'options' => '&w=200&h=170&zc=1'
        ]}
        <div class="swiper-slide">
          
              <img src="{$thumb}" alt="">
  
        </div>
      {/foreach}
      </div>
    </div>
  </div>
  {/if}
  