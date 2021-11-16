{* Сертификаты *}
{if $_modx->resource.certs}
    {set $certs = $_modx->resource.certs}

    {set $certs = json_decode($certs, true)}
    {if $certs | count > 0}
        {set $renderCerts = 1}
    {/if}
{/if}

{* Видео *}
{set $video = $_modx->resource.video}
{if $video | length > 0}
    {set $renderVideo = 1}
{/if}

<div class="product-card__tabs" id="card-tabs">
    <div class="product-card__tabs-buttons" data-tabs="product-card__tabs-pages">
        <div class="product-card__tabs-button active">Описание</div>
        <div class="product-card__tabs-button">Характеристики</div>

        {if $renderCerts == 1}
            <div class="product-card__tabs-button">Сертификаты</div>
        {/if}

        {if $renderVideo == 1}
            <div class="product-card__tabs-button">Видео</div>
        {/if}

        <div class="product-card__tabs-button product-card__tabs-button_type_reviews">Отзывы</div>
    </div>
    <div class="product-card__tabs-pages">
        <div class="product-card__tabs-page active">
            <div class="product-card__mobile-tabs-button">Описание</div>
            <div class="product-card__content-wrap">
                {include 'file:sections/product/card-content-tab.tpl'}
            </div>
        </div>
        <div class="product-card__tabs-page">
            <div class="product-card__mobile-tabs-button">Характеристики</div>
            <div class="product-card__content-wrap">
                {include 'file:sections/product/card-specs-tab.tpl'}
            </div>
        </div>

        {if $renderCerts == 1}
            <div class="product-card__tabs-page">
                <div class="product-card__mobile-tabs-button">Сертификаты</div>
                <div class="product-card__content-wrap">
                    {include 'file:sections/product/card-certs-tab.tpl' value=$certs}
                </div>
            </div>
        {/if}

        {if $renderVideo == 1}
            <div class="product-card__tabs-page">
                <div class="product-card__mobile-tabs-button">Видео</div>
                <div class="product-card__content-wrap">
                    {include 'file:sections/product/card-video-tab.tpl' value=$video}
                </div>
            </div>
        {/if}

        <div class="product-card__tabs-page">
            <div class="product-card__mobile-tabs-button">Отзывы</div>
            <div class="product-card__content-wrap">
                {include 'file:sections/product/card-reviews-tab.tpl'}
            </div>
        </div>
    </div>
</div>
