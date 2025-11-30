{if $linksData[$key]?}
<div class="product-card__select-wrap product-card__select-wrap_type_full product-tabs__section product-tabs__section_colors">
    <div class="product-card__select-span">Цвета:</div>
    <div class="colors-options custom-select_scrollable">
        {foreach $linksData[$key] as $id => $val}
            {set $visual = $_modx->runSnippet("getVisualWizard",
                [
                    "options" => "cvet,ottenok",
                    "context"=> "",
                    "name"=> $val
                ]
            )}
            {set $thumbs = '@FILE snippets/getProductGallery.php' | snippet : ['product_id' => $id, 'limit' => 1]}
            {set $thumb = ($thumbs && $thumbs[0]) ? $thumbs[0] : ''}
            {set $bgStyle = "background-color: " ~ $visual['value'] ~ ";"}
            {if $thumb}
              {set $bgStyle = $bgStyle ~ " background-image: url('" ~ $thumb ~ "');"}
            {/if}
            <a href="{$_modx->makeUrl($id, '', '', 'full')}" data-product="{$id}" data-color="{$visual['value']}" class="colors-options__item{if $_modx->resource.id == $id} active{/if}">
                {if $thumb}
                  <span class="colors-options__img" style="{$bgStyle}"></span>
                {else}
                  <span class="colors-options__img" style="{$bgStyle}"></span>
                {/if}
            </a>
        {/foreach}
    </div>
</div>
{/if}
