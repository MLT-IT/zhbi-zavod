<!-- {set $user_reviews = '@FILE modules/mltreviews/snippets/mltReviewItems.php' | snippet : [ 
    'user_reviews' => 1,
    'ratingRowClass' => 'mlt-reviews__item-rating',
    'ratingItemClass' => 'mlt-reviews__item-rating-item',
    'tpl' => '@FILE modules/mltreviews/chunks/tplItemReview.tpl',
    'tplOuter' => '@FILE modules/mltreviews/chunks/tplItemOuter.tpl',
    'limit' => 3
]}
{set $all_reviews ='@FILE modules/mltreviews/snippets/mltReviewItems.php' | snippet : [ 
    'ratingRowClass' => 'mlt-reviews__item-rating',
    'ratingItemClass' => 'mlt-reviews__item-rating-item',
    'tpl' => '@FILE modules/mltreviews/chunks/tplItemReview.tpl',
    'tplOuter' => '@FILE modules/mltreviews/chunks/tplItemOuter.tpl',
    'context_key' => $_modx->context.key
]} 
-->

<div class="mlt-reviews">
  <div class="container">
    <h1 class="section-title">{$_modx->resource.pagetitle}</h1>
    <p>Отзывы компании-дилера производителя СтройМаркет.</p>
    <article class="reviews-head">
      <div class="reviews-head__info">
        <div class="reviews-head__info-logo">
          <img
            src="/assets/template/images/sections/reviews/review_yandex_map.svg"
          />
        </div>
        <div class="reviews-head__details">
          <div class="reviews-head__details-rating">4.8 из 5</div>
          <div class="reviews-head__details-stars">
            <span class="reviews-head__details-stars-item"></span>
            <span class="reviews-head__details-stars-item"></span>
            <span class="reviews-head__details-stars-item"></span>
            <span class="reviews-head__details-stars-item"></span>
            <span class="reviews-head__details-stars-item"></span>
          </div>
          <div class="reviews-head__details-text">На основе 119 оценок</div>
        </div>
      </div>
      <div class="reviews-head__action">
        <button class="btn btn-primary" onclick="modals.events.open('modal-review')">Оставить отзыв</button>
      </div>
    </article>

    {if $user_reviews}
    <div class="mlt-reviews__user-reviews">
      <h2 class="mlt-reviews__title small-title section-title">На модерации</h2>
      {$user_reviews}
    </div>
    {/if} {if $all_reviews}
    <div
      class="mlt-reviews__all-reviews"
      data-opened-element="show-more-reviews"
    >
      <h2 class="mlt-reviews__title section-title">Отзывы о нашей работе</h2>
      {$all_reviews}
    </div>
    {if $_modx->getPlaceholder('review-show-more')}
    <button
      class="btn btn-bordered m-auto d-block"
      data-opened-btn="show-more-reviews"
      data-active-text="Скрыть"
    >
      Показать все
    </button>
    {/if} {else} Здесь пока нет отзывов. {/if}
  </div>
</div>

{include "file:modules/modals/chunks/modal-review.tpl"}