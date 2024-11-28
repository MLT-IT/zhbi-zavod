{extends "file:layouts/default.layout.tpl"}

{block "page"}
    {* {include "file:chunks/svg-gradient.tpl" w=48 h=48} *}

    <main class="layout__main">
        {include "file:chunks/breadcrumbs/breadcrumbs.tpl"}

        <article class="inner section">
            <div class="inner__container">
                <h2 class="margin-bottom-md section__title">{$_modx->resource.pagetitle}</h2>
                {include "file:_modules/calculator-opt/chunks/calculator-opt.tpl"}
            </div>
        </article>

        {include 'file:sections/about/sect-about-all.tpl'}

    </main>

{/block}
