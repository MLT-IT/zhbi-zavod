<li class="catalog-screen__item catalog-screen__item_type_default">
    <a href="{$uri}" class="catalog-screen__item-picture">
        {if $_pls['tv.mainImage']}
            <img class="catalog-screen__item-image" src="{$_pls['tv.mainImage']}" alt="{$menutitle}">
        {/if}
        <div class="catalog-screen__item-background" data-val="{$menutitle}"></div>

    </a>
    <a href="{$uri}" class="catalog-screen__item-name">{$_pls['tagName'] ?: $menutitle}</a>
</li>
