<div class="product-card__info-block">
    {if $_modx->resource['massa'][0] > 0}
        <div class="product-card__info-block-elem">
            <div class="product-card__info-elem">
                <div class="product-card__side-panel-text">Вес</div>
            </div>
            <div class="product-card__info-val">
                <span class="product-card__weight-val">{$_modx->resource['massa'][0]}</span>
                <span class="product-card__weight-unit">кг</span>
            </div>
        </div>
    {/if}
    <div class="product-card__info-block-elem">
        <div class="product-card__info-elem">
            <div class="product-card__side-panel-text">Цена</div>
        </div>
        <div class="product-card__info-val product-card__info-val_content_price">
            <div class="product-card__info-price js-product__price-wrap">
                <span class="product-card__price-val">
                    {$outputPrice}
                </span>
                <span class="product-card__price-unit">руб</span>
            </div>
            {if $outputOldPrice?}
                <div class="product-card__new-price-wrap js-product__new-price-wrap">
                    <div class="js-product__new-price-val">
                        <span class="js-product__new-price-output product-card__new-price">
                            {$outputOldPrice}
                        </span>
                        руб
                    </div>
                    <div class="js-product__new-price-wrap listing__new-price-text js-product__new-price-text">
                        Цена действительна до {'getTomorrowDate' | snippet}
                    </div>
                </div>
            {/if}
        </div>
    </div>
</div>
