{* @param $banners - Баннеры *}
{* @param $button_settings - Настройки для кнопок *}

<style>
  .product-banner{
    position: relative;
  }
  .product-banner__btn-desktop,
  .product-banner__btn-tablet,
  .product-banner__btn-mobile{
    position: absolute;
    align-items: center;
    display: flex;
    margin: auto;
    width: max-content;
  }
  .product-banner__btn-desktop{
      /* Основные стили */
      {foreach $banners['desktop']['button'] as $key => $value}
        {$key}:{$value};
      {/foreach}
      /* Дополнительные стили */
      {foreach $button_settings['desktop'] as $key => $value}
        {$key}:{$value};
      {/foreach}
  }
  .product-banner__btn-tablet{
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
  .product-banner__btn-mobile{
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
    .product-banner__btn-desktop{ display: none; }
    .product-banner__btn-tablet{ display: flex; }
  }
  @media (max-width: 480px){
    .product-banner__btn-tablet{ display: none; }
    .product-banner__btn-mobile{ display: flex; }
  }
</style>