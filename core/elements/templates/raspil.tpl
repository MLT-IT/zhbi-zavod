{extends "file:layouts/default.layout.tpl"}

{block "page"}
  <main class="layout__main">
    {include "file:chunks/breadcrumbs/breadcrumbs.tpl"}
    <div class="raspil__container">
      <h1 class="margin-bottom-md section__title">{$_modx->resource.pagetitle}</h1>
      {include "file:sections/advantages_v2.tpl" styleClass='raspil__advantages'}
      {*include "file:sections/delivery.tpl" styleClass='raspil__delivery'*}
    </div>

    {*
    <article class="inner section">
      <div class="inner__container">
        <h1 class="margin-bottom-md section__title">{$_modx->resource.pagetitle}</h1>

        <div class="content">
            {$_modx->resource.content}
            {if $_modx->resource.alias == 'besplatnyij-zamer'}
              {include "file:sections/zamer.tpl"}
            {/if}
        </div>
      </div>
    </article>
    *}
  </main>
{/block}