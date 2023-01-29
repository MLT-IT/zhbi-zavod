<div class="product-card__specs-list">

    {* Установка дополнительных опций. Они берутся из основных и выводятся в самом начале - все вместе *}
    {set $extraOptions = []}
    {* Дополнительные опции для поликарбоната *}
    {if $_modx->resource.context_key == 'policarbonat'}
        {foreach ["razmer-mm", "item_length", "item_width", "item_thickness"] as $key}
            {set $extraOptions.$key = $options.$key}
            {unset $options.$key}
        {/foreach}
    {/if}

    {* Вывод опций *}
    {foreach [$extraOptions, $options] as $opts}
        {foreach $opts as $option}
            {if ($option.key == 'razmer-mm') && ($_modx->resource.context_key == 'pro-fanera') && ($_modx->resource.template == 21)}
                {set $option.caption = 'Формат'}
            {/if}

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
        {/foreach}
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
