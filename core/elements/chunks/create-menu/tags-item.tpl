{* styles combined with catalog-screen__item *}
<li class="catalog-screen__tag catalog-screen__tag_type_default">
    <a href="{$uri}" class="catalog-screen__tag-link">
        <div class="catalog-screen__tag-picture">
        {set $image = $mainImage ?: $_pls['tv.mainImage']}
        {if $image}
            <img class="catalog-screen__tag-image" src="{$image}" alt="{$menutitle}">
        {/if}
        <div class="catalog-screen__tag-background" data-val="{$menutitle}"></div>
        </div>
        <div class="catalog-screen__tag-name">{$_pls['tagName'] ?: $menutitle}</div>
    </a>
</li>
