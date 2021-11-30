{extends "file:layouts/default.layout.tpl"}

{block 'schema'}
    {* Картинка *}
    {set $schemaImg = $_modx->resource.mainImage}
    {if $schemaImg ?}
        {set $schemaImg = $_modx->config.site_url ~ $schemaImg}
    {else}
        {set $schemaImg = $_modx->config.site_url ~ 'assets/template/img/favicons/' ~ $site_context ~ '/apple-touch-icon.png'}
    {/if}

    {* Отзывы *}
    {set $reviews = 'getSchemaReview' | snippet}

    {* Минимальные / максимальные значения и общее количество товаров *}
    {'!msGetProductsCount' | snippet}
    {'!msGetProductsMinMaxPrice' | snippet}

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
        "image": "{$schemaImg}",
        "description": "{$_modx->resource.description}",
        "brand": "{$brand}",
        {if $reviews ?}
        "review": {
            "@type": "Review",
            "author": "{$reviews['review']['author']}",
            "datePublished": "{$reviews['review']['date']}",
            "name": "{$name}",
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
        {include "file:blocks/breadcrumbs.tpl"}
    </div>

    <div class="wrapper category-header">
        <h1 class="title-1 category-header__title">{$_modx->resource.pagetitle}</h1>
    </div>

    {include "file:sections/category/listing.tpl"}
    {include "file:sections/certs.tpl"}
    {include "file:sections/faq.tpl"}
    {include "file:sections/advantages.tpl"}

    {if $_modx->resource.content | length > 0}
        <div class="wrapper">
            <div class="content-block">
                {$_modx->resource.content}
            </div>
        </div>
    {/if}

    {include "file:sections/partners.tpl"}
    {include "file:sections/districts-map.tpl"}
{/block}
