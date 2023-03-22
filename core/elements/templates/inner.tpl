{extends "file:layouts/default.layout.tpl"}

{block "page"}
  <main class="layout__main">

    {include "file:blocks/breadcrumbs.tpl"}

    <article class="inner section">
      <div class="inner__container">
        <h2 class="inner__title section__title">{$_modx->resource.pagetitle}</h2>
        <div class="content-block">
            {$_modx->resource.content}
        </div>
      </div>
    </article>

  </main>
{/block}
