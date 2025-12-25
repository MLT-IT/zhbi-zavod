{set $similar = $_modx->getPlaceholder("similar")}

{if $similar['products']}
<div class="product-page__inform-section d-grid gap-5">
  {$similar['data']['title']}
  <div class="similar-products-grid">
    {foreach $similar['products'] as $similar_product}
      {if $_modx->resource['standart'][0] == $similar_product['value']}
        <a class="similar-products-grid__item active">
          {$similar_product['value']} {$similar['data']['unit']}
        </a>
        {set $similar_product_active = true}
      {/if}
    {/foreach}

    {if !$similar_product_active}
      <a class="similar-products-grid__item active">
        {$_modx->resource['standart'][0]}
      </a>
    {/if}

    {foreach $similar['products'] as $similar_product}
      {if $_modx->resource['standart'][0] != $similar_product['value']}
        <a class="similar-products-grid__item" href="{$similar_product['uri']}">
          {$similar_product['value']} {$similar['data']['unit']}
        </a>
      {/if}
    {/foreach}
  </div>
</div>
{/if}