{include "file:chunks/svg-gradient.tpl" w=48 h=48}
<div class="mlt-reviews">
    {include 'file:chunks/banners/reviews-head.tpl'}
    
    {set $user_reviews = '!mltReviewItems' | snippet : [ 
        'user_reviews' => 1,
        'ratingRowClass' => 'mlt-reviews__item-rating',
        'ratingItemClass' => 'mlt-reviews__item-rating-item',
        'tpl' => 'tplItemReview',
        'tplOuter' => 'tplItemOuter'
    ]}
    {if $user_reviews}
    <div class="mlt-reviews__user-reviews">
        <h2 class="mlt-reviews__title small-title section__title">На модерации</h2>
        {$user_reviews}
    </div>
    {/if}

    {set $all_reviews ='!mltReviewItems' | snippet : [ 
        'ratingRowClass' => 'mlt-reviews__item-rating',
        'ratingItemClass' => 'mlt-reviews__item-rating-item',
        'tpl' => 'tplItemReview',
        'tplOuter' => 'tplItemOuter'
    ]}

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
