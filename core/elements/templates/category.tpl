{extends "file:layouts/default.layout.tpl"}

{block 'schema'}
    {* Картинка *}
    {set $schemaImg = $_modx->resource.mainImage}
    {if $schemaImg ?}
        {set $schemaImg = $_modx->config.site_url ~ $schemaImg}
    {else}
        {set $schemaImg = $_modx->config.site_url ~ 'assets/template/img/favicons/' ~ $site_context ~ '/apple-touch-icon.png'}
    {/if}

    {'!msPCS' | snippet}
    {if ($_modx->getPlaceholder('mspcs.option') is not empty) OR ($_modx->getPlaceholder('mspcs.where') is not empty)}
        {set $idCat = '@FILE snippets/getIdByAlias.php' | snippet : ['alias' => 'catalog']}
        {set $dataForSchema = 'getDataForSchema' | snippet : ['idCat' => $idCat]}
        {$_modx->setPlaceholder('min_price', $dataForSchema['min_price'])}
        {$_modx->setPlaceholder('max_price', $dataForSchema['max_price'])}
        {$_modx->setPlaceholder('total_count', $dataForSchema['total_count'])}
        {set $reviews = 'getSchemaReview' | snippet : ['idCat' => $idCat]}
    {else}
        {'!msGetProductsCount' | snippet}
        {'!msGetProductsMinMaxPrice' | snippet}
        {set $reviews = 'getSchemaReview' | snippet}
    {/if}

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
        {include "file:blocks/breadcrumbs.tpl"}
    </div>
    <div class="wrapper">
        <h1 class="title-1 category-header asfs">{$_modx->resource.pagetitle}</h1>
    </div>
    {include "file:sections/category/listing.tpl"}
    {include "file:sections/districts-map.tpl"}
    {if $_modx->resource.content | length > 0}
        <div class="wrapper">
            <article class="content-block">
                {$_modx->resource.content}
            </article>
        </div>
    {/if}
    {include "file:sections/certs.tpl"}
    {include "file:sections/faq.tpl"}
    {include "file:sections/payment.tpl"}
    {include "file:sections/advantages.tpl"}
    {include "file:sections/steps.tpl"}
    {include "file:sections/partners.tpl"}
{/block}
