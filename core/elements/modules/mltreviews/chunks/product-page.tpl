<div class="mlt-reviews prod-review">
  <div class="prod-review__head">
    <div>
      <a class="btn btn-bordered" href="{$_modx->makeUrl('reviews_id'|config)}" target="_blank">Посмотреть все отзывы</a>
    </div>
    <button class="mlt-reviews__open-form btn btn_style_base" data-fancybox data-src="#mlt-reviews-form">Оставить отзыв</button>
  </div>
  {set $startCount = 5}
  {set $limit = 5}
  {set $user_reviews = '@FILE modules/mltreviews/snippets/mltReviewItems.php' | snippet : [ 
    'user_reviews' => 1,
    'ratingRowClass' => 'mlt-reviews__item-rating',
    'ratingItemClass' => 'mlt-reviews__item-rating-item',
    'tpl' => '@FILE modules/mltreviews/chunks/tplItemReview.tpl',
    'tplOuter' => '@FILE modules/mltreviews/chunks/tplItemOuter.tpl',
    'limit' => 3,
  ]}
  {if $user_reviews}
      <h2 class="mlt-reviews__title small-title">На модерации</h2>
      {$user_reviews}
  {/if}
  {set $reviews ='@FILE modules/mltreviews/snippets/mltReviewItems.php' | snippet : [ 
    'resource_id' => $_modx->resource.id,
    'ratingRowClass' => 'mlt-reviews__item-rating',
    'ratingItemClass' => 'mlt-reviews__item-rating-item',
    'tpl' => '@FILE modules/mltreviews/chunks/tplItemReview.tpl',
    'tplOuter' => '@FILE modules/mltreviews/chunks/tplItemOuter.tpl',
    'limit' => $limit,
    'startCount' => $startCount
  ]}
  {if !$reviews}
    {set $reviews ='@FILE modules/mltreviews/snippets/mltReviewItems.php' | snippet : [
    'ratingRowClass' => 'mlt-reviews__item-rating',
    'ratingItemClass' => 'mlt-reviews__item-rating-item',
    'tpl' => '@FILE modules/mltreviews/chunks/tplItemReview.tpl',
    'tplOuter' => '@FILE modules/mltreviews/chunks/tplItemOuter.tpl',
    'limit' => $limit,
    'startCount' => $startCount
  ]}
  {/if}

  {if $reviews}
      {$reviews}
  {else}
      Здесь пока нет отзывов
  {/if}

</div>

{include "file:modules/modals/chunks/modal-review.tpl"}