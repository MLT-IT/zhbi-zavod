{set $wizardOptions = '@FILE snippets/getCharacterCardProduct.php' | snippet : [
    "context" => $_modx->resource.context_key,
    "category" => $_modx->resource.id,
    "product" => $id,
    "tplWrapper" => "@FILE modules/product-cards/chunks/wizard/wrapper.tpl",
    "tpl" => "@FILE modules/product-cards/chunks/wizard/option.tpl",
]}

{if !$wizardOptions}
    {set $defaultOptions = "@FILE snippets/getOptions.php" | snippet}
{/if}

{if $wizardOptions || !empty($defaultOptions)}
    <div class="product-card__options-show" onclick="showOptions({$idx})">Показать информацию</div>
{/if}

{if $wizardOptions}
    {$wizardOptions}
{/if}

{if !$wizardOptions && !empty($defaultOptions)}
    <div class="product-card__options">
        {foreach $defaultOptions as $option}
            {set $value = $_pls[$option['key']][0]}
            {if $value}
                <div class="product-card__option-item">
                    <span class="fw-700">{$option['title']}</span>
                    <span>{$value}</span>
                </div>
            {/if}
        {/foreach}
    </div>
{/if}