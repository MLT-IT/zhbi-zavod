<div class="listing__tags swiper-container">
    <div class="swiper-wrapper">
        {set $params = [
            'parents' => $_modx->resource.id,
            'tpl' => '@FILE sections/category/listing-tags-item.tpl',
            'tplOuter' => "@INLINE {{+wrapper}}",
            'templates' => 5,
            'includeTVs' => 'mainImage',
        ]}

        {if $_modx->resource.template == 4}
            {set $params['depth'] = '0'}
        {/if}

        {'!pdoResources' | snippet : $params}
    </div>
    <div class="swiper-scrollbar"></div>
</div>
