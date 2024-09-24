<div class="mlt-reviews prod-review">
    <a href="/otzyvy/" class="mlt-reviews__link">Посмотреть все отзывы</a>
    {'mltReviewItems' | snippet : [ 
        'ratingRowClass' => 'mlt-reviews__item-body-rating',
        'ratingItemClass' => 'mlt-reviews__item-body-rating-item',
        'tpl' => 'tplItemProductReview',
        'tplOuter' => 'tplItemProductOuter'
    ]}
    <button
    class="mlt-reviews__pagin-btn"
    data-mltr-pagin-btn
    data-show-text="Показать еще"
    data-hide-text="Скрыть"
  >
    Показать еще
  </button>
</div>


