{if $_modx->resource.longtitle}
    {set $title = $_modx->resource.longtitle}
{else}
    {set $parent_tpl = $_modx->resource.parent | resource : 'meta_title_tpl'}
    {if $parent_tpl}
        {set $title = $parent_tpl}
    {else}
        {set $title = $_modx->resource.pagetitle}
    {/if}
{/if}

<title>{$title}</title>