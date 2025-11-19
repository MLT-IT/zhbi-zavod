{* @param $banners - Баннеры *}
{* @param $button_classname - Классы кнопок *}
{* @param $button_hidden - Скрыты ли кнопки *}

{if !$button_hidden}
<a class="product-banner__btn-desktop btn {$button_classname ?: 'btn_style_base'}" href="#callback" data-fancybox="">
  {$banners['desktop']['data']['button-text'] ?: "заказать"}
</a>
{/if}
{if !$button_hidden}
<a class="product-banner__btn-tablet btn {$button_classname ?: 'btn_style_base'}" href="#callback" data-fancybox="">
  {$banners['tablet']['data']['button-text'] ?: "заказать"}
</a>
{/if}
{if !$button_hidden}
<a class="product-banner__btn-mobile btn {$button_classname ?: 'btn_style_base'}" href="#callback" data-fancybox="">
  {$banners['mobile']['data']['button-text'] ?: "заказать"}
</a>
{/if}