{if !isset($title)}
  {set $title = "Акция до конца месяца"}
{/if}
{if !$button_text}
  {set $button_text = "Заказать со скидкой"}
{/if}
{if !$image_mobile}
  {set $image_mobile = "/assets/template/images/sections/promo-banners/long/{$_modx->context.key}/big-mobile.jpg"}
{/if}
{if !$image_desktop}
  {set $image_desktop = "/assets/template/images/sections/promo-banners/long/{$_modx->context.key}/big-desktop.jpg"}
{/if}

<div class="promo-banner">
  <div class="promo-banner__big promo-banner__banner">

    {if !$hide_content}
    <div class="promo-banner__content">
      {if $title}
        <div class="promo-banner__big-title promo-banner__title fs-36 fw-700">{$title}</div>
      {/if}

      <button class="btn btn-beauty promo-banner__button"
        onclick="modals.events.open('modal-callback')">{$button_text}</button>
    </div>
    {/if}
    
    <picture class="promo-banner__big-image promo-banner__image">
      <source srcset="{$image_mobile}" media="(max-width: 480px)" />
      <img src="{$image_desktop}" />
    </picture>
  </div>
</div>