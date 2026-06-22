{* Вывод баннеров слайдером *}
{* @param $banner_groups - массив групп баннеров полученный по апи *}

<div class="product-card catalog-listing-banner block-bg" style=" padding: 0; ">
  <div class="advertisement_note">Реклама</div>
  <article class="catalog-side-carousel">
    <div class="swiper">
      <div class="swiper-wrapper">
        {foreach $banner_groups as $banner_group}
          {set $banners = $banner_group['banners_by_type']}
          {set $button_settings = $banner_group['button']}
          {set $button_classname = $banner_group['data']['button-classname']}
          {set $button_hidden=$banners['mobile']['data']['button-hidden']}

          <div class="swiper-slide" {if $button_hidden}data-fancybox href="#callback"{/if}>
            <picture>
              {if $banners['mobile']['image_url']}
                <source media="(max-width: 480px)" srcset="{$banners['mobile']['image_url']}">
              {/if}
              {if $banners['tablet']['image_url']}
                <source media="(max-width: 768px)" srcset="{$banners['tablet']['image_url']}">
              {/if}
              <img src="{$banners['desktop']['image_url']}" style="width:100%; height:auto;">
            </picture>

            {include "file:banners/category-product/buttons.tpl" button_hidden=$button_hidden banners=$banners button_classname=$button_classname}
          </div>
        {/foreach}
      </div>
      <div class="swiper-button-prev"></div>
      <div class="swiper-button-next"></div>
    </div>
  </article>
</div>
{* Переменные $banners и $button_settings подтянутся из последней итерации foreach *}
{* Так как стили для всех элементов одинаковы *}
{include "file:banners/category-product/style.tpl" banners=$banners button_settings=$button_settings}