{extends "file:layouts/base.tpl"}

{block "page-content"}
<main class="layout__main">
    {include "file:sections/breadcrumbs/wrapper.tpl"}

    <div class="warehouse-page">
        <div class="container">
            {include "file:modules/warehouses/template/contacts.tpl"}
            {include "file:modules/warehouses/template/items.tpl"}
        </div>
    </div>

</main>

{/block}
