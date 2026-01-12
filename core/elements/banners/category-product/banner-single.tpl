{* Вывод одного баннера *}
{* @param $banner_groups - массив групп баннеров полученный по апи *}

{foreach $banner_groups as $banner_group}
  {set $banners = $banner_group['banners_by_type']}
  {set $button_settings = $banner_group['button']}
  {set $button_classname = $banner_group['data']['button-classname']}
  {set $button_hidden=$banners['mobile']['data']['button-hidden']}

  <div class="product-card base-box-shadow catalog-listing-banner block-bg" style=" padding: 0; ">
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

{include "file:banners/category-product/style.tpl" banners=$banners button_settings=$button_settings}