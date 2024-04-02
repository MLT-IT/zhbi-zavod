<li class="catalog-screen__item catalog-screen__item_type_default">
    <a href="{$uri}" class="catalog-screen__item-link">
        <div class="catalog-screen__item-picture">
        {set $image = $mainImage ?: $_pls['tv.mainImage']}
        {if $image}
            <img class="catalog-screen__item-image" src="{$image}" alt="{$menutitle}">
        {/if}
        <div class="catalog-screen__item-background" data-val="{$menutitle}"></div>
        </div>
        <div class="catalog-screen__item-name">{$_pls['tagName'] ?: $menutitle}</div>
    </a>
</li>
