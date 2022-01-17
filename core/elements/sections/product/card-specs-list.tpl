<div class="product-card__specs-list">
    {foreach $options as $option}
        {if $option.key not in list ['edizm', 'edizm2', 'upakovka', 'price2']}
            <div class="product-card__specs-list-item">
                <div class="product-card__specs-list-item-name">{$option.caption}:</div>
                <div class="product-card__specs-list-item-value">
                    {if $option.value is array}
                        {$option.value | join : ', '}
                    {else}
                        {$option.value}
                    {/if}
                </div>
            </div>
        {/if}
    {/foreach}

    {if $modx->resource.made_in?}
        a1
        <div class="product-card__specs-list-item">
            <div class="product-card__specs-list-item-name">Страна:</div>
            <div class="product-card__specs-list-item-value">
                {$modx->resource.made_in}
            </div>
        </div>
    {/if}

    {$_pls['vendor.name']}
    {if $modx->resource.vendor.name?}
        b1
        <div class="product-card__specs-list-item">
            <div class="product-card__specs-list-item-name">Производитель:</div>
            <div class="product-card__specs-list-item-value">
                {$modx->resource.vendor.name}
            </div>
        </div>
    {/if}

</div>
