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
    <main class="layout__main">
      <article class="main-screen section">
        <div class="main-screen__container">
          {include "file:sections/banner.tpl"}
          {include "file:sections/advantages-1.tpl"}
        </div>
      </article>
      {include "file:sections/simple-listing.tpl"}
      {include "file:sections/actions.tpl"}
      {include "file:sections/hits.tpl"}
      {include "file:sections/delivery.tpl"}
      {include "file:sections/gazobeton-info.tpl"}
      {include "file:sections/sfaq.tpl"}
      {include "file:sections/contacts.tpl"}
    </main>
{/block}

