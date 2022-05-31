{extends "file:layouts/default.layout.tpl"}

{block 'schema'}
    {include "file:blocks/catalog-schema.tpl"}
{/block}

{block "page"}
    <div class="wrapper">
        {include "file:blocks/breadcrumbs.tpl"}
    </div>
    <div class="wrapper">
        <h1 class="title-1 category-header asfs">
            {if $_modx->getPlaceholder('utm_city')['pcase'] ?}
                {set $catalogTitle = $_modx->resource.pagetitle | replace : 'Санкт-Петербурге' : ($_modx->getPlaceholder('utm_city')['pcase'])}
                {$catalogTitle}
                {if $catalogTitle === $_modx->resource.pagetitle}
                    {* Замены не произошло, следовательно, нужно добавить текст про район *}
                    в {$_modx->getPlaceholder('utm_city')['pcase']}
                {/if}
            {else}
                {$_modx->resource.pagetitle}
            {/if}

            <span class="category-header__inner-text">{'!textFromGetParams' | snippet}</span>
        </h1>
    </div>
    {include "file:sections/category/listing.tpl"}
    {include "file:sections/districts-map.tpl"}
    {if $_modx->resource.content | length > 0}
        <div class="wrapper">
            <article class="content-block">
                {$_modx->resource.content}
            </article>
        </div>
    {/if}

    {if $_modx->resource.template === 5}
        {include "file:sections/certs.tpl"}
    {/if}
    {include "file:sections/faq.tpl"}
    {include "file:sections/payment.tpl"}
    {include "file:sections/advantages.tpl"}
    {include "file:sections/steps.tpl"}
    {include "file:sections/partners.tpl"}
{/block}
