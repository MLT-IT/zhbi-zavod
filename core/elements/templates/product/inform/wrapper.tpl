{set $remains = '@FILE snippets/random.php' | snippet : [
    'id' => $_modx->resource.id,
    'begin' => 2000
    'end'=> 4000
]}

<div class="product-page__inform">
  <div class="product-page__inform-section">
    {*include "file:modules/warehouses/sections/warehouse-remains.tpl"*}

    <div class="d-flex gap-8 mb-16">
      {include "file:chunks/rating-stars.tpl" active_stars=4}
      <a class="link-dashed" href="{$_modx->makeUrl('reviews_id'|config)}">5 отзывов</a>
    </div>

    {*
        <a class="yandex-rating" href="{$_modx->makeUrl('reviews_id'|config)}" target="_blank">
          <img src="/assets/template/images/other/yandex-badge.png" alt="Yandex.Market" />
        </a>
    *}
    
    <ul class="product-page__inform-list">
      {foreach [
        'Можно посмотреть в нашем в нашем <a class="link-dashed" target="_blank" href="shourum">шоу-руме</a>'
        'В наличии металл '~$remains~' м2',
        'Срок изготовления: 2-3 дня',
        'Гарантия на товар: 30 лет'
      ] as $item}
      <li>
        <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="none"><rect width="12" height="12" rx="6" fill="#49BF63"/><path d="m4 5.895 1.52 1.62a.1.1 0 0 0 .152-.007L8.4 4" stroke="#fff" stroke-linecap="round"/></svg>
        <span>{$item}</span>
      </li>
      {/foreach}
    </ul>
  </div>

  {*include "file:modules/similar-products/chunks/similar-grid.tpl"*}

  <div class="product-page__inform-section">
    <div class="product-page__inform-price">
      {include "file:templates/product/inform/price.tpl"}
    </div>
  </div>

  {include "file:modules/cart/frontend/chunks/cart-controls-big.tpl"}

  <button
    class="product-page__inform-btn-buy btn btn-bordered"
    onclick="modals.events.open('modal-callback')"
  >
    Купить в 1 клик
  </button>
</div>
