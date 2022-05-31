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

            {* В каталоге для utm с городом нужно выводить другой h1 *}
            {if $_modx->resource.template === 4}
                {set $utm_city = '!utm' | snippet : ['val' => 'city']}

                {if $utm_city['pcase'] ?}
                    {set $catalogTitle = $_modx->resource.pagetitle | replace : 'Санкт-Петербурге' : $utm_city['pcase']}
                    {$catalogTitle | replace : 'Каталог' : 'Продажа'}
                    {if $catalogTitle === $_modx->resource.pagetitle}
                        {* Замены не произошло, следовательно, нужно добавить текст про город *}
                        в {$utm_city['pcase']}
                    {/if}
                {else}
                    {* utm_city нет, выводим как есть *}
                    {$_modx->resource.pagetitle}
                {/if}
            {else}
                {* Это не каталог, а категория (или что-то еще), выводим как есть *}
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
