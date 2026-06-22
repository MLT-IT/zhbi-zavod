
{set $image = $image ?: 'side-banner-1.jpg'}
{set $bgPath = "/assets/template/banners/{$_modx->resource.context_key}/{$image}"}
<div class="side-banner block-bg">
  <div class="advertisement_note">Реклама</div>
  <div class="side-banner__background">
    <img src="{$bgPath}" alt="">
  </div>
  <div class="side-banner__wrapper">
    <div class="side-banner__title">{$title}</div>
    <div class="side-banner__description"> {$text}</div>
    <div class="side-banner__action">
      <a 
        class="btn btn_style_black" 
        href="{$actionUrl ?: " #{$form?:"callback"}"}"
        {$form ? ' data-fancybox' : '' }
      >
        {$actionText?:"Отправить"}
      </a>
    </div>
  </div>
</div>
