{if !empty($value)}
<div class="product-card__chars-line">
   <span class="product-card__chars-span">
   {$name}
   </span>
    <span class="product-card__chars-val">
      {if $value is array}
            {$value | join : ', '}
      {else}
            {$value}
      {/if}
   </span>
</div>
{/if}
