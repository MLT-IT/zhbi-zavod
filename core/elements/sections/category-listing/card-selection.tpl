{if $_modx->context.key in list ['web']}
    {if ($idx == 1 && $_modx->getPlaceholder('total') == 1) || ($idx == 3 && $_modx->getPlaceholder('total') >= 2)}
        {include "file:banners/category-product/wrapper.tpl"}
    {else}
        {include "file:modules/product-cards/chunks/v1/wrapper.tpl"}
    {/if}
{else}
    {include "file:modules/product-cards/chunks/v1/wrapper.tpl"}
{/if}