{set $product_id = $id}
{set $data = "@FILE modules/warehouses/snippets/remains.php" | snippet : ['id' => $product_id]}
{set $unit = "уп."}

<div class="product-card base-box-shadow" data-product_idx="{$idx}">
  <div class="product-card__content">
    <div class="product-card__top">
      {include "file:modules/store-product-selection/chunks/favorites/btn.tpl"}
      {include "file:modules/store-product-selection/chunks/comparison/btn.tpl"}
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
