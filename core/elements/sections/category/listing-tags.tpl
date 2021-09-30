<div class="listing__tags swiper-container">
    <div class="swiper-wrapper">
        {'!pdoResources' | snippet : [
            'parents' => $_modx->resource.id,
            'tpl' => '@FILE sections/category/listing-tags-item.tpl',
            'tplOuter' => "@INLINE {{+wrapper}}",
            'templates' => 5,
            'includeTVs' => 'mainImage',
        ]}
    </div>
    <div class="swiper-scrollbar"></div>
</div>
