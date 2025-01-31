{switch $_modx->resource.context_key}
  {case 'gbi-zavod78'}
    {insert "file:_modules/product-card/zbi500/product-card.tpl"}
  {default}
    {insert "file:_modules/product-card/product-card-default.tpl"}
{/switch}
