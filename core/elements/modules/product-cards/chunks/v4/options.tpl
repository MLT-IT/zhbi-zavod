{set $options = "@FILE snippets/getOptions.php" | snippet : ["key" => "detailed"]}

<div class="product-card__options">
    {foreach $options as $option}
        {set $value = $_pls[$option['key']][0]}
        {if $value}
            <div class="product-card__option-item comparison-item" data-comparison-key="{$option['title']}" data-comparison-value="{$value}">
                <span class="fw-700">{$option['title']}</span>
                <span>{$value}</span>
            </div>
        {/if}
    {/foreach}
  </div>