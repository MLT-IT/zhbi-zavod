{switch $_modx->resource.context_key}
  {case 'gbi-zavod78'}
    {insert "file:_modules/product-card/gbi-zavod78/product-card.tpl"}
  {case default}
    {insert "file:_modules/product-card/product-card-default.tpl"}
{/switch}
