{include "file:modules/product-cards/chunks/v1/wrapper.tpl"}

{if ($idx == 1 && $_modx->getPlaceholder('total') == 1) || ($idx == 2 && $_modx->getPlaceholder('total') >= 2)}
    {include "file:banners/category-product/wrapper.tpl"}

    {* Для мобилы *}
    {* Переменная используется для определения индекса следующего товара в _src\js\modules\opened-options.js *}
    {* Так как товары отображаются в 2 колонки, то нужно определить индекс следующего товара в колонке *}
    {* А рекламный баннер сбивал данную логику *}
    <script>
        window.idx_increment = {$idx};
    </script>
{/if}