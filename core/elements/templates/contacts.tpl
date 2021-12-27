{extends "file:layouts/default.layout.tpl"}

{block "page"}
    <div class="wrapper">
{include "file:blocks/breadcrumbs.tpl"}
</div>
    {insert "file:sections/contacts/contacts.tpl"}
    {* {include "file:sections/contacts/requisites.tpl"} *}

    {if $_modx->resource.content | length > 0}
        <div class="wrapper">
            <article class="content-block">
                {$_modx->resource.content}
            </article>
        </div>
    {/if}

    {include "file:sections/certs.tpl"}
    {include "file:sections/districts-map.tpl"}
    {include "file:sections/faq.tpl"}
    {include "file:sections/steps.tpl"}
    {include "file:sections/partners.tpl"}
{/block}
