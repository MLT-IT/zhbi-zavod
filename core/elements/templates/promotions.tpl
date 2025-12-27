{extends "file:layouts/base.tpl"}

{block 'page-content'}
{include "file:sections/breadcrumbs/wrapper.tpl"}

<div class="section-margin">
  <div class="container">
    <h1 class="section-title">{$_modx->resource.pagetitle}</h1>

    {include "file:sections/promotions/wrapper.tpl"}
  </div>
</div>

{/block}