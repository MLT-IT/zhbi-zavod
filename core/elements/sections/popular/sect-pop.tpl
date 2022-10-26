{set $params = [
    'parents' => 0,
    'depth' => 50,
    'limit' => 42,
    'sortby' => '',
    'sortdir' => '',
    'tpl' => '@FILE sections/popular/pop-slide.tpl',
    'includeTVs' => 'isFractional',
    'context' => $_modx->resource.context_key,
    'tplWrapper' => '@FILE sections/popular/sect-pop-wrapper.tpl',
    'wrapIfEmpty' => 0
]}

{if '@FILE snippets/checkProductCategory.php' | snippet : ['catIds' => '37609,19851,19852,37610']}
    {set $params['parents'] = 37609}
    {set $params['resources'] = '-' ~ $_modx->resource.id}
    {'@FILE snippets/getPopularProductsKirpich.php' | snippet : ['params' => $params]}
{else}
    {if $resources is empty}
        {* Если popular_ids не заполнено, то resources будет пустой. И будут выводиться все товары подряд *}
        {set $resources = $_modx->config['popular_ids']}
    {/if}

    {set $params['resources'] = $resources}
    {'!msProducts' | snippet : $params}
{/if}
