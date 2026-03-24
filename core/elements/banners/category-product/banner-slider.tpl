{* Вывод баннеров слайдером *}
{* @param $banner_groups - массив групп баннеров полученный по апи *}

{set $show_navigation = count($banner_groups) >= 2}

<div class="product-card product-banner base-box-shadow catalog-listing-banner block-bg" style="padding: 0;">
  <div class="swiper" data-slider="catalog-side-carousel">
    <div class="swiper-wrapper">
      {foreach $banner_groups as $banner_group}
        {set $banners = $banner_group['banners_by_type']}
        {set $button_settings = $banner_group['button']}
        {set $button_classname = $banner_group['data']['button-classname']}
        {set $button_hidden = $banners['mobile']['data']['button-hidden']}

        <div class="swiper-slide product-banner" {if $button_hidden}data-fancybox href="#callback"{/if}>
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

    {if $show_navigation}
      <div class="swiper-button-prev base-box-shadow"></div>
      <div class="swiper-button-next base-box-shadow"></div>
    {/if}
  </div>
</div>

{* Переменные $banners и $button_settings подтянутся из последней итерации foreach *}
{* Так как стили для всех элементов одинаковы *}
{include "file:banners/category-product/style.tpl" banners=$banners button_settings=$button_settings}
