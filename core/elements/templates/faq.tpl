{extends "file:layouts/default.layout.tpl"}

{block "page"}
    <div class="wrapper">
        {include "file:blocks/breadcrumbs.tpl"}
    </div>
    {include 'faq' ispage=1}
    {include "file:sections/payment.tpl"}
    {include "file:sections/appeal.tpl"}
    {include "file:sections/advantages.tpl"}
    {include "file:sections/partners.tpl"}
    {include "file:sections/districts-map.tpl"}
{/block}
