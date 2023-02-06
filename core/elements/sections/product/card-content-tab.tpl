{if $_modx->resource.content}
    {set $content = $_modx->resource.content}
{/if}

{set $parent_tpl = $_modx->resource.parent | resource : 'content_tpl'}
{if $parent_tpl}
    {set $content = $parent_tpl}
{/if}

{if $content}
    <article class="content-block{if $mb} product-card__content-block{/if}" itemprop="description">
        {$content}
    </article>
{/if}
