{foreach $options as $option}
    {* Если необходимо не выводить некоторые опции, то подойдет этот if *}
    {* if $option.key not in list ['edizm', 'edizm2', 'upakovka', 'price2'] *}
    <div class="product-card__chars-line" data-title="{$option.caption}">
        <span class="product-card__chars-span" >{$option.caption}</span>
         <span class="product-card__chars-val">
            {if $option.value is array}
                {$option.value | join : ', '}
            {else}
                {$option.value}
            {/if}
        </span>
    </div>
    {* /if *}
{/foreach}

