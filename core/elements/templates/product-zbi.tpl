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
          'tplWrapper' => '@FILE sections/related-products.tpl',
          'includeTVs' => 'isFractional,productNotAvailable,freeShipping',
          'context' => $_modx->resource.context_key,
          'includeThumbs' => 'webp',
        ]}
    {/if}


<main class="layout__main" xmlns="http://www.w3.org/1999/html">

  {include "file:_modules/product-card/gbi-zavod78/product-card.tpl"}

  <article class="product__infoblocks infoblocks infoblocks_style_shadow section">
    <div class="infoblocks__container" data-tabs data-tabs-hiddable="479">
      <div class="infoblocks__top">
        <div class="infoblocks__tabs">
          <a class="infoblocks__tab" href="javascript:;" data-tab="Описание">Описание</a>

          <a class="infoblocks__tab active" href="javascript:;" data-tab="Характеристики">Характеристики</a>

          <a class="infoblocks__tab" href="javascript:;" data-tab="Условия доставки">Условия доставки</a>
          
          <a class="infoblocks__tab" href="javascript:;" data-tab="Прайс">Прайс</a>

          <a class="infoblocks__tab" href="javascript:;" data-tab="Отзывы">Отзывы</a>

          {if $renderVideo ?}
            <a class="infoblocks__tab" href="javascript:;" data-tab="Видео">Видео</a>
          {/if}

        </div>
      </div>

      <div class="infoblocks__content">

        <div class="infoblocks__block" data-tab-page="Описание">
          <button class="infoblocks__block-title" data-tab="Описание">Описание</button>
          <div class="infoblocks__block-dropdown custom-content">
            {$_modx->resource.content}
          </div>
        </div>

        <div class="infoblocks__block active" data-tab-page="Характеристики">
          <button class="infoblocks__block-title" data-tab="Характеристики">Характеристики</button>
          <div class="infoblocks__block-dropdown">
            <div class="table infoblocks__table">
              <table class="table__table">
                <tbody>
                  {'msProductOptions' | snippet : [
                    'tpl' => '@FILE chunks/item-characters.tpl',
                    'ignoreOptions' => 'edizm,edizm2'
                  ]}
                </tbody>
              </table>
            </div>
          </div>
        </div>

        <div class="infoblocks__block" data-tab-page="Условия доставки">
          <button class="infoblocks__block-title" data-tab="Условия доставки">Условия доставки</button>
          <div class="infoblocks__block-dropdown ">
            <div class="product-pricelist">
              {include 'file:sections/delivery-inner.tpl'}
            </div>
            <div class="product-info__delivery-btn infoblocks__bottom"><a class="btn btn_style_shadow" data-fancybox="" href="#callback">заказать с доставкой</a></div>
          </div>
        </div>

        <div class="infoblocks__block" data-tab-page="Прайс">
          <button class="infoblocks__block-title" data-tab="Прайс">Прайс</button>
          <div class="infoblocks__block-dropdown custom-content">
            <div class="table product-pricelist">
                {$_modx->runSnippet('msProducts', [
                  'parents' => $_modx->resource.parent,
                  'depth' => 1,
                  'includeOptions' => 1,
                  'context' => $_modx->resource.context_key,
                  'tplWrapper' => '@INLINE 
                    <table class="table__table product-pricelist-table">
                      <thead>
                        <tr>
                          <th>Наименование</th>
                          <th>Характеристики</th>
                          <th>Цена</th>
                        </tr>
                      </thead>
                      {$output}
                    </table>
                  ',
                  'tpl' => '@INLINE 
                    <tr>
                      <td><a class="link" href="{$uri}">{$pagetitle}</a></td>
                      <td>
                          <p>Маркировка : {$markirovka[0]}</p>
                          <p>Длина, мм : {$_pls["dlina-mm"][0]}</p>
                          <p>Ширина, мм : {$_pls["shirina-mm"][0]}</p>
                          <p>Высота, мм : {$_pls["vysota-mm"][0]}</p>
                      </td>
                      <td>{$price}</td>
                    </tr>
                  ',
                  'limit' => 0,
                ])}
            </div>
            {* <div class="product-info__delivery-btn infoblocks__bottom"><a class="btn btn_style_shadow" data-fancybox="" href="#callback">заказать с доставкой</a></div> *}
          </div>
        </div>

        <div class="infoblocks__block" data-tab-page="Отзывы">
          <button class="infoblocks__block-title" data-tab="Отзывы">Отзывы</button>
          <div class="infoblocks__block-dropdown">
          <div class="infoblocks__block-dropdown">
            {include 'file:_modules/mltreviews/chunks/product-page.tpl'}
        </div>
          </div>
        </div>

        {if $renderVideo == 1}
        <div class="infoblocks__block" data-tab-page="Видео">
          <button class="infoblocks__block-title" data-tab="Видео">Видео</button>
          <div class="infoblocks__block-dropdown">
            {$video}
          </div>
        </div>
        {/if}

      </div>

      {include "file:chunks/guarantees.tpl"}
    </div>

  </article>

  {$recommendProducts?: ''}
  {$simillarProducts ?: ''}

  {include "file:sections/payment.tpl"}
  {include "file:sections/contacts.tpl" styleClass='section_view_bg'}

{/block}
