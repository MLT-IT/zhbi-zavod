{include "file:chunks/svg-gradient.tpl" w=48 h=48}
<div class="mlt-reviews">
    {include 'file:chunks/banners/reviews-head.tpl'}
    {set $startCount = 9}

    {set $user_reviews = '@FILE _modules/mltreviews/snippets/mltReviewItems.php' | snippet : [ 
        'user_reviews' => 1,
        'ratingRowClass' => 'mlt-reviews__item-rating',
        'ratingItemClass' => 'mlt-reviews__item-rating-item',
        'tpl' => 'tplItemReview',
        'tplOuter' => 'tplItemOuter',
        'limit' => 3
    ]}

    {if $user_reviews}
    <div class="mlt-reviews__user-reviews">
        <h2 class="mlt-reviews__title small-title section__title">На модерации</h2>
        {$user_reviews}
    </div>
    {/if}

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
    <div class="mlt-reviews__all-reviews">
        <h2 class="mlt-reviews__title section__title">Отзывы о нашей работе</h2>
        {$all_reviews}
    </div>
    {else}
        Здесь пока нет отзывов.
    {/if}

    {include 'file:sections/about/sect-about-all.tpl'}

    <div class="popup" id="mlt-reviews-form">
        
            <div class="mlt-reviews__title">Оставить отзыв</div>
            {'!mltReviewForm' | snippet : [
                'tpl' => 'tplForm'
            ]}
    </div>
</div>
