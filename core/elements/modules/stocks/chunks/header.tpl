{if $header.type == "stock"}
    <span class="stocks-template__tag stocks-template__tag--{$header.type}">{$header.title}</span>
    <span class="stocks-template__count">на {$header.count} складах</span>
{/if}

{if $header.type == "limit"}
    <span class="stocks-template__tag stocks-template__tag--{$header.type}">{$header.title}</span>
{/if}

{if $header.type == "not"}
    <span class="stocks-template__tag stocks-template__tag--{$header.type}">{$header.title}</span>
    <span class="stocks-template__delivery">{$header.delivery}</span>
{/if}