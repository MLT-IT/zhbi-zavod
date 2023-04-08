{extends "file:layouts/default.layout.tpl"}

{block 'title'}
    {include "file:chunks/product/meta-title.tpl"}
{/block}
{block 'description'}
    {include "file:chunks/product/meta-description.tpl"}
{/block}

{block "page"}

<main class="layout__main">
    {include "file:chunks/breadcrumbs.tpl"}

    {'!msCartCustom' | snippet : [
        'tpl' => '@FILE: sections/cart.tpl',
        'includeTVs' => 'isFractional'
    ]}
</main>
{/block}
