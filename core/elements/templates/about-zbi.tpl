{extends "file:layouts/default.layout.tpl"}

{block "page"}
 

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

    {include 'file:blocks/about-zbi/about-zbi-block.tpl'}

    <section class="about">
      <div class="about__container">


      {include 'file:sections/obraschautsa.tpl'}

      {include 'file:blocks/about-zbi/about-zbi-team.tpl'}

      {include 'file:sections/benefits.tpl'}

      {include 'file:sections/equipment-swiper.tpl'}

      </div>
    </section>

  </main>

{/block}
