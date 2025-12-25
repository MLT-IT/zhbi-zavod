{extends "file:layouts/base.tpl"} 

{block 'page-content'}
    {include "file:sections/breadcrumbs/wrapper.tpl"}
    {include "file:sections/main-category/wrapper.tpl"}
    {include "file:sections/delivery-material/wrapper.tpl"}
    {include "file:sections/payments/wrapper.tpl"}
    {include "file:sections/address-map/wrapper.tpl"}
{/block}