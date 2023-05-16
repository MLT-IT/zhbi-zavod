{extends "file:layouts/default.layout.tpl"}

{block 'title'}
    {include "file:chunks/meta/product/meta-title.tpl"}
{/block}
{block 'description'}
    {include "file:chunks/meta/product/meta-description.tpl"}
{/block}

{block "page"}
  <main class="layout__main">
    {include "file:chunks/breadcrumbs/breadcrumbs.tpl"}

    <article class="inner section">
      <div class="inner__container">
        <h1 class="margin-bottom-md section__title">{$_modx->resource.pagetitle}</h1>
        {if $_modx->resource.content | length > 0}
          <article class="content">
              {$_modx->resource.content}
          </article>
        {/if}

        {set $certs = 'getAllCerts' | snippet}
        {include 'file:chunks/certs.tpl'}
      </div>
    </article>

  </main>
{/block}
