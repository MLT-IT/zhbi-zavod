{set $banner_data = "@FILE snippets/apiGetBanner.php" | snippet : [
'id' => $_modx->resource.id,
'parent' => $_modx->resource.parent,
'position' => 'category'
]}
{set $banner_groups = $banner_data['data']}
{if $banner_data['status'] && !empty($banner_groups)}
  {set $banner_group = $banner_groups[0]}

  {set $banners = $banner_group['banners_by_type']}
  {set $button_settings = $banner_group['button']}
  {set $button_classname = $banner_group['data']['button-classname']}

<div class="category-banner" style="margin-top: 20px;">
  <div class="advertisement_note">Реклама</div>
  <picture>
    {if $banners['mobile']['image_url']}
      <source media="(max-width: 480px)" srcset="{$banners['mobile']['image_url']}">
    {/if}
    {if $banners['tablet']['image_url']}
      <source media="(max-width: 768px)" srcset="{$banners['tablet']['image_url']}">
    {/if}

    <img src="{$banners['desktop']['image_url']}" style="width:100%; height:auto;">
  </picture>

  <a class="category-banner__btn-desktop btn btn-primary justify-center {$button_classname ?: 'btn_style_base'}" onclick="modals.events.open('modal-callback')">
    {$banners['desktop']['data']['button-text'] ?: "заказать со скидкой"}
  </a>
  <a class="category-banner__btn-tablet btn btn-primary justify-center {$button_classname ?: 'btn_style_base'}" onclick="modals.events.open('modal-callback')">
    {$banners['tablet']['data']['button-text'] ?: "заказать со скидкой"}
  </a>
  <a class="category-banner__btn-mobile btn btn-primary justify-center {$button_classname ?: 'btn_style_base'}" onclick="modals.events.open('modal-callback')">
    {$banners['mobile']['data']['button-text'] ?: "заказать со скидкой"}
  </a>
</div>
<style>
  .category-banner{
    position: relative;
  }
  .category-banner__btn-desktop,
  .category-banner__btn-tablet,
  .category-banner__btn-mobile{
    position: absolute;
    align-items: center;
    display: flex;
    margin: auto;
    width: max-content;
  }
  .category-banner__btn-desktop{
      /* Основные стили */
      {foreach $banners['desktop']['button'] as $key => $value}
        {$key}:{$value};
      {/foreach}

      /* Дополнительные стили */
      {foreach $button_settings['desktop'] as $key => $value}
        {$key}:{$value};
      {/foreach}
  }
  .category-banner__btn-tablet{
      display: none;

      /* Основные стили */
      {foreach $banners['tablet']['button'] as $key => $value}
        {$key}:{$value};
      {/foreach}

      /* Дополнительные стили */
      {foreach $button_settings['tablet'] as $key => $value}
        {$key}:{$value};
      {/foreach}
  }
  .category-banner__btn-mobile{
      display: none;

      /* Основные стили */
      {foreach $banners['mobile']['button'] as $key => $value}
        {$key}:{$value};
      {/foreach}
      
      /* Дополнительные стили */
      {foreach $button_settings['mobile'] as $key => $value}
        {$key}:{$value};
      {/foreach}
  }
  @media (max-width: 768px){
    .category-banner__btn-desktop{ display: none; }
    .category-banner__btn-tablet{ display: flex; }
  }
  @media (max-width: 480px){
    .category-banner__btn-tablet{ display: none; }
    .category-banner__btn-mobile{ display: flex; }
  }
</style>
{else}
<!-- {$banner_groups | toJSON} -->
{/if}