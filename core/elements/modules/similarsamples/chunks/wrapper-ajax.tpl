{set $rules = "@FILE modules/similarsamples/snippets/getSimilarRules.php" | snippet}

{if $rules}
<div class="similar-samples">
    <div class="container">
        <h2 class="section-title">Вам могут понадобиться</h2>

        <div class="similar-samples__tabs">
            {foreach $rules as $rule}
            <div class="similar-samples__tabs-item" data-ss-tab-item
                onclick="ssGetContent(this,{$rule['id']}, {$_modx->resource.id})">
                {$rule['name']}</div>
            {/foreach}
        </div>

        <div class="similar-samples__products">
            <div class="swiper similar-samples__products-slider opened" data-slider="default-product-slider">
                <div class="swiper-wrapper" data-ss-tab-content>
                    {include "file:modules/product-cards/chunks/common/skeleton.tpl"}
                    {include "file:modules/product-cards/chunks/common/skeleton.tpl"}
                    {include "file:modules/product-cards/chunks/common/skeleton.tpl"}
                    {include "file:modules/product-cards/chunks/common/skeleton.tpl"}
                </div>

                <div class="swiper-button-prev base-box-shadow"></div>
                <div class="swiper-button-next base-box-shadow"></div>
            </div>
        </div>
    </div>
</div>
{/if}