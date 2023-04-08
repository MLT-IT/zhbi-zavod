{extends "file:layouts/default.layout.tpl"}

{block 'title'}
    {include "file:chunks/meta/product/meta-title.tpl"}
{/block}
{block 'description'}
    {include "file:chunks/meta/product/meta-description.tpl"}
{/block}

{block "page"}

<main class="layout__main">
    {include "file:chunks/breadcrumbs/breadcrumbs.tpl"}

    {'!msCartCustom' | snippet : [
        'tpl' => '@FILE: sections/cart.tpl',
        'includeTVs' => 'isFractional'
    ]}
</main>
{/block}
