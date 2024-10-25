{extends "file:layouts/default.layout.tpl"}

{block "page"}
<main class="layout__main">
    {include "file:chunks/breadcrumbs/breadcrumbs.tpl"}

    <article class="inner section">
      <div class="inner__container">
        <h1 class="margin-bottom-md section__title">{$_modx->resource.pagetitle}</h1>
        {$_modx->resource.content}
      </div>
    </article>

  </main>

{/block}
