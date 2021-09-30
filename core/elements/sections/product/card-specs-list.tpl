<div class="product-card__specs-list">
    {foreach $options as $option}
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
    {/foreach}
</div>
