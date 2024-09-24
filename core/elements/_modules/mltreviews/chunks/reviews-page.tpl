<div class="mlt-reviews">
    <article class="content-block quote_block">
        <button class="mlt-reviews__open-form btn btn_style_base" data-fancybox data-src="#mlt-reviews-form">Оставить отзыв</button>
    </article>
    
    {set $user_reviews = '!mltReviewItems' | snippet : [ 
        'user_reviews' => 1,
        'ratingRowClass' => 'mlt-reviews__item-rating',
        'ratingItemClass' => 'mlt-reviews__item-rating-item',
        'tpl' => 'tplItemReview',
        'tplOuter' => 'tplItemOuter'
    ]}
    {if $user_reviews}
    <div class="mlt-reviews__user-reviews">
        <div class="mlt-reviews__title small-title">На модерации</div>
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
        <div class="mlt-reviews__title">Отзывы о нашей работе</div>
        {$all_reviews}
    </div>
    {else}
        Пусто
    {/if}

  
    <div class="popup" id="mlt-reviews-form">
        
            <div class="mlt-reviews__title">Оставить отзыв</div>
            {'!mltReviewForm' | snippet : [
                'tpl' => 'tplForm'
            ]}
    </div>
</div>
