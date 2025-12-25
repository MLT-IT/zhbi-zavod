<div class="header__main bg-light-gray-2">
  <div class="container">
    <div class="d-flex">
      <div class="header__main-logo mr-32">
        <a href="/"><img src="{$_modx->getPlaceholder('images.logo-default')}" /></a>
      </div>

      {if $_modx->context.key in list ['web']}
        {include 'file:modules/catalog-menu/chunks/v1/wrapper-desktop.tpl'}
      {else}
        {include 'file:modules/catalog-menu/chunks/v2/wrapper-desktop.tpl'}
      {/if}
       
      <div class="header__main-search mr-16">
        {include 'file:modules/fast-search/chunks/fast-search-form.tpl'}
      </div>

      <div>
        <div class="header__main-info d-flex gap-8 fs-14">
            <svg><use xlink:href="/assets/template/images/icons.svg#svg-calendar-sm"></use></svg>
            {$_modx->getPlaceholder('contacts.opening_hours')}
        </div>
        <div class="header__main-info">
            <a class="d-flex gap-8 fs-14 link" href="mailto:{$_modx->getPlaceholder('contacts.email')}">
                <svg><use xlink:href="/assets/template/images/icons.svg#svg-email-sm"></use></svg>
                {$_modx->getPlaceholder('contacts.email')}
            </a>
        </div>
      </div>

      <div class="header__main-controls d-flex gap-8">
        <a class="btn-icon" href="{$_modx->getPlaceholder('makeurls.favorites')}">
            <svg><use xlink:href="/assets/template/images/icons.svg#svg-heart"></use></svg> 
            {include "file:modules/store-product-selection/chunks/favorites/counters.tpl"}
        </a>
        <a class="btn-icon" href="{$_modx->getPlaceholder('makeurls.comparison')}">
            <svg><use xlink:href="/assets/template/images/icons.svg#svg-bars"></use></svg>
            {include "file:modules/store-product-selection/chunks/comparison/counters.tpl"}
        </a>
        <a class="btn-icon" href="{$_modx->getPlaceholder('makeurls.cart')}">
            <svg><use xlink:href="/assets/template/images/icons.svg#svg-basket"></use></svg>
            <span class="counter-circle" {if $_modx->getPlaceholder('counters.cart-product-count') < 1}style="display:none"{/if} data-cart-total-count data-cart-total-hide-empty="true">
              {$_modx->getPlaceholder('counters.cart-product-count')}
            </span>
        </a>
        <button class="btn btn-bordered fs-14" onclick="modals.events.open('modal-callback')">
            Заказать звонок
        </button>
      </div>
    </div>
  </div>
</div>
