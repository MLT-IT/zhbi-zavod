{if !empty($value)}
<div class='product-card__option-item'>
    <span class='fw-700'>{$name}</span>
    <span>{$value | join : ', ' | truncate:16}</span>
</div>
{/if}