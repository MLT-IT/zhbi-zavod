<header class="header-mobile bg-light-gray-2">
  <div class="container">
    <div class="header-mobile__row">
      <div class="header-mobile__logo">
        <a href="/"><img src="{$_modx->getPlaceholder('images.logo-default')}" /></a>
      </div>
      {set $phone = $_modx->getPlaceholder('contacts.phone')}
      {if $phone && $phone != '+7 (000) 000-00-00'}
      <div class="header-mobile__center">
        <a class="d-flex gap-8 fw-700" href="tel:{$_modx->getPlaceholder('contacts.phone_href')}">
            <svg><use xlink:href="/assets/template/images/icons.svg#svg-phone-sm"></use></svg>
            {$_modx->getPlaceholder('contacts.phone')}
        </a>
      </div>
      {/if}
      <button class="btn btn-primary header-mobile__menu-btn" onclick="body.classList.toggle('overflow-hidden')" data-opened-btn="header-mobile-modal">
        <svg class="icon-btn__icon" aria-hidden="true"><use xlink:href="/assets/template/images/icons.svg#svg-burger"></use></svg>
        <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="none"><path d="M14 1.41 12.59 0 7 5.59 1.41 0 0 1.41 5.59 7 0 12.59 1.41 14 7 8.41 12.59 14 14 12.59 8.41 7l2.795-2.795L14 1.41Z" fill="#fff"/></svg>
      </button> 
    </div>
  </div>
</header>

<div class="header-mobile__modal" data-opened-element="header-mobile-modal">
  {if $_modx->context.key in list ['web']}
    {include "file:sections/header/mobile/section-modal.tpl"}
  {else}
    {$_modx->runSnippet("@FILE modules/menu/uteplitel/snippets/getMobileMenu.php", [
      "context" => $_modx->resource.context_key
    ])}
  {/if}
</div>