{if $_modx->resource.certs}
    {set $certs = $_modx->resource.certs}
{/if}

{if $certs}
    {set $certs = json_decode($certs, true)}
    {if $certs | count > 0}
        <ul class="certs-block">
            {foreach $certs as $ct}
                <li class="certs-block__item"><a href="/assets/template/{$ct.file}">{$ct.name}</a></li>
            {/foreach}
        </ul>
    {/if}
{/if}
