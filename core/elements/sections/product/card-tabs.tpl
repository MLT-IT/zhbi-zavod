<div class="product-card__tabs" id="card-tabs">
    <div class="product-card__tabs-buttons" data-tabs="product-card__tabs-pages">
        <div class="product-card__tabs-button active" data-tab-page="0">Описание</div>
        <div class="product-card__tabs-button" data-tab-page="1">Характеристики</div>
        <div class="product-card__tabs-button product-card__tabs-button_type_reviews" data-tab-page="2">Отзывы
            (<span>{count($reviews)}</span>)
        </div>
        <div class="product-card__tabs-button" data-tab-page="3">Сертификаты</div>
        <div class="product-card__tabs-button" data-tab-page="4">Видео</div>
    </div>
    <div class="product-card__tabs-pages">
        <div class="product-card__tabs-page active">
            {include 'file:sections/product/card-content-tab.tpl'}
        </div>
        <div class="product-card__tabs-page content-block">
            {include 'file:sections/product/card-specs-tab.tpl'}
        </div>
        <div class="product-card__tabs-page">
            {include 'file:sections/product/card-reviews-tab.tpl'}
        </div>
        <div class="product-card__tabs-page">
            {include 'file:sections/product/card-certs-tab.tpl'}
        </div>
        <div class="product-card__tabs-page">
            {include 'file:sections/product/card-video-tab.tpl'}
        </div>
    </div>
</div>
