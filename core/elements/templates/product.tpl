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

{* Получаем сертификаты товара *}
{if $_modx->resource.certs}
    {set $certs = $_modx->resource.certs}

    {set $certs = json_decode($certs, true)}
    {if $certs | count > 0}
        {set $renderCerts = 1}
    {/if}
{/if}

{* Получаем отзывы товара *}
{set $reviews = '@FILE snippets/getReviews.php' | snippet | fromJSON}
{set $reviewsCount = $reviews | count}

{* Получаем видео товара *}
{set $video = $_modx->resource.video}
{if $video | length > 0}
    {set $renderVideo = 1}
{/if}

<main class="layout__main">
  <section class="section section_view_top">
    {include "file:chunks/breadcrumbs/breadcrumbs.tpl"}
    <article class="product section js-product not-init"
    {insert "file:chunks/product/get-data-attrs.tpl"}
    >
      <div class="product__container">
        <h2 class="product__title section__title">{$_modx->resource.pagetitle}</h2>
        <div class="product__body">

          {'!msGallery' | snippet : [
          'tpl' => '@FILE chunks/gallery.tpl',
          ]}

          <div class="product__info product-info">
            <div class="product-info__top">
              <div class="product-info__rating rating">
                <ul class="rating__stars">
                  <li class="rating__star active"></li>
                  <li class="rating__star active"></li>
                  <li class="rating__star active"></li>
                  <li class="rating__star active"></li>
                  <li class="rating__star"></li>
                </ul>
                <span class="rating__reviews">
                  {$reviewsCount}
                  {'@FILE snippets/formOfWord.php' | snippet : [
                    'n' => $reviewsCount,
                    'f1' => 'отзыв',
                    'f2' => 'отзыва',
                    'f5' => 'отзывов'
                  ]}
                </span>
              </div>

              <div class="product-info__availability">
                {*
                <div class="product-info__params">
                  <div class="product-info__param">
                    <div class="default-select">
                      <select class="default-select__select" data-id="ss-mgnilr5g" tabindex="-1" aria-hidden="true" style="display: none;">
                        <option data-placeholder="true">Плотность</option>
                        <option value="0">D100</option>
                        <option value="1">D200</option>
                        <option value="2">D300</option>
                      </select><div data-id="ss-mgnilr5g" id="ss-mgnilr5g" tabindex="0" class="ss-main default-select__select" role="combobox" aria-haspopup="listbox" aria-controls="ss-mgnilr5g" aria-expanded="false"><div class="ss-values"><div class="ss-placeholder">Плотность</div></div><div class="ss-deselect ss-hide"><svg viewBox="0 0 100 100"><path d="M10,10 L90,90 M10,90 L90,10"></path></svg></div><svg class="ss-arrow" viewBox="0 0 100 100"><path d="M10,30 L50,70 L90,30"></path></svg></div>
                      <div data-id="ss-mgnilr5g" id="ss-mgnilr5g" class="ss-content default-select__select" role="listbox"><div class="ss-search ss-hide"><input readonly="" type="search" placeholder="Поиск" tabindex="-1" aria-label="Поиск" autocapitalize="off" autocomplete="off" autocorrect="off"></div><div class="ss-list"><div class="ss-option ss-hide"></div><div data-id="tn10zfl7" id="tn10zfl7" class="ss-option" role="option" aria-selected="false">D100</div><div data-id="41cmfz9d" id="41cmfz9d" class="ss-option" role="option" aria-selected="false">D200</div><div data-id="ijgk3t6m" id="ijgk3t6m" class="ss-option" role="option" aria-selected="false">D300</div></div></div>
                    </div>
                  </div>
                  <div class="product-info__param">
                    <div class="default-select">
                      <select class="default-select__select" data-id="ss-g9de1fkx" tabindex="-1" aria-hidden="true" style="display: none;">
                        <option data-placeholder="true">размер</option>
                        <option value="0">1000</option>
                        <option value="1">2000</option>
                        <option value="2">3000</option>
                      </select><div data-id="ss-g9de1fkx" id="ss-g9de1fkx" tabindex="0" class="ss-main default-select__select" role="combobox" aria-haspopup="listbox" aria-controls="ss-g9de1fkx" aria-expanded="false"><div class="ss-values"><div class="ss-placeholder">размер</div></div><div class="ss-deselect ss-hide"><svg viewBox="0 0 100 100"><path d="M10,10 L90,90 M10,90 L90,10"></path></svg></div><svg class="ss-arrow" viewBox="0 0 100 100"><path d="M10,30 L50,70 L90,30"></path></svg></div>
                      <div data-id="ss-g9de1fkx" id="ss-g9de1fkx" class="ss-content default-select__select" role="listbox"><div class="ss-search ss-hide"><input readonly="" type="search" placeholder="Поиск" tabindex="-1" aria-label="Поиск" autocapitalize="off" autocomplete="off" autocorrect="off"></div><div class="ss-list"><div class="ss-option ss-hide"></div><div data-id="01v02jov" id="01v02jov" class="ss-option" role="option" aria-selected="false">1000</div><div data-id="utfl66ei" id="utfl66ei" class="ss-option" role="option" aria-selected="false">2000</div><div data-id="p5n7otak" id="p5n7otak" class="ss-option" role="option" aria-selected="false">3000</div></div></div></div>
                  </div>
                </div>
                *}
                <div class="product-info__availability-title product-info__availability-title_available">На складе 190 м3</div>
              </div>

            </div>
            <div class="product-info__bottom">
              <div class="product-info__volume"><span class="product-info__volume-title">Цена за:</span>
                <input type="hidden" name="unit" value="1">
                {if $prodValues['condition']}
                  <div class="product-card__volume">
                    <ul class="product-info__volume-tabs">
                      <li class="product-info__volume-tab js-product__volume-tab active" data-val="1">{$prodValues['pricePer']}</li>
                      {foreach $prodValues['itemUnits'] as $val}
                        <li class="product-info__volume-tab js-product__volume-tab" data-val="{$val['id']}">{$val['title']}</li>
                      {/foreach}
                    </ul>
                  </div>
                {/if}
              </div>

              <div class="product-info__price">
                <p class="product-info__price-value"><span class="js-product__price" data-default="{$prodValues['defaultPrice']}">{$prodValues['outputPrice']}</span> ₽</p>
              </div>
              <div class="product-info__actions">
                {include "file:chunks/product/product-elems.tpl" prodId=$_modx->resource.id}
              </div>
              <button data-fancybox="" href="#callback" class="product-info__fast-buy btn btn_style_trans">Купить в 1 клик</button>
            </div>
          </div>
        </div>
      </div>
    </article>
  </section>

  <article class="infoblocks infoblocks_style_shadow section">
    <div class="infoblocks__container" data-tabs="">
      <div class="infoblocks__top">
        <div class="infoblocks__tabs">
          <a class="infoblocks__tab" href="javascript:;" data-tab="Описание">Описание</a>
          <a class="infoblocks__tab active" href="javascript:;" data-tab="Характеристики">Характеристики</a>
          <a class="infoblocks__tab" href="javascript:;" data-tab="Условия доставки товара">Условия доставки товара</a>

          {if $renderCerts ?}
            <a class="infoblocks__tab" href="javascript:;" data-tab="Сертификаты">Сертификаты</a>
          {/if}

          {if $reviewsCount > 0}
            <a class="infoblocks__tab" href="javascript:;" data-tab="Отзывы">Отзывы</a>
          {/if}

          {if $renderVideo ?}
            <a class="infoblocks__tab" href="javascript:;" data-tab="Видео">Видео</a>
          {/if}

          <a class="infoblocks__tab" href="{$_modx->resource.id | url}#other-products">Сопутствующие товары</a>
        </div>
      </div>

      <div class="infoblocks__content">
        <div class="infoblocks__block" data-tab-page="Описание">
          <button class="infoblocks__block-title" data-tab="Описание">Описание</button>
          <div class="infoblocks__block-dropdown infoblocks__text">
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

        <div class="infoblocks__block" data-tab-page="Условия доставки товара">
          <button class="infoblocks__block-title" data-tab="Условия доставки товара">Условия доставки товара</button>
          <div class="infoblocks__block-dropdown">
            <div class="table infoblocks__table">
              {include 'file:sections/delivery-inner.tpl'}
            </div>
          </div>
        </div>

        {if $reviewsCount > 0}
          <div class="infoblocks__block" data-tab-page="Отзывы">
            <button class="infoblocks__block-title" data-tab="Отзывы">Отзывы</button>
            <div class="infoblocks__block-dropdown">
              <div class="reviews">
                <div class="reviews__slider">
                  <div class="swiper-container swiper-container-fade swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events">
                    <div class="swiper-wrapper">
                      {foreach $reviews as $idx => $row}
                        <div class="swiper-slide reviews__item" style="width: 802px; opacity: 1; transform: translate3d(0px, 0px, 0px);"><span class="reviews__name">{$row.author}</span>
                          <p class="reviews__text">{$row.text}</p>
                        </div>
                      {/foreach}
                    </div>
                  </div>
                  <div class="swiper-buttons">
                    <div class="swiper-button swiper-button-prev swiper-button-disabled"></div>
                    <div class="swiper-button swiper-button-next"></div>
                  </div>
                </div>
                <a class="btn btn_style_shadow reviews__btn" href="#">Оставить отзыв</a>
              </div>
            </div>
          </div>
        {/if}

        {if $renderCerts ?}
          <div class="infoblocks__block" data-tab-page="Сертификаты">
              <button class="infoblocks__block-title" data-tab="Сертификаты">Сертификаты</button>
              <div class="infoblocks__block-dropdown">
                <ul class="certs-block">
                    {foreach $certs as $ct}
                        <li class="certs-block__item">
                            {set $previewSrc = ''}
                            {set $splitted = $ct.file | split: '.'}
                            {set $count = $splitted | count}
                            {if $count > 1}
                                {set $lastElem = $splitted[$count - 1] | strtolower}

                                {if $lastElem == 'pdf'}
                                    {set $previewSrc = 'pdfToJpg' | snippet : [
                                    'src' => '/assets/template/img/import/' ~ $ct.file,
                                    ]}
                                {elseif ($lastElem in list ['jpg','jpeg','png','gif','webp'])}
                                    {set $previewSrc = '/assets/template/img/import/' ~ $ct.file}
                                {/if}

                                {if $previewSrc ?}
                                    {if $h is empty}
                                        {set $h = 138}
                                    {/if}
                                    {set $previewSrc = 'phpthumbon' | snippet : [
                                    'input' => $previewSrc,
                                    'options' => '&h='~$h~'&far=1'
                                    ]}
                                {/if}
                            {/if}

                            {if $previewSrc is empty}
                                {if $lastElem in list ['dwg','xls','doc', 'rfa', 'odt', 'zip']}
                                    {set $previewClass = 'certs-block__preview-download'}
                                {else}
                                    {set $previewClass = 'certs-block__preview-view'}
                                    {set $fancybox = 'data-fancybox'}
                                {/if}
                                <a class="{$previewClass} certs-block__{$lastElem}-preview" {$fancybox} title="{$ct.name}"
                                   href="/assets/template/img/import/{$ct.file}"></a>
                            {else}
                                <a class="certs-block__cert-preview{if $classToPreview?} {$classToPreview}{/if}" data-fancybox title="{$ct.name}"
                                   href="/assets/template/img/import/{$ct.file}">
                                    <img class="certs-block__cert-img" src="{$previewSrc}" alt="{$ct.name}">
                                </a>
                            {/if}
                        </li>
                    {/foreach}
                </ul>
              </div>
          </div>
        {/if}

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

      <div class="infoblocks__bottom infoblocks__bottom_tab-view" data-tab-page="Условия доставки товара">
        <div class="infoblocks__callback">
          <p class="infoblocks__callback-text">ТОЧНУЮ СТОИМОСТЬ И СРОКИ УТОЧНЯЙТЕ ПО НОМЕРУ:</p><a class="infoblocks__callback-phone" href="tel:+78120000000">
            <svg class="infoblocks__callback-icon" aria-hidden="true">
              <use xlink:href="assets/template/pictures/icons.svg#svg-phone-sm"></use>
            </svg>+7 (812) 000-00-00</a>
        </div>
      </div>
    </div>
  </article>

  {'@FILE snippets/getPopularProductsClass.php' | snippet}
  {include "file:sections/payment.tpl"}
  {include "file:sections/contacts.tpl" styleClass='section_view_bg'}

{/block}
