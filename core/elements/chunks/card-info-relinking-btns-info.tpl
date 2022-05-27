<div class="product-card__info-block">
    <div class="product-card__info-block-elem">
        <div class="product-card__info-elem">
            <div class="product-card__side-panel-text">Цена за лист</div>
        </div>
        <div class="product-card__info-val product-card__info-val_content_price">
            <div class="product-card__info-price js-product__price-wrap">
                <span class="product-card__price-val">
                    {if $_modx->resource.context_key === 'plity-mdvp'}
                        {($defaultPrice / $coeff) | ceil | preg_replace : '/\B(?=(\d{3})+(?!\d))/': ' ' | replace : ',' : '.'}
                    {else}
                        {$outputPrice}
                    {/if}
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


    <div class="product-card__info-block-elem">
        <div class="product-card__info-elem">
            <div class="product-card__side-panel-text">Цена за м<sup>2</sup></div>
        </div>
        <div class="product-card__info-val product-card__info-val_content_price">
            <div class="product-card__info-price js-product__price-wrap">
                <span class="product-card__price-val">
                    {if $_modx->resource.context_key === 'plity-mdvp'}
                        {$outputPrice}
                    {else}
                        {($defaultPrice / $coeff) | ceil | preg_replace : '/\B(?=(\d{3})+(?!\d))/': ' ' | replace : ',' : '.'}
                    {/if}
                </span>
                <span class="product-card__price-unit">руб</span>
            </div>
        </div>
    </div>

    <div class="product-card__info-block-elem">
        <div class="product-card__info-elem">
            <div class="product-card__side-panel-text">Общая сумма</div>
        </div>
        <div class="product-card__info-val product-card__info-val_content_price">
            <div class="product-card__info-price js-product__price-wrap">
                <span class="product-card__price-val product-card__price-val_type_total">
                    {$outputPrice}
                </span>
                <span class="product-card__price-unit">руб</span>
            </div>
        </div>
    </div>

</div>
