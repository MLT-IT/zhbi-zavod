{set $reviews = '@FILE snippets/getReviews.php' | snippet | fromJSON}

<div class="product-card__content">
    {* Основные переменные для чанка *}
    {set $src = $_modx->resource}
    {insert "file:blocks/set-values-for-prod.tpl"}

    {* Бренд / Производитель *}
    {set $itemVendor = $_modx->resource['brand'][0]}
    {if $itemVendor is empty}
        {set $itemVendor = $_modx->resource['proizvoditel'][0]}
    {/if}

    {* Данные для добавления / изменения товара в корзине *}
    {set $prodId = $_modx->resource['id']}
    {if $_pls['isFractional'] == 1 OR $_modx->resource.isFractional == 1}
        {set $extraClass = ' custom-counter_type_fractional'}
        {set $dataMin = '0.01'}
    {else}
        {set $extraClass = ''}
        {set $dataMin = '1'}
    {/if}

    {* Галерея *}
    {'!msGallery' | snippet : [
        'tpl' => '@FILE chunks/gallery.tpl',
        'product' => $id,
        'toPlaceholder' => 'gallery'
    ]}
    {set $gallery = $_modx->getPlaceholder('gallery')}

    {if $_modx->resource.template in list [17, 20, 22]}
        {* Кровля *}
        {include "file:sections/product/card-info-relinking-selects.tpl"}
    {elseif $_modx->resource.template == 21}
        {* Фанера *}
        {include "file:sections/product/card-info-relinking-btns.tpl"}
    {else}
        {* Обычная карточка *}
        {include "file:sections/product/card-info.tpl"}
    {/if}

    {if $_modx->resource.introtext?}
        <div class="product-card__about">
            {$_modx->resource.introtext}
        </div>
    {/if}

    {include "file:sections/product/card-tabs.tpl"}
</div>
