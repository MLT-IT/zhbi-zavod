
{set $wizardOptions = $_modx->runSnippet("getCharacterCardProduct", [
    "context" => $_modx->resource.context_key,
    "category" => $_modx->resource.id,
    "product" => $id,
    "tplWrapper" => "@FILE modules/product-cards/chunks/wizard/wrapper.tpl",
    "tpl" => "@FILE modules/product-cards/chunks/wizard/option.tpl",
])}

<div class="product-card__options-show" onclick="showOptions({$idx})">Показать информацию</div>

{$wizardOptions}

{if empty($wizardOptions)}
    {set $options = "@FILE snippets/getOptions.php" | snippet}

    <div class="product-card__options">
        {foreach $options as $option}
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

