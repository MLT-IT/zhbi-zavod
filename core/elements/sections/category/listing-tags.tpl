{set $params = [
    'parents' => $_modx->resource.id,
    'tpl' => '@FILE sections/category/listing-tags-item.tpl',
    'tplWrapper' => "@FILE sections/category/listing-tags-wrapper.tpl",
    'templates' => 5,
    'includeTVs' => 'mainImage',
]}

{if $_modx->resource.template == 4}
    {set $params['depth'] = '0'}
{/if}

{'!pdoResources' | snippet : $params}
