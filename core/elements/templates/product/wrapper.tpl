{extends "file:layouts/base.tpl"}

{block 'page-content'}

  {include "file:modules/similar-products/chunks/init.tpl"}
  {include "file:sections/breadcrumbs/wrapper.tpl" bg=true}

  <div class="product-page">    
      <div class="bg-light-gray-2 section-margin pb-16">
        <div class="container">
          <h1 class="page-title">{$_modx->resource.pagetitle}</h1>
          <div class="product-page__row">
            <div class="product-page__row-item">
              {include "file:templates/product/gallery/wrapper.tpl"}
              {include "file:modules/similar-products/chunks/colored-tiles.tpl"}
            </div>
            <div class="product-page__row-item">
              {include "file:templates/product/inform/wrapper.tpl"}
              {*include "file:blocks/gift.tpl"*}
            </div>
          </div>
        </div>

        <div class="mt-16">
          {include "file:sections/commercial-callback/wrapper.tpl"}
        </div>
      </div>

      {include "file:templates/product/tabs/wrapper.tpl"}
      {"@FILE modules/similarsamples/snippets/getSimilarProducts.php" | snippet}
      {*include "file:modules/components-for-product/chunks/wrapper.tpl"*}
      {include "file:sections/payments/wrapper.tpl"}
      {include "file:sections/address-map/wrapper.tpl" bg=true}
  </div>

{/block}
