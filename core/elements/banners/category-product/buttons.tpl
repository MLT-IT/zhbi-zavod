{* @param $banners - Баннеры *}
{* @param $button_classname - Классы кнопок *}
{* @param $button_hidden - Скрыты ли кнопки *}
{* @param $banner_submit_goal - цель метрики при успешной отправке формы *}

{if !$button_hidden}
<a class="product-banner__btn-desktop btn btn-primary justify-center {$button_classname ?: 'btn_style_base'}"
  {if $banner_submit_goal}data-banner-listing-form-goal="{$banner_submit_goal}"{/if}
  onclick="modals.events.open('modal-callback')">
  {$banners['desktop']['data']['button-text'] ?: "заказать"}
</a>
{/if}
{if !$button_hidden}
<a class="product-banner__btn-tablet btn btn-primary justify-center {$button_classname ?: 'btn_style_base'}"
  {if $banner_submit_goal}data-banner-listing-form-goal="{$banner_submit_goal}"{/if}
  onclick="modals.events.open('modal-callback')">
  {$banners['tablet']['data']['button-text'] ?: "заказать"}
</a>
{/if}
{if !$button_hidden}
<a class="product-banner__btn-mobile btn btn-primary justify-center {$button_classname ?: 'btn_style_base'}"
  {if $banner_submit_goal}data-banner-listing-form-goal="{$banner_submit_goal}"{/if}
  onclick="modals.events.open('modal-callback')">
  {$banners['mobile']['data']['button-text'] ?: "заказать"}
</a>
{/if}
