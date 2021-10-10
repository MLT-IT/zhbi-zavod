<li class="header__catalog-list-item">
    <a class="header__catalog-list-link" href="{$uri}">
        {$menutitle?: $pagetitle}
    </a>
    {if $wrapper}
        <ul class="header__catalog-list">{$wrapper}</ul>
    {/if}
</li>
