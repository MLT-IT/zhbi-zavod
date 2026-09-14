{extends "file:layouts/default.layout.tpl"}

{block "page"}
  {* {include "file:chunks/svg-gradient.tpl" w=48 h=48} *}

  <main class="layout__main">
    {include "file:chunks/breadcrumbs/breadcrumbs.tpl"}

    {include 'file:sections/services/sect-services.tpl'}

  </main>

{/block}
