{extends "file:layouts/default.layout.tpl"}

{block 'title'}
    {include "file:elements/product/meta-title.tpl"}
{/block}
{block 'description'}
    {include "file:elements/product/meta-description.tpl"}
{/block}

{block "page"}
    <div class="wrapper">
        {include "file:blocks/breadcrumbs.tpl"}
    </div>
    <div class="wrapper sect-inner">
        <h1 class="title-1 title-1_align_left bold">{$_modx->resource.pagetitle}</h1>

        {if $_modx->resource.content | length > 0}
            <article class="sect-inner__content content-block sect-inner__content_type_reduced">
                {$_modx->resource.content}
            </article>
        {/if}
    </div>

    <section class="wrapper sect-segment">
        <h1 class="title-2">Основной сегмент наших клиентов</h1>


        <h2 class="title-2">Видеообращение директора</h2>



    </section>


    {include "file:sections/appeal.tpl"}
{/block}
