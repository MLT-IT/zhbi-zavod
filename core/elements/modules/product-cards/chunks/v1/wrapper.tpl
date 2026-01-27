{set $product_id = $id}
{set $data = "@FILE modules/warehouses/snippets/remains.php" | snippet : ['id' => $product_id]}
{set $unit = "уп."}

<div class="product-card base-box-shadow" data-product_idx="{$idx}">
  <div class="product-card__content">
    <div class="product-card__top">
      {include "file:modules/store-product-selection/chunks/favorites/btn.tpl"}
      {include "file:modules/store-product-selection/chunks/comparison/btn.tpl"}
      <a class="comparison-product__btn selection-product-btn btn-icon">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 -960 960 960" width="32" height="35" fill="#D3553C" style=" margin: 0px 1px; ">
          <path d="M480-320q75 0 127.5-52.5T660-500q0-75-52.5-127.5T480-680q-75 0-127.5 52.5T300-500q0 75 52.5 127.5T480-320Zm0-72q-45 0-76.5-31.5T372-500q0-45 31.5-76.5T480-608q45 0 76.5 31.5T588-500q0 45-31.5 76.5T480-392Zm0 192q-146 0-266-81.5T40-500q54-137 174-218.5T480-800q146 0 266 81.5T920-500q-54 137-174 218.5T480-200Zm0-300Zm0 220q113 0 207.5-59.5T832-500q-50-101-144.5-160.5T480-720q-113 0-207.5 59.5T128-500q50 101 144.5 160.5T480-280Z"/>
        </svg>
        <span class="btn-icon__tips">Товар можно посмотреть вживую в нашем шоу-руме!</span>
      </a>
    </div>

      <a class="product-card__image bg-light-gray-2" href="{$id | url}">
          {if $webp?}
            <img src="{$webp}" alt="{$pagetitle}" loading="lazy"/>
          {/if}
      </a>

    <div class="product-card__title">
      <a class="fw-700" href="{$id | url}">{$pagetitle}</a>
    </div>

  {*
  <div class="product-card__remains fw-500">
    <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="none"><rect width="12" height="12" rx="6" fill="#49BF63"/><path d="m4 5.895 1.52 1.62a.1.1 0 0 0 .152-.007L8.4 4" stroke="#fff" stroke-linecap="round"/></svg>
    В наличии {$data['total_remains']} {$unit}
  </div>
  *}

    {include "file:modules/product-cards/chunks/v1/options.tpl"}
    {include "file:modules/product-cards/chunks/common/price.tpl"}
  </div>

  {include "file:modules/cart/frontend/chunks/cart-controls-mini.tpl"}

</div>
