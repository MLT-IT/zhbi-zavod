{extends "file:layouts/default.layout.tpl"}

{block "page"}
  <main class="layout__main">
    {include "file:chunks/breadcrumbs/breadcrumbs.tpl"}

    <article class="inner section">
      <div class="inner__container">
        <h1 class="margin-bottom-md section__title">{$_modx->resource.pagetitle}</h1>
        {$_modx->resource.description}
        <div class="content">
            {$_modx->resource.content}
            {include 'file:modules/mltreviews/chunks/reviews-page.tpl'}
        </div>
      </div>
    </article>

  </main>
{/block}
