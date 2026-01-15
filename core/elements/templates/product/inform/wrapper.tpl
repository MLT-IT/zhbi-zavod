{* Профлист + Металлочерепица *}
{if $_modx->resource.parent in list [89532,96257,90889,90890,92682,93709,92430,90130,96533,91430,91431,90664,93737,91693,96306,96308,92214,96311,92992,95808,91982,96081,96082,93785,93786,95069,93791,92773,90470,90471,92522,96107,96627,96374,94073,91772,96641,93570,96135,96650,91537,92305,93337,96410,96157,95140,94630,95152,91057,96178,91829,92853,94901,92854,92855,92600,96444,89533,89534,89535,92097,96453,91846,96712,96203,96463,92113,96721,96216,91866,89825,93412,93413,95463,91881,96239,93173,91645,96255,73554,74790,73555,74335,73636,74684,73983]}
  {set $remains = '@FILE snippets/random.php' | snippet : [
      'id' => $_modx->resource.id,
      'begin' => 2000
      'end'=> 4000
  ]}
  {set $items = [
    'Можно посмотреть в нашем в нашем <a class="link-dashed" target="_blank" href="shourum">шоу-руме</a>'
    'В наличии металл '~$remains~' м2',
    'Срок изготовления: 2-3 дня',
    'Гарантия на товар: 30 лет'
  ]}
{else}
  {set $remains = '@FILE snippets/random.php' | snippet : [
    'id' => $_modx->resource.id,
    'begin' => 700
    'end'=> 1000
  ]}
  {set $items = [
    'На складе '~$remains~' '~$_modx->resource.unit[0],
  ]}
{/if}


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
      {foreach $items as $item}
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
