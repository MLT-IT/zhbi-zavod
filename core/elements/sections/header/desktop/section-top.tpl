<div class="header__top d-flex justify-sb">
  <div class="container">
    <div class="header__top-row">
      <div class="header__descriptor">
        {$_modx->getPlaceholder('context.descriptor')}
      </div>
      <div class="header__top-menu">
        {foreach $_modx->getPlaceholder('menu_items') as $item}
            <a class="fw-700" href="{$item['uri']}">{$item['menutitle'] ?: $item['pagetitle']}</a>
        {/foreach}
      </div>
      <div class="header__top-info">
        <a class="d-flex gap-8 fs-20" href="tel:{$_modx->getPlaceholder('contacts.phone_href')}">
            <svg><use xlink:href="/assets/template/images/icons.svg#svg-phone-sm"></use></svg>
            {$_modx->getPlaceholder('contacts.phone')}
        </a>
        <button class="btn btn-link" onclick="modals.events.open('modal-callback')">Оформить заказ</button>
      </div>
    </div>
  </div>
</div>
