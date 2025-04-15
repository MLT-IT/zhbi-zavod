<section class="section section_view_top">
  {include "file:chunks/breadcrumbs/breadcrumbs.tpl"}
  <article class="product section js-product not-init{if $prodValues['itemInCart']?} js-product-in-cart{/if}{if $prodValues['outputOldPrice']?} js-product_with-discount{/if}"
  {insert "file:chunks/product/get-data-attrs.tpl"}
  >
    <div class="product__container">
      <h1 class="product__title section__title">{$_modx->resource.pagetitle}</h1>
      <div class="product__body">

        {'!msGallery' | snippet : [
        'tpl' => '@FILE chunks/gallery.tpl',
        ]}

        <div class="product__info-wrap">
          <div class="product__info product-info">

            <div class="product-info__top">
            {if $_modx->resource.article}
                <div class="product-info__article article mb-2"> Арт. {$_modx->resource.article} </div>
            {/if}
              <div class="product-info__rating rating">
                <div class="product-info__availability-title product-info__availability-title_available mobile-flex">На складе 190 м3</div>

                <ul class="rating__stars">
                  <li class="rating__star active"></li>
                  <li class="rating__star active"></li>
                  <li class="rating__star active"></li>
                  <li class="rating__star active"></li>
                  <li class="rating__star"></li>
                </ul>

                <span class="rating__reviews{if $reviewsCount > 0} rating__reviews_clickable{/if}">
                  {$reviewsCount}
                  {'@FILE snippets/formOfWord.php' | snippet : [
                    'n' => $reviewsCount,
                    'f1' => 'отзыв',
                    'f2' => 'отзыва',
                    'f5' => 'отзывов'
                  ]}
                </span>
              </div>

              {if $_modx->context.key == "web"}
                  {include "file:_modules/warehouse/sections/warehouse-remains.tpl"}
              {/if}
              <div class="product-info__shipped mobile-flex">
                  {'@FILE snippets/shippedToday.php' | snippet}
              </div>


            {if '@FILE snippets/product/isCollerovka.php' | snippet: ['id' => $_modx->resource.id]}
                <div id="collerovka"></div>

{*                  <a href="#calculator-kraski">*}
{*                      <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-calculator-kraski"></use>*}
{*                      Калькулятор краски*}
{*                  </a>*}

            {/if}


              <div class="product-info__relinkav">
                {if $_modx->context.key in list ['gazosilikatstroy,'gazoclone']}
                  {set $relinkingData = '@FILE snippets/getRelinkngDataByVendor.php' | snippet}
                  {if $relinkingData is not empty}
                    <div class="product-info__euv-custom-select euv-custom-select">
                      <div class="euv-custom-select__input">
                        <span class="euv-custom-select__input-value">{$_modx->resource['proizvoditel'][0]}</span>
                      </div>
                      <span class="euv-custom-select__btn"></span>
                      <div class="euv-custom-select__options-wrap">
                        {foreach $relinkingData as $item}
                          <a href="/{$item['uri']}" class="euv-custom-select__option">
                            {$item['proizvoditel']}
                          </a>
                        {/foreach}
                      </div>
                    </div>
                  {/if}
                {/if}

                {switch $_modx->resource.context_key}
                  {case 'web'}
                    {set $unit = '@FILE snippets/formOfWord.php' | snippet : [
                      'n' => $_modx->resource.stockNum,
                      'f1' => 'упаковка',
                      'f2' => 'упаковки',
                      'f5' => 'упаковок'
                    ]}
                  {case 'gazosilikatstroy'}
                    {set $unit = 'м3'}
                  {case 'gazoclone'}
                    {set $unit = 'м3'}
                  {case 'bonolit'}
                    {set $unit = 'м3'}
                  {case 'krovelnyjstroymarket'}
                   {set $unit = 'м2'}
                {/switch}


                {if $_modx->context.key != "web"}
                    {if $_modx->resource.context_key not in list ['kraska']}
                      {* При чем тут relinkingData ? *}
                      {if $relinkingData is empty}
                        <div class="product-info__availability-title product-info__availability-title_available pc-flex">
                              {if $_modx->context.key == 'web'}
                                На складе {$_modx->runSnippet('@FILE snippets/remainsRandom.php', ['begin' => 600, 'end'=> 1100])} {$unit}
                              {elseif $_modx->resource.parent in list $_modx->runSnippet('@FILE snippets/getCategoriesListIds.php', ['parent' => '125530,125537'])}
                                В наличии металл {$_modx->runSnippet('@FILE snippets/random.php', ['begin' => 2000, 'end'=> 4000])} м2
                              {elseif $_modx->context.key in ['krovelnyjstroymarket','bonolit']}
                                На складе {$_modx->runSnippet('@FILE snippets/random.php', ['begin' => 700, 'end'=> 1000])} {$unit}
                              {elseif $_modx->context.key == 'suhiesmesi'}
                                  В наличии {$_modx->runSnippet('@FILE snippets/random.php', ['begin' => 35, 'end'=> 150])} шт
                              {else}
                                На складе {$_modx->resource.stockNum} {$unit}
                            {/if}
                        </div>
                      {/if}
                    {/if}
                {/if}
              </div>

              {if $_modx->resource.context_key not in list ['suhiesmesi']}
                {* При чем тут relinkingData ? *}
                {if ($relinkingData is not empty) && ($_modx->resource.context_key != 'kraska')}
                  <div class="product-info__avstock">
                      <div class="product-info__availability-title product-info__availability-title_available pc-flex">
                        На складе {$_modx->resource.stockNum} {$unit}
                      </div>
                      <div class="product-info__shipped pc-flex">
                          {'@FILE snippets/shippedToday.php' | snippet}
                      </div>
                  </div>
                {else}
                  <div class="product-info__avstock">
                  {if $_modx->resource.context_key == 'kraska'}
                      <div class="product-info__availability-title product-info__availability-title_available pc-flex">
                       В наличии {$_modx->resource.stockNum} {$unit}
                      </div>
                  {else}
                    <div class="product-info__shipped pc-flex">
                      {if $_modx->resource.parent in list $_modx->runSnippet('@FILE snippets/getCategoriesListIds.php', ['parent' => '125530,125537'])}
                          Дата производства при заказе сегодня: <span class="bold"> &nbsp; {'+2 days' | date : 'd.m.Y'} </span>
                          {elseif $_modx->context.key == 'krovelnyjstroymarket'}
                          Дата производства при заказе сегодня: <span class="bold">&nbsp; {'+1 days' | date : 'd.m.Y'} </span>
                          {else}
                          {'@FILE snippets/shippedToday.php' | snippet}
                      {/if}

                    </div>
                  {/if}
                  </div>
                {/if}
              {/if}
            </div>
            
            {if $_modx->resource.context_key == 'web'}
            
                {set $linksData = '@FILE snippets/getRelinkingData_Thickness.php' | snippet}
                {$linksData}
              
            {/if}
          
            <div class="product-info__bottom">
                {* Перелинковка характеристиками *}
                <div class="product-info__selected-characteristics">

                    {if $_modx->context.key == 'suhiesmesi' }
                        {$_modx->runSnippet("@FILE snippets/linking/linking-select.php", [
                        'dependence' => ['cvet', 'ves-shtuki-kg'],
                        'coincide' => ['tip', 'proizvoditel'],
                        'tplFilter' => [
                            'cvet' => '@FILE blocks/product/linking/linking-select-cvet.tpl',
                            'ves-shtuki-kg' => '@FILE blocks/product/linking/linking-list-fasovka.tpl'
                        ]
                        ])}
                    {/if}

                    {* Указаны все категории из главных категорий 125530, 125530, 125541 *}
                    {if ($_modx->resource.context_key == 'krovelnyjstroymarket' && $_modx->resource.template == 17) || $_modx->resource.parent in list $_modx->runSnippet('@FILE snippets/getCategoriesListIds.php', ['parent' => '125530,125530,125541,125537'])  }
                        {set $linksData = 'getRelinkingData_ColorSurfaceThickness' | snippet}
                        {set $cvet = $_modx->resource.cvet[0]}
                    {/if}

                    {if $_modx->resource.context_key in list ['kraska']}
                        {set $linksData = 'getRelinking_ColorFasovkaType' | snippet}
                        {set $cvet = $_modx->resource.cvet[0]}
                    {/if}


                    {if $linksData.cvet?}
                        <div class="product-card__select-wrap{if $_modx->resource.template == 22} product-card__select-wrap_type_full{else} product-card__select-wrap_type_half{/if}">
                            <div class="product-card__select-span">
                                {if $_modx->resource.template == 17 || $_modx->context.key == "kraska"}
                                    Цвет:
                                {elseif $_modx->resource.template in list [20, 22]}
                                    Оттенок:
                                {else}
                                    Цвет:
                                {/if}
                            </div>
                            <div class="custom-select-wrap">
                                <div class="colors-options euv-custom-select euv-custom-select_type_wide custom-select_scrollable">
                                    <div class="euv-custom-select__input">
                                        <span data-val="{$cvet}" class="euv-custom-select__input-value">{$cvet}</span>
                                    </div>
                                    <span class="euv-custom-select__btn"></span>
                                    <div class="euv-custom-select__options-wrap">
                                        <div class="euv-custom-select__options-wrap-scroll">
                                            <div class="euv-custom-select__options-wrap-scroll-inner">
                                                {foreach $linksData.cvet as $data}
                                                    <div class="euv-custom-select__options-col">
                                                        {foreach $data as $id => $val}
                                                            {set $v = $val}
                                                            <a href="{$_modx->makeUrl($id, '', '', 'full')}" data-product="{$id}" class="euv-custom-select__option" data-val="{$v}" data-value="{$val}">
                                                                {$val}
                                                            </a>
                                                        {/foreach}
                                                    </div>
                                                {/foreach}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="custom-select-mobile-link"></div>
                                <div href="#select" data-fancybox="" class="custom-select-mobile-link"></div>
                            </div>
                        </div>
                    {/if}

                    {if $linksData.collection?}
                        <div class="product-card__select-wrap product-card__select-wrap_type_half">
                            <div class="product-card__select-span">Коллекция:</div>
                            <div class="custom-select-wrap">
                                <div class="euv-custom-select euv-custom-select_type_wide custom-select_scrollable">
                                    <div class="euv-custom-select__input">
                                          <span class="euv-custom-select__input-value">
                                              {$_modx->resource.collection[0]}
                                          </span>
                                    </div>
                                    <span class="euv-custom-select__btn"></span>
                                    <div class="euv-custom-select__options-wrap">
                                        <div class="euv-custom-select__options-wrap-scroll">
                                            {foreach $linksData.collection as $id => $val}
                                                <a href="{$_modx->makeUrl($id, '', '', 'full')}" class="euv-custom-select__option">
                                                    {$val}
                                                </a>
                                            {/foreach}
                                        </div>
                                    </div>
                                </div>
                                <div class="custom-select-mobile-link"></div>
                                <div href="#select" data-fancybox="" class="custom-select-mobile-link"></div>
                            </div>
                        </div>
                    {/if}

                    {if $linksData.item_thickness?}
                        <div class="product-card__select-wrap product-card__select-wrap_type_half{if $linksData.cvet?} product-card__select-wrap_align_right{/if}">
                            <div class="product-card__select-span">Толщина, мм:</div>
                            <div class="custom-select-wrap">
                                <div class="euv-custom-select euv-custom-select_type_wide custom-select_scrollable">
                                    <div class="euv-custom-select__input">
                                        <span class="euv-custom-select__input-value">{$_modx->resource.item_thickness[0]}</span>
                                    </div>
                                    <span class="euv-custom-select__btn"></span>
                                    <div class="euv-custom-select__options-wrap">
                                        <div class="euv-custom-select__options-wrap-scroll">
                                            {foreach $linksData.item_thickness as $id => $val}
                                                <a href="{$_modx->makeUrl($id, '', '', 'full')}" class="euv-custom-select__option">
                                                    {$val}
                                                </a>
                                            {/foreach}
                                        </div>
                                    </div>
                                </div>
                                <div class="custom-select-mobile-link"></div>
                                <div href="#select" data-fancybox="" class="custom-select-mobile-link"></div>
                            </div>
                        </div>
                    {/if}

                    {if $linksData.pokrytie?}
                        <div class="product-card__select-wrap product-card__select-wrap_type_full mt">
                            <div class="product-card__select-span">Покрытие:</div>
                            <div class="custom-select-wrap">
                                <div class="euv-custom-select euv-custom-select_type_wide custom-select_scrollable">
                                    <div class="euv-custom-select__input">
                                        <span class="euv-custom-select__input-value">{$_modx->resource.pokrytie[0]}<span class="euv-custom-select__small-text">{$_modx->resource['vid-poverhnosti'][0]}</span></span>
                                    </div>
                                    <span class="euv-custom-select__btn"></span>
                                    <div class="euv-custom-select__options-wrap">
                                        <div class="euv-custom-select__options-wrap-scroll">
                                            {foreach $linksData.pokrytie as $id => $val}
                                                <a href="{$_modx->makeUrl($id, '', '', 'full')}" class="euv-custom-select__option">
                                                    {$val} <span class="euv-custom-select__small-text">{$linksData['vid-poverhnosti'][$id]}</span>
                                                </a>
                                            {/foreach}
                                        </div>
                                    </div>
                                </div>
                                <div class="custom-select-mobile-link"></div>
                                <div href="#select" data-fancybox="" class="custom-select-mobile-link"></div>
                            </div>
                        </div>
                    {/if}

                    {if $linksData.fasovka?}
                        <div class="product-info__select-link mb-4"><span class="product-info__select-link-title">Фасовка:</span>
                            <input type="hidden" name="unit" value="1">
                            <div class="product-card__select-link">
                                <ul class="product-info__select-link-tabs">

                                    {foreach $linksData.fasovka as $id => $val}
                                        {if $_modx->resource.fasovka[0] != $val}
                                            <li class="product-info__select-link-tab js-product__select-link-tab" data-val="{$val['id']}">
                                                <a href="{$_modx->makeUrl($id, '', '', 'full')}" class="euv-custom-select__option">
                                                    {$val}
                                                </a>
                                            </li>
                                            {else}
                                            <li class="product-info__select-link-tab js-product__select-link-tab active" data-val="1">{$_modx->resource.fasovka[0]}</li>
                                        {/if}
                                    {/foreach}
                                </ul>
                            </div>
                        </div>
                    {/if}

                    {if $linksData.tip?}
                        <div class="product-card__select-wrap product-card__select-wrap_type_half{if $linksData.tip?} product-card__select-wrap_align_right{/if}">
                            <div class="product-card__select-span">Тип:</div>
                            <div class="custom-select-wrap">
                                <div class="euv-custom-select euv-custom-select_type_wide custom-select_scrollable">
                                    <div class="euv-custom-select__input">
                                        <span class="euv-custom-select__input-value">{$_modx->resource.tip[0]}</span>
                                    </div>
                                    <span class="euv-custom-select__btn"></span>
                                    <div class="euv-custom-select__options-wrap">
                                        <div class="euv-custom-select__options-wrap-scroll">
                                            {foreach $linksData.tip as $id => $val}
                                                <a href="{$_modx->makeUrl($id, '', '', 'full')}" class="euv-custom-select__option">
                                                    {$val}
                                                </a>
                                            {/foreach}
                                        </div>
                                    </div>
                                </div>
                                <div class="custom-select-mobile-link"></div>
                                <div href="#select" data-fancybox="" class="custom-select-mobile-link"></div>
                            </div>
                        </div>
                    {/if}

                </div>
                {* Конец перелинковка характеристиками *}

            <div class="product-info__volume"><span class="product-info__volume-title">Цена за:</span>
                <input type="hidden" name="unit" value="1">
                <div class="product-card__volume">
                  <ul class="product-info__volume-tabs">
                    <li class="product-info__volume-tab js-product__volume-tab active" data-val="1">{$prodValues['pricePer']}</li>
                    {foreach $prodValues['itemUnits'] as $val}
                        {if $prodValues['pricePer'] != $val['title']}
                           <li class="product-info__volume-tab js-product__volume-tab" data-val="{$val['id']}">{$val['title']}</li>
                        {/if}
                    {/foreach}
                  </ul>
                </div>
              </div>

              
              <div class="product-info__price{if $prodValues['outputOldPrice']?} active{/if}">
                <div class="product-info__price-tooltip-wrapper">
                  <div class="tooltip">
                    <p class="tooltip__header">Снижение цены!</p>
                    <p class="tooltip__body">Мы регулярно снижаем цены на наши товары, чтобы покупка у нас была еще выгоднее!</p>
                    <span class="tooltip__close"></span>
                  </div>
                </div>
                <p class="product-info__price-value">
                  <span class="js-product__price" data-default="{$prodValues['defaultPrice']}">{$prodValues['outputPrice']}</span> ₽
                </p>
                {if $prodValues['outputOldPrice']?}
                  <div class="js-product__old-price">
                    <span class="js-product__old-price-val" data-default="{$prodValues['defaultOldPrice']}">
                        {$prodValues['outputOldPrice']}
                    </span>
                    ₽
                  </div>

                {/if}
              </div>
              <div class="product-info__actions">
                {include "file:chunks/product/product-elems.tpl" prodId=$_modx->resource.id}
              </div>
              <button data-fancybox="" href="#callback" class="product-info__fast-buy btn btn_style_trans">Купить в 1 клик</button>
            </div>

            {if $_modx->resource.context_key in list ['kraska', 'suhiesmesi']}
                <div class="product-info__undertext">
                  <p class="product-info__undertext-span">
                  <svg xmlns="http://www.w3.org/2000/svg" version="1.0" width="16pt" height="16pt" class="icon" viewBox="0 0 512.000000 512.000000" preserveAspectRatio="xMidYMid meet">
                      <use xlink:href="/assets/template/img/svg-sprite.svg#icon-location-product"></use>
                  </svg>
                  <span class="product-info__undertext-span-header">Самовывоз:</span> сегодня
                  </p>
                  <p class="product-info__undertext-span">
                      <svg xmlns="http://www.w3.org/2000/svg" version="1.0" width="16pt" height="16pt" class="icon" viewBox="0 0 512.000000 512.000000" preserveAspectRatio="xMidYMid meet">
                          <use xlink:href="/assets/template/img/svg-sprite.svg#icon-delivery-product"></use>
                      </svg>
                      <span class="product-info__undertext-span-header">Доставка:</span> 1-2 дня
                  </p>
                </div>
            {/if}
          </div>

          {switch $_modx->resource.context_key}
            {case 'gazosilikatstroy'}
                <p class="product-info__discount"><span class="product-info__discount-start">Скидка</span> 30% на доставку с <span class="product-info__discount-end">разгрузкой</span></p>
            {case 'gazoclone'}
                <p class="product-info__discount"><span class="product-info__discount-start">Скидка</span> 30% на доставку с <span class="product-info__discount-end">разгрузкой</span></p>
            {case 'krovelnyjstroymarket'}
                <p class="product-info__discount"><span class="product-info__discount-start">Скидка</span> 30% на доставку с <span class="product-info__discount-end">разгрузкой</span></p>
            {case 'web'}
                <p class="product-info__discount"><span class="product-info__discount-start">Льготная</span> доставка <span class="product-info__discount-end">1990 ₽</span></span></p>
          {/switch}
        </div>
      </div>
    </div>
  </article>
</section>
