{extends "file:layouts/default.layout.tpl"}

{block "page"}
    <div class="wrapper">
{include "file:blocks/breadcrumbs.tpl"}
</div>
    {include 'faq' ispage=1}
    {include "file:sections/certs.tpl"}
    {include "file:sections/advantages.tpl"}
    {include "file:sections/partners.tpl"}
    {include "file:sections/delivery.tpl"}
{/block}
