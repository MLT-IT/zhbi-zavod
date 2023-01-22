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

        {'pdoResources' | snippet : [
          'resources'=> '80859,80860,80861,80862,80863,80864,80865,80866',
          'tpl' => '@FILE chunks/app-item.tpl',
          'limit' => '0',
          'parents' => '0',
          'tplWrapper' => '@INLINE <div class="sect-application">[[+output]]</div>',
          'includeTVs' => 'mainImage'
        ]}
    </div>

{/block}
