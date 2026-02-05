{set $similar = $_modx->getPlaceholder("similar")}

{if $similar && $similar['data']['colored-tiles'] && $similar['products']}
<div class="colored-tiles">
    <div class="colored-tiles__title">Цветовая палитра:</div>
    
    <div class="colored-tiles__row">
        {foreach $similar['products'] as $similar_product}
            <a class="colored-tiles__item" href="{$similar_product['uri']}" data-fetch-image-product="{$similar_product['id']}" data-color="{$similar_product['value']}">{$similar_product['value']}</a>
        {/foreach}
    </div>
</div>
{/if}

