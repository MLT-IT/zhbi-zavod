<div class="product-card__specs-list">

    {* Опции Minishop2 *}
    {foreach $options as $option}

        {if ($option.key == 'razmer-mm') && ($_modx->resource.context_key == 'pro-fanera') && ($_modx->resource.template == 21)}
            {set $option.caption = 'Формат'}
        {/if}

        {if $option.key not in list ['edizm', 'edizm2', 'upakovka', 'price2']}
            <div class="product-card__specs-list-item" data-opt-key="{$option.key}">
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

    {* Страна - свойство Minishop2 *}
    {if $_modx->resource.made_in?}
        <div class="product-card__specs-list-item">
            <div class="product-card__specs-list-item-name">Страна:</div>
            <div class="product-card__specs-list-item-value">
                {$_modx->resource.made_in}
            </div>
        </div>
    {/if}

    {* Производитель - свойство Minishop2 *}
    {if $_modx->getPlaceholder('vendor.name')?}
        <div class="product-card__specs-list-item">
            <div class="product-card__specs-list-item-name">Производитель:</div>
            <div class="product-card__specs-list-item-value">
                {$_modx->getPlaceholder('vendor.name')}
            </div>
        </div>
    {/if}

</div>
