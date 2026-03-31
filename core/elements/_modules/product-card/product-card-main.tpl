{switch $_modx->resource.context_key}
  {case 'gbi-zavod78'}
    {insert "file:_modules/product-card/gbi-zavod78/product-card.tpl"}
  {case 'fibrofasad'}
    {insert "file:_modules/product-card/fibrofasad/product-card.tpl"}
  {case 'plitnye'}
    {insert "file:_modules/product-card/plitnye/product-card.tpl"}
  {case default}
    {insert "file:_modules/product-card/product-card-default.tpl"}
{/switch}

<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Product",
  "name": "{$_modx->resource.pagetitle | replace : '"' : '\"'}",
  {if $_modx->resource.introtext?}
  "description": "{$_modx->resource.introtext | strip_tags | replace : '"' : '\"'}",
  {/if}
  {if $_modx->resource.image?}
  "image": "{$_modx->resource.image}",
  {/if}
  "sku": "{$_modx->resource.id}",
  "url": "{$_modx->resource.id | url}",
  "offers": {
    "@type": "Offer",
    "priceCurrency": "RUB",
    "price": "{$prodValues['defaultPrice'] | replace : ' ' : ''}",
    "availability": "https://schema.org/InStock"
  }
}
</script>
