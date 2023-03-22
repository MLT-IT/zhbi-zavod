{extends "file:layouts/default.layout.tpl"}

{block 'title'}
    {include "file:elements/product/meta-title.tpl"}
{/block}
{block 'description'}
    {include "file:elements/product/meta-description.tpl"}
{/block}

{block "page"}

<main class="layout__main">
    {include "file:blocks/breadcrumbs.tpl"}

    {'!msCartCustom' | snippet : [
        'tpl' => '@FILE: sections/cart.tpl',
        'includeTVs' => 'isFractional'
    ]}
</main>
{/block}
