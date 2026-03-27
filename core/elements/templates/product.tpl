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

{if $_modx->context.key !== 'gazosilikatstroy'}
  {* Получаем отзывы товара *}
  {switch $_modx->resource.context_key}
  {case 'kirpich-m5'}
    {set $reviewsCount = 21}
  {default}
    {set $reviews = '@FILE snippets/getReviews.php' | snippet | fromJSON}
    {set $reviewsCount = $reviews | count}
  {/switch}
{/if}

{* Получаем видео товара *}
{set $video = $_modx->resource.video}
{if $video | length > 0}
    {set $renderVideo = 1}
{/if}

{* этот кусок под osnova.spb.ru, вероятно при дальнейшей монстризации лучше сделать отдельный шаблон для кровли *}
{* определяю гибкую черепицу *}
{set $isGibkaya = $_modx->resource.parent in list $_modx->runSnippet('@FILE snippets/getCategoriesListIds.php', ['parent' => 125532])}

{* определяю профлист и профлист для забора *}
{set $isProflist =  ($_modx->resource.parent in list $_modx->runSnippet('@FILE snippets/getCategoriesListIds.php', ['parent' => 125537]))}

{* определяю отдельно профлист для забора *}
{set $isProflistZ =  ($_modx->resource.parent in list $_modx->runSnippet('@FILE snippets/getCategoriesListIds.php', ['parent' => 126153]))}

{* определяю фиброцементный фасад Дековер и Кедрал *}
{set $isFibrofasadDK =  ($_modx->resource.parent in list $_modx->runSnippet('@FILE snippets/getCategoriesListIds.php', ['parent' => '171090, 171056']))}

{* определяю штакетник  *}
{set $isShtaketnik =  (($_modx->resource.parent in list $_modx->runSnippet('@FILE snippets/getCategoriesListIds.php', ['parent' => 125541])) || $isProflistZ)}

{* определяю металлочерепицу  *}
{set $isMetalloCherepica = ($_modx->resource.parent in list $_modx->runSnippet('@FILE snippets/getCategoriesListIds.php', ['parent' => 125530]))}

{* для калькулятора *}
{set $isCustomCalculator = $isProflist || $isMetalloCherepica}

{*Настройка карточки кровли, центральное место *}
{set $settingCardKrovlya = [
    'width' => 0,
    'optionWidth' => 'rabochaya-shirina',
    'maxLength' => 12000,
    'stepLength' => 500,
    'minLength' => 500
]}
{if $settingCardKrovlya['optionWidth']}
    {* для металлочерепицы важнее полезная ширина *}
    {if $isMetalloCherepica}
      {set $settingCardKrovlya['width'] = $_modx->runSnippet("@FILE snippets/getOptionProduct.php", ['key' => 'poleznaya-shirina'])}
    {/if}
    {if !$settingCardKrovlya['width']}
      {set $settingCardKrovlya['width'] = $_modx->runSnippet("@FILE snippets/getOptionProduct.php", ['key' => $settingCardKrovlya['optionWidth']])}
    {/if}
{/if}
{*  *}


{if $_modx->context.key in list ["web", "krovelnyjstroymarket", "trotuarnaya-plitka"]}
  {set $similarsamples = "@FILE _modules/similarsamples/snippets/getSimilarProducts.php" | snippet}
{/if}

{if $_modx->resource.context_key == 'krovelnyjstroymarket' && !$similarsamples}
    {* Сопутствующие товары из категории ондулин -> сопутствующие товары *}
    {set $soput_options = [
      'resources' => '-' ~ $_modx->resource.id,
      'parents' => 125617,
      'limit' => 42,
      'tpl' => '@FILE chunks/product/listing-products-item-slide.tpl',
      'tplWrapper' => '@FILE sections/related-products.tpl',
      'includeTVs' => 'isFractional,productNotAvailable,freeShipping',
      'context' => $_modx->resource.context_key,
      'includeThumbs' => 'webp',
      'optionFilters' => '{"cvet":"'~$_modx->resource.cvet[0]~'"}',
    ]}

    {* Сопутствующие товары гибкой черепице *}
    {if $isGibkaya}
      {set $soput_options['parents'] = '126015,125951,125554'}
      {set $soput_options['sortby'] = '{"parent":"DESC"}'}
      {set $soput_options['optionFilters'] = '{"palitra:=":"'~$_modx->resource.cvet[0]~'","proizvoditel:=":"'~$_modx->resource.proizvoditel[0]~'"}'}
    {/if}
      
    {* Сопутствующие товары профлист и профлист для забора *}
    {if $isProflist || $isMetalloCherepica}
      {set $soput_options['parents'] = '125533'}
      {set $soput_options['sortby'] = '{"parent":"DESC"}'}
      {set $soput_options['optionFilters'] = '{"cvet:=":"'~$_modx->resource.cvet[0]~'","proizvoditel:=":"'~$_modx->resource.proizvoditel[0]~'","pokrytie:=":"'~$_modx->resource.pokrytie[0]~'"}'}
    {/if}
    {* здесь вызываем *}
    {set $recommendProducts = 'msProducts' | snippet : $soput_options}
    {*  *}

    {set $simillarProductIds = $_modx->resource.simillarProductIds}
    {if $simillarProductIds}
        {* Похожие товары, отображаются товары с одинаковыми характеристиками кроме цвета *}
        {set $simillarProducts = 'msProducts' | snippet : [
        'resources' => $simillarProductIds,
        'parents' => 0,
        'tpl' => '@FILE chunks/product/listing-products-item-slide.tpl',
        'tplWrapper' => '@FILE sections/simillar-products.tpl',
        'includeTVs' => 'isFractional,productNotAvailable,freeShipping',
        'context' => $_modx->resource.context_key,
        'includeThumbs' => 'webp',
        ]}
    {/if}

{elseif $_modx->resource.recommendIds && !$similarsamples}
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

{if $isFibrofasadDK}
  {set $simillarProductsParams = [
    'tpl' => '@FILE chunks/product/listing-products-item-slide.tpl',
    'tplWrapper' => '@FILE sections/simillar-products.tpl',
    'includeTVs' => 'isFractional,productNotAvailable,freeShipping',
    'context' => $_modx->resource.context_key,
    'includeThumbs' => 'webp',
  ]}
  
  {$_modx->setPlaceholder('isFibrofasadDK', true)}

  {if $_modx->resource.parent == 171090}
    {$_modx->setPlaceholder('simillarProductsId', 1)}
    {set $simillarProductsParams['parents'] = 171158}
    {set $simillarProductsParams['optionFilters'] = '{"ottenok:=" : "'~$_modx->resource["ottenok.value"]~'"}'}
    {set $simillarProductsComp = 'msProducts' | snippet : $simillarProductsParams}
    {$_modx->setPlaceholder('isSimillarProductsComp', strlen($simillarProductsComp) > 100)}

    {$_modx->setPlaceholder('simillarProductsId', 2)}
    {set $simillarProductsParams['parents'] = 171092}
    {set $simillarProductsDob = 'msProducts' | snippet : $simillarProductsParams}
  {else}
    {$_modx->setPlaceholder('simillarProductsId', 1)}
    {set $simillarProductsParams['parents'] = 171085}
    {set $simillarProductsParams['optionFilters'] = '{"ottenok:=" : "'~$_modx->resource["ottenok.value"]~'"}'}
    {set $simillarProductsComp = 'msProducts' | snippet : $simillarProductsParams}
    {$_modx->setPlaceholder('isSimillarProductsComp', strlen($simillarProductsComp) > 100)}
    
    {$_modx->setPlaceholder('simillarProductsId', 2)}
    {set $simillarProductsParams['parents'] = 171060}
    {set $simillarProductsParams['optionFilters'] = '{"cvet:=" : "'~$_modx->resource["cvet.value"]~'"}'}
    {set $simillarProductsDob = 'msProducts' | snippet : $simillarProductsParams}
  {/if}
{/if}

{* Указаны все категории из главных категорий 125530, 32, 37, 41 *}
{if ($_modx->resource.context_key == 'krovelnyjstroymarket' && $_modx->resource.template == 17) || $_modx->resource.parent in list $_modx->runSnippet('@FILE snippets/getCategoriesListIds.php', ['parent' => '125530,125532,125541,125537'])  }
  {set $linksData = 'getRelinkingData_ColorSurfaceThickness' | snippet}
  {set $cvet = $_modx->resource.cvet[0]}

  {if $linksData.cvet?}
    {set $colorsSorted = $_modx->runSnippet("@FILE snippets/linking/getSortedByPopColors.php", ["colorsArrays" => $linksData.cvet])}
    {if $colorsSorted?}
        {set $linksData.cvet = $_modx->runSnippet("@FILE snippets/linking/getSplitedColors.php", ["colorsArray" => $colorsSorted])}
    {/if} 
  {/if}
{/if}

{if $_modx->resource.context_key in list ['kraska']}
{set $linksData = 'getRelinking_ColorFasovkaType' | snippet}
{set $cvet = $_modx->resource.cvet[0]}
{/if}

{if $_modx->resource.context_key in list ['fibrofasad', 'krovelnyjstroymarket']}
{set $linksData = 'getRelinkingData_Ottenok' | snippet}
{/if}

<main class="layout__main" xmlns="http://www.w3.org/1999/html">
  <section class="section section_view_top">
    {include "file:chunks/breadcrumbs/breadcrumbs.tpl"}
    {insert 'file:_modules/product-card/product-card-main.tpl'}
  </section>

  <article class="product__infoblocks infoblocks infoblocks_style_shadow section">
    <div class="infoblocks__container" data-tabs data-tabs-hiddable="479">
      <div class="infoblocks__top">
        <div class="infoblocks__tabs">
          <a class="infoblocks__tab" href="javascript:;" data-tab="Описание">Описание</a>
          <a class="infoblocks__tab active" href="javascript:;" data-tab="Характеристики">Характеристики</a>
          <a class="infoblocks__tab" href="javascript:;" data-tab="Условия доставки">Условия доставки</a>

          {if $renderCerts ?}
            <a class="infoblocks__tab" href="javascript:;" data-tab="Сертификаты">Сертификаты</a>
          {/if}


            <a class="infoblocks__tab" href="javascript:;" data-tab="Отзывы">Отзывы</a>

          {if $renderVideo ?}
            <a class="infoblocks__tab" href="javascript:;" data-tab="Видео">Видео</a>
          {/if}

            {if $_modx->resource.recommendForUse != "" && $_modx->context.key in list ['suhiesmesi', 'kraska']}
                <a class="infoblocks__tab" href="javascript:;" data-tab="Рекомендации по применению">Рекомендации по применению</a>
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
                    'ignoreOptions' => 'edizm,edizm2,grandlineid'
                  ]}
                </tbody>
              </table>
            </div>
          </div>
        </div>
        <div class="infoblocks__block" data-tab-page="Условия доставки">
          <button class="infoblocks__block-title" data-tab="Условия доставки">Условия доставки</button>
          <div class="infoblocks__block-dropdown">
            <div class="table infoblocks__table">
              {include 'file:sections/delivery-inner.tpl'}
            </div>
            <div class="product-info__delivery-btn infoblocks__bottom"><a class="btn btn_style_shadow" data-fancybox="" href="#callback">заказать с доставкой</a></div>
          </div>
        </div>
        <div class="infoblocks__block" data-tab-page="Отзывы">
            <button class="infoblocks__block-title" data-tab="Отзывы">Отзывы</button>
            <div class="infoblocks__block-dropdown">
              {if $_modx->context.key in ['krovelnyjstroymarket', 'kirpich-m5', 'fibrofasad','trotuarnaya-plitka', 'web']}
                {insert 'file:_modules/mltreviews/chunks/product-page.tpl'}
              {else}
              <div class="reviews">
                {foreach $reviews as $idx => $row}
                    {if $row.status == 1}
                        {set $statusPublishedReviews = true}
                    {/if}
                {/foreach}

               {if $_modx->context.key == 'gazosilikatstroy'}
                  {include "file:chunks/all_reviews.tpl" classnames="cols-2"}
               {else}
                  {if $reviewsCount > 0 && $statusPublishedReviews}
                    <div class="reviews__slider">
                      <div class="swiper-container swiper-container-fade swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events">
                        <div class="swiper-wrapper">

                          {foreach $reviews as $idx => $row}
                              {if $row.status == 1}
                                <div class="swiper-slide reviews__item" style="width: 802px; opacity: 1; transform: translate3d(0px, 0px, 0px);"><span class="reviews__name">{$row.author}</span>
                                  <p class="reviews__text">{$row.text}</p>
                                </div>
                              {/if}
                          {/foreach}

                        </div>
                      </div>

                        <div class="swiper-buttons">
                        <div class="swiper-button swiper-button-prev swiper-button-disabled"></div>
                        <div class="swiper-button swiper-button-next"></div>
                      </div>
                    </div>
                  {else}
                      <h3 class="py-5">Еще нет отзывов</h3>
                  {/if}
                {/if}

                <a class="btn btn_style_shadow reviews__btn"  data-fancybox href="#review">Оставить отзыв</a>
              </div> 
              {/if}
            </div>
          </div>


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
                                    {set $previewSrc = '@FILE: snippets/pdfToJpg.php' | snippet : [
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
                                {if $lastElem in list ['dwg','xls','doc', 'rfa', 'odt', 'zip', 'docx']}
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
              {set $srcs = $video | split}
              {foreach $srcs as $src}
                  <iframe width="100%" height="450" class="lazy" data-src="{$src}" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
              {/foreach}
            </div>
          </div>
        {/if}

          {if $_modx->resource.recommendForUse != "" && $_modx->context.key in list ['suhiesmesi', 'kraska']}
              <div class="infoblocks__block" data-tab-page="Рекомендации по применению">
                  <button class="infoblocks__block-title" data-tab="Рекомендации по применению">Рекомендации по применению</button>
                  <div class="infoblocks__block-dropdown custom-content">
                      {$_modx->resource.recommendForUse}
                  </div>
              </div>
         {/if}

      </div>

      {include "file:chunks/guarantees.tpl"}
    </div>

    {if $_modx->context.key == "kraska" && $_modx->resource.parent in list $_modx->runSnippet("@FILE snippets/getCategoriesListIds.php", ['parent' => '125345,117397']) }
        <div class="infoblocks__container calculator-kraski">
            {include "file:chunks/calculator-kraski.tpl"}
        </div>
    {/if}

  </article>

  {$recommendProducts?: ''}
  {$simillarProducts ?: ''}

  {* msProducts у пустого возвращает строку из 4х символов, трим не сработал *}
  {set $isSimillarProductsDob = strlen($simillarProductsDob) > 100}

  {if $isFibrofasadDK && $_modx->getPlaceholder('isSimillarProductsComp') || $isSimillarProductsDob}
    <div class="other-products-wrapper">
      <div class="other-products__container">
        <div class="other-products__controls">
          {if $_modx->getPlaceholder('isSimillarProductsComp')}
          <a href="#simillar-products1" class="other-products__control active js-toggle-other-products">
            Комплектующие элементы
          </a>
          {/if}
          {if $isSimillarProductsDob}
          <a href="#simillar-products2" class="other-products__control {if !$_modx->getPlaceholder('isSimillarProductsComp')}active{/if} js-toggle-other-products">
            Доборные элементы
          </a>
          {/if}
        </div>
      </div>
    {$simillarProductsComp ?: ''}
    {$simillarProductsDob ?: ''}
    </div>
  {/if}

  {if $_modx->context.key in list ["trotuarnaya-plitka", "web"]}
    {$similarsamples}
  {/if}

  {if $_modx->context.key == "krovelnyjstroymarket"}
    {$similarsamples}
    {include "file:sections/product-advantages/wrapper.tpl"}
    {include "file:sections/faq.tpl"}
  {/if}

  {include "file:sections/payment.tpl"}

  {if $_modx->context.key == 'krovelnyjstroymarket'}
  <section style="padding-bottom: 0;">
    {include "file:sections/calculator-banner/wrapper.tpl"}
  </section>
  {/if}

  {include "file:modules/contacts-block/wrapper.tpl" styleClass='section_view_bg'}

{/block}
