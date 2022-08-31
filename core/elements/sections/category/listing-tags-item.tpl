<a class="listing__tags-item swiper-slide" href="{$uri}">
    <div class="listing__tags-item-img">
        {if $_pls['tv.mainImage']?}
            {set $src = 'phpthumbon' | snippet : [
                'input' => $_pls['tv.mainImage'],
                'options' => '&w=100&h=69&far=1&bg=ffffff'
            ]}
        {else}
            {set $src = 'assets/images/no_image.jpg'}
        {/if}
        <img src="{$src}" alt="{$menutitle}">
    </div>
    <div class="listing__tags-item-title">{$menutitle}</div>
</a>
