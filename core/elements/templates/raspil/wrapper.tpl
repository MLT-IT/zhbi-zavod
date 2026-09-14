{extends "file:layouts/default.layout.tpl"}

{block "page"}
  <main class="layout__main">
    {include "file:chunks/breadcrumbs/breadcrumbs.tpl"}
    <div class="raspil__container">
      <h1 class="margin-bottom-md section__title">{$_modx->resource.pagetitle}</h1>
      {include "file:sections/advantages_v2/wrapper.tpl" styleClass='raspil__advantages'}
      {include "file:sections/raspil-delivery/wrapper.tpl" styleClass='raspil__delivery'}
      {include "file:blocks/tag-row/wrapper.tpl" styleClass='raspil__tag-row' containerClass='raspil__container'}
      {insert "file:modules/contacts-block/wrapper.tpl"}
    </div>
  </main>
{/block}