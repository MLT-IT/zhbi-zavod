{extends "file:layouts/default.layout.tpl"}

    {block 'title'}
        {include "file:chunks/meta/product/meta-title.tpl"}
    {/block}
    {block 'description'}
        {include "file:chunks/meta/product/meta-description.tpl"}
    {/block}

    {block "page"}
    {* Если фоток нет, то ставим заглушку *}
    {if $files | count == 0}
      {set $files = [['small' => '/assets/images/no_image.jpg']]}
    {/if}

    {* Получаем кол-во товара в корзине, нахождение товара в избранном и сравнении *}
    {if $_modx->getPlaceholder('checkItems') is null}
        {'!checkItems' | snippet}
    {/if}

    {* Получаем коэффициенты единиц измерения товара *}
    {set $src = $_modx->resource}
    {insert "file:chunks/product/set-values-for-prod-new.tpl"}

    {* Получаем отзывы товара *}
    {set $reviews = '@FILE snippets/getReviews.php' | snippet | fromJSON}
    {set $reviewsCount = $reviews | count}

    {* Получаем сертификаты товара *}
    {if $_modx->resource.certs}
      {set $certs = $_modx->resource.certs}

      {set $certs = json_decode($certs, true)}
      {if $certs | count > 0}
          {set $renderCerts = 1}
      {/if}
    {/if}

    {* Получаем видео товара *}
    {set $video = $_modx->resource.video}
    {if $video | length > 0}
        {set $renderVideo = 1}
    {/if}


    {if $_modx->resource.recommendIds ?}
        {set $recommendProducts = 'msProducts' | snippet : [
          'resources' => $_modx->resource.recommendIds,
          'sortby' => 'FIELD(msProduct.id, ' ~ $_modx->resource.recommendIds ~ ')',
          'parents' => 0,
          'depth' => 50,
          'limit' => 42,
          'tpl' => '@FILE chunks/product/listing-products-item-slide.tpl',
          'tplWrapper' => '@FILE sections/related-products/wrapper.tpl',
          'includeTVs' => 'isFractional,productNotAvailable,freeShipping',
          'context' => $_modx->resource.context_key,
          'includeThumbs' => 'webp',
        ]}
    {/if}


<main class="layout__main" xmlns="http://www.w3.org/1999/html">

  {insert "file:modules/product-card/product-card-main.tpl"}

  {include "file:templates/product-zbi/tabs/wrapper.tpl"}

  {$recommendProducts?: ''}
  {$simillarProducts ?: ''}

  {include "file:sections/payment/wrapper.tpl"}
  {include "file:modules/contacts-block/wrapper.tpl" styleClass='section_view_bg'}

{/block}
