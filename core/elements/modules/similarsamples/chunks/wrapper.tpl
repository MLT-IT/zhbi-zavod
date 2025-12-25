<div class="similar-samples section-margin">
    <div class="container">
        <h2 class="section-title">Вам могут понадобиться</h2>

        <div class="similar-samples__tabs">
            {set $index = 0}
            {foreach $data['rules'] as $rule}
                {set $index = $index + 1}
                <div class="similar-samples__tabs-item {if $index == 1}active{/if}" data-opened-btn="similar-{$index}" data-toggle-not="true" data-close-early="similar">{$rule['name']}</div>
            {/foreach}
        </div>
        
        <div class="similar-samples__products">
            {set $index = 0}
            {foreach $data['data'] as $value}
                {set $index = $index + 1}
                <div class="swiper similar-samples__products-slider {if $index == 1}opened{/if}" data-slider="default-product-slider" data-opened-element="similar-{$index}">
                    <div class="swiper-wrapper">
                        {'!msProducts' | snippet : [
                          'parents' => $value['parents'] | join,
                          'resources' => $value['products'] | join,
                          'tpl' => '@FILE modules/product-cards/chunks/v2/wrapper.tpl',
                          'tplWrapper' => '@INLINE {$output}',
                          'includeThumbs' => 'webp',
                        ]}
                    </div>

                    <div class="swiper-button-prev base-box-shadow"></div>
                    <div class="swiper-button-next base-box-shadow"></div>
                </div>
            {/foreach}
        </div>
    </div>
</div>