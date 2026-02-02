{set $params = [ 
    'ratingRowClass' => 'mlt-reviews__item-rating',
    'ratingItemClass' => 'mlt-reviews__item-rating-item',
    'tpl' => 'tplItemReview',
    'tplOuter' => 'tplItemOuter',
    'startCount' => $startCount,
    'context_key' => $_modx->context.key
]}

{set $all_reviews ='@FILE _modules/mltreviews/snippets/mltReviewItems.php' | snippet : $params}

{if $all_reviews}
<div class="mlt-reviews__all-reviews {$classnames}">
    {if $title}
      <h2 class="mlt-reviews__title section__title">{$title}</h2>
    {/if}
    {$all_reviews}
</div>
{else}
    Здесь пока нет отзывов.
{/if}