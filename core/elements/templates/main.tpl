{extends "file:layouts/default.layout.tpl"}

{block 'schema'}
    {set $idCat = '@FILE snippets/getIdByAlias.php' | snippet : ['alias' => 'catalog']}

    {* Отзывы *}
    {set $reviews = 'getSchemaReview' | snippet : ['idCat' => $idCat]}

    {* Минимальные / максимальные значения и общее количество товаров *}
    {'!msGetProductsCount' | snippet : ['ids' => $idCat]}
    {'!msGetProductsMinMaxPrice' | snippet : ['ids' => $idCat]}

    {* Микроразметка *}
    <script type="application/ld+json">
    {if $_modx->resource.menutitle?}
        {set $name = $_modx->resource.menutitle}
    {else}
        {set $name = $_modx->resource.pagetitle}
    {/if}
    {
        "@context": "https://schema.org/",
        "@type": "Product",
        "name": "{$name}",
        "image": "{$_modx->config.site_url ~ 'assets/template/img/favicons/' ~ $site_context ~ '/apple-touch-icon.png'}",
        "description": "{$_modx->resource.description}",
        "brand": "{$brand}",
        {if $reviews ?}
        "review": {
            "@type": "Review",
            "author": "{$reviews['review']['author']}",
            "datePublished": "{$reviews['review']['date']}",
            "name": "{$reviews['reviewName']}",
            "reviewBody": "{$reviews['review']['text']}",
            "reviewRating": {
                "@type": "Rating",
                "ratingValue": "{$reviews['review']['value']}"
            }
        },
        {/if}
        "offers": {
            "@type": "AggregateOffer",
            "lowPrice": "{$_modx->getPlaceholder('min_price')}",
            "highPrice": "{$_modx->getPlaceholder('max_price')}",
            "offerCount": "{$_modx->getPlaceholder('total_count')}",
            "priceCurrency": "RUB"
        },
        {if $reviews ?}
        "aggregateRating": {
            "@type": "AggregateRating",
            "ratingValue": "{$reviews['ratingValue']}",
            "ratingCount": "{$reviews['ratingCount']}",
            "reviewCount": "{$reviews['reviewCount']}"
        }
        {/if}
    }
    </script>
{/block}

{block "page"}
    <div class="wrapper">
        {include "file:blocks/topbar-search.tpl"}
    </div>

    {include "file:sections/main/banner.tpl"}

    <div class="wrapper main-page-content">
        <h1 class="title-1">{$_modx->resource.pagetitle}</h1>

        {if $_modx->resource.introtext | length > 0}
            <div class="content-block">
                {$_modx->resource.introtext}
            </div>
        {/if}
    </div>

    {include "file:sections/popular/sect-pop-main.tpl"}

    {if $_modx->resource.context_key in list ['kirpich-m', 'krovlya']}
        {include "file:sections/main/assort.tpl"}
    {else}
        {include "file:sections/main/catalog.tpl"}
    {/if}

    {include "file:sections/main/promo.tpl"}
    {include "file:sections/main/stocks.tpl"}
    {include "file:sections/certs.tpl"}
    {include "file:sections/faq.tpl"}
    {include "file:sections/payment.tpl"}
    {include "file:sections/appeal.tpl"}
    {include "file:sections/advantages.tpl"}

    {if $_modx->resource.content | length > 0}
        <div class="wrapper">
            <article class="content-block">
                {$_modx->resource.content}
            </article>
        </div>
    {/if}

    {include "file:sections/steps.tpl"}
    {include "file:sections/partners.tpl"}
    {include "file:sections/districts-map.tpl"}
{/block}
