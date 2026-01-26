{set $product_front_id = "product_front_id_"~$product.id}
{set $is_calc_cart = $product['is_calc_cart']}

<div class="product-card-v3 base-box-shadow {if $is_calc_cart}show-cart-calc{/if}" id="{$product_front_id}">
  <div class="product-card-v3__image">
    {if $product['thumb']?}
      <img src="{$product['thumb']}" loading="lazy"/>
    {/if}
  </div>
  <div class="product-card-v3__content">
    <a class="product-card-v3__content-title fs-20" href="{$product['uri']}">{$product['menutitle']}</a>
    <div class="product-card-v3__content-row">
      <div class="product-card-v3__content-left">
        <div class="product-card-v3__content-price">
          <span class="fs-20 fw-700">{$product['price']} ₽</span>
          {if $product['old_price']}<div class="fs-20 fw-700 color-gray old-price">{$product['old_price']} ₽</div>{/if}
          <div class="color-gray mt-8">Стоимость за 1 {$product['unit']}</div>
        </div>
        <div class="product-card-v3__content-cart">
          {if $is_calc_cart}
            {include "file:modules/cart/frontend/chunks/cart-calc.tpl" product=$product}
          {else}
            {include "file:modules/cart/frontend/chunks/cart-controls-default.tpl" 
              id=$product['id'] 
              product_count=$product['count']
              price=$product['price']
              old_price=$product['old_price']
              unit=$product['unit']
            }
          {/if}
        </div>
      </div>
      {if !$is_calc_cart}
      <div class="fs-30">
        Итого: <span class="fw-700" data-cart-product-summ="{$product['id']}">{$product['summ']}</span> ₽
      </div>
      {/if}
    </div>
  </div>
  <div class="product-card-v3__controls">
    <button class="btn btn-primary" onclick="{$product_front_id}.remove();cart.events.remove({$product.id});">
      <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="none"><path d="M14 1.41 12.59 0 7 5.59 1.41 0 0 1.41 5.59 7 0 12.59 1.41 14 7 8.41 12.59 14 14 12.59 8.41 7l2.795-2.795L14 1.41Z" fill="#fff"></path></svg>
    </button>
    {include "file:modules/store-product-selection/chunks/favorites/btn.tpl" product_id=$product['id']}
  </div>
</div>