{extends "file:layouts/default.layout.tpl"}

{block "page"}
    <div class="wrapper">
{include "file:blocks/breadcrumbs.tpl"}
</div>
    {insert "file:sections/contacts/contacts.tpl"}
{*    {include "file:sections/contacts/requisites.tpl"}*}
    <div class="wrapper">
        {* <h1 class="title-1"></h1> *}
        <div class="content-block">
            {$_modx->resource.content}
        </div>
    </div>
    {include "file:sections/partners.tpl"}
    {include "file:sections/delivery.tpl"}
{/block}
