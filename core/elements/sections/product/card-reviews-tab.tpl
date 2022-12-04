<div class="reviews">
    <div class="reviews__top" {*itemprop="aggregateRating" itemscope="" itemtype="http://schema.org/AggregateRating"*}>

        <span>Средняя оценка</span>

        {*
        <span itemprop="ratingValue" class="reviews__top-value">4.9</span>
        <meta itemprop="ratingCount" content="122">
        <meta itemprop="worstRating" content="1.0">
        <meta itemprop="bestRating" content="5.0">
        *}

        <div class="product-card__reviews-stars five">
            <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>
            </svg>
            <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>
            </svg>
            <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>
            </svg>
            <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>
            </svg>
            <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>
            </svg>
        </div>

        {*
        <div itemprop="itemReviewed" itemscope="" itemtype="http://schema.org/Organization">
            <meta itemprop="name" content="{$_modx->config.http_host}"><span itemprop="address" itemscope="" itemtype="http://schema.org/PostalAddress">
				<meta itemprop="addressLocality" content="{$_modx->config.address}"></span>
            <meta itemprop="telephone" content="{$_modx->config.phone}">
        </div>
        *}

    </div>
    <a class="reviews__button" data-src="#reviews" data-fancybox>
        <span>
            <svg class="svg icon-pen" xmlns="http://www.w3.org/2000/svg"
                 xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-pen"></use>
            </svg>
            Оставьте свой отзыв
        </span>
        <div class="reviews__button-stars">
            <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
                 version="1.1">
                <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>
            </svg>
            <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
                 version="1.1">
                <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>
            </svg>
            <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
                 version="1.1">
                <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>
            </svg>
            <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
                 version="1.1">
                <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>
            </svg>
            <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
                 version="1.1">
                <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>
            </svg>
        </div>
    </a>
    <div class="reviews__list">
        {foreach $reviews as $idx => $row}
            {set $classValue = ''}
            {switch $row.value}
                {case 1}
                    {set $classValue = 'one'}
                {case 2}
                    {set $classValue = 'two'}
                {case 3}
                    {set $classValue = 'three'}
                {case 4}
                    {set $classValue = 'four'}
                {case 5}
                    {set $classValue = 'five'}
            {/switch}

            <div class="reviews__item">
                <div class="product-card__reviews-stars{$classValue ? ' ' ~ $classValue : ''}">
                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>
                    </svg>
                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>
                    </svg>
                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>
                    </svg>
                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>
                    </svg>
                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>
                    </svg>
                </div>
                <div class="reviews__item-content">
                    <div class="reviews__item-user">
                        <div class="reviews__item-user-name">{$row.author}</div>
                        <div class="reviews__item-user-date">({$row.date})</div>
                    </div>
                    <div class="reviews__item-text">
                        {$row.text}
                    </div>
                </div>
            </div>
        {/foreach}
    </div>

</div>
