{extends "file:layouts/default.layout.tpl"}

{block "page"}

  {set $objectsList = '@FILE modules/objects-page/getObjectsGallery.php' | snippet}
  <main class="layout__main">
    {include "file:chunks/breadcrumbs/breadcrumbs.tpl"}
    <article class="inner section objects">
      <div class="inner__container">
        <h2 class="margin-bottom-md section__title">{$_modx->resource.pagetitle}</h2>
        <div class="content">
          {$_modx->resource.content}
        </div>
        {include 'file:modules/objects-page/chunks/objects-map.tpl'}
        
        {include 'file:modules/objects-page/chunks/objects-list.tpl'}
        </div>
      </div>
    </article>
  </main>

{/block}
