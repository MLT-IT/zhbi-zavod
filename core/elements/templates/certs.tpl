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
    <div class="wrapper sect-inner">
        <h1 class="title-1">{$_modx->resource.pagetitle}</h1>

        {if $_modx->resource.content | length > 0}
            <article class="sect-inner__content content-block">
                {$_modx->resource.content}
            </article>
        {/if}

        {set $certs = 'getAllCerts' | snippet}
        {include 'file:blocks/certs.tpl'}

    </div>
{/block}
