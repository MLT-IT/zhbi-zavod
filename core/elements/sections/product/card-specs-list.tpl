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
</div>
