{if $_modx->resource.description}
    {set $description = $_modx->resource.description}
{else}
    {set $parent_tpl = $_modx->resource.parent | resource : 'meta_description_tpl'}
    {if $parent_tpl}
        {set $description = $parent_tpl}
    {else}
        {set $description = $_modx->resource.description}
    {/if}
{/if}

<meta name="description" content="{$description}">