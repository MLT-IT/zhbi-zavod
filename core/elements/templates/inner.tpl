{extends "file:layouts/default.layout.tpl"}

{block 'title'}
    {include "file:elements/product/meta-title.tpl"}
{/block}
{block 'description'}
    {include "file:elements/product/meta-description.tpl"}
{/block}

{block "page"}
    <div class="wrapper">
        {include "file:blocks/breadcrumbs.tpl"}
    </div>

    {set $content = $_modx->getPlaceholder('content')}
    {if $content | length === 0}
        {set $content = $_modx->resource.content}
    {/if}

    <div class="wrapper sect-inner">
        <h1 class="title-1">{$_modx->resource.pagetitle}</h1>
        {if $content | length > 0}
          <article class="sect-inner__content{if !$_modx->resource.htmlInsideContent} content-block{/if}">
              {$content}
          </article>
        {/if}
    </div>

{/block}
