{set $productImage = $_modx->resource['image']}
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Product",
  "name": "{$_modx->resource.pagetitle}",
  "sku": "{$_modx->resource['article']?:$_modx->resource.id}",
  {if $productImage}
  "image": "https://{$_modx->config.http_host}{$productImage}",
  {/if}
  {if $_modx->resource.description}
  "description": "{$_modx->resource.description}",
  {/if}
  "offers": {
    "@type": "Offer",
    "url": "{$_modx->makeUrl($_modx->resource.id, '', '', 'full')}",
    "priceCurrency": "RUB",
    "price": "{$_modx->resource['price']}",
    "availability": "https://schema.org/InStock"
  }
}
</script>
