{set $otzyvyPageId = '@FILE snippets/getIdByAlias.php' | snippet : ['alias' => 'otzyvy']}
<div class="mlt-reviews prod-review">
  <div class="prod-review__head">
    <div>
      <a class="link" href="{$_modx->makeUrl($otzyvyPageId) ?: '#'}">Посмотреть все отзывы</a>
    </div>
    <button class="mlt-reviews__open-form btn btn_style_base" data-fancybox data-src="#mlt-reviews-form">Оставить отзыв</button>
  </div>
  {set $startCount = 5}
  {set $limit = 20}
  {set $user_reviews = '@FILE modules/mltreviews/snippets/mltReviewItems.php' | snippet : [ 
    'user_reviews' => 1,
    'ratingRowClass' => 'mlt-reviews__item-rating',
    'ratingItemClass' => 'mlt-reviews__item-rating-item',
    'tpl' => 'tplItemReview',
    'tplOuter' => 'tplItemOuter',
    'limit' => 3,
  ]}
  {if $user_reviews}
      <h2 class="mlt-reviews__title small-title section__title">На модерации</h2>
      {$user_reviews}
  {/if}
  {set $reviews ='@FILE modules/mltreviews/snippets/mltReviewItems.php' | snippet : [ 
    'resource_id' => $_modx->resource.id,
    'ratingRowClass' => 'mlt-reviews__item-rating',
    'ratingItemClass' => 'mlt-reviews__item-rating-item',
    'tpl' => 'tplItemReview',
    'tplOuter' => 'tplItemOuter',
    'limit' => $limit,
    'context_key' => $_modx->context.key
    'startCount' => $startCount
  ]}
  {if !$reviews}
    {set $reviews ='@FILE modules/mltreviews/snippets/mltReviewItems.php' | snippet : [ 
    'ratingRowClass' => 'mlt-reviews__item-rating',
    'ratingItemClass' => 'mlt-reviews__item-rating-item',
    'tpl' => 'tplItemReview',
    'tplOuter' => 'tplItemOuter',
    'limit' => $limit,
    'context_key' => $_modx->context.key
    'startCount' => $startCount
  ]}
  {/if}

  {if $reviews}
      {$reviews}
  {else}
      Здесь пока нет отзывов
  {/if}

</div>
<div class="popup" id="mlt-reviews-form">
      
  <div class="mlt-reviews__title">Оставить отзыв</div>
  {'!mltReviewForm' | snippet : [
      'tpl' => 'tplForm'
  ]}
</div>
