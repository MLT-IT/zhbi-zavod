{if $_modx->resource.content}
    {set $content = $_modx->resource.content}
{/if}
{set $parent_tpl = $_modx->resource.parent | resource : 'content_tpl'}
{if $parent_tpl}
    {set $content = $parent_tpl}
{else}
    {set $content = ""}
{/if}

{if $content}
    <div class="content-block">
        {$content}
    </div>
{/if}
