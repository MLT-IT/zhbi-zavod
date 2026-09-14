{extends "file:layouts/default.layout.tpl"}

{block "page"}
  {* {include "file:chunks/svg-gradient.tpl" w=48 h=48} *}

  <main class="layout__main">
    {include "file:chunks/breadcrumbs/breadcrumbs.tpl"}

    <article class="inner section">
      <div class="inner__container">
        <h2 class="margin-bottom-md section__title">{$_modx->resource.pagetitle}</h2>
        <div class="content">
            {$_modx->resource.content}
        </div>
      </div>
    </article>

    {include 'file:sections/about/sect-about-all.tpl'}

  </main>

{/block}
