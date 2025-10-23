    <article class="product section js-product not-init{if $prodValues['itemInCart']?} js-product-in-cart{/if}{if $prodValues['outputOldPrice']?} js-product_with-discount{/if}"
    {insert "file:chunks/product/get-data-attrs.tpl"}
    >
      <div class="product__container">
        <h1 class="product__title section__title">{$_modx->resource.pagetitle}</h1>
        <div class="product__body">

          <div class="product__body-left">
            {'!msGallery' | snippet : [
            'tpl' => '@FILE chunks/gallery.tpl',
            ]}

            {set $isParentsCategoriesDobor = 'isParentsCategoriesDobor' | snippet}
            {if $linksData.ottenok? && !$isParentsCategoriesDobor && $_modx->resource.context_key in list ['krovelnyjstroymarket']}
              {include "file:blocks/product/linking/linking-select-other-color.tpl"}
            {/if}
            {if $_modx->context.key == 'web'}
              {include "file:chunks/product/rating.tpl"}

              {include 'file:chunks/product/get-ugc-gallery.tpl'}
            {/if}
          </div>

          <div class="product__info-wrap">
            <div class="product__info product-info">

            {* {if $_modx->resource.article && !($isCustomCalculator || $isShtaketnik)}
            <div class="product-info__article article mb-2"> Арт. {$_modx->resource.article} </div>
            {/if} *}
              <div class="product-info__top">
                <div class="product-info__divider">
                  <div class="{if $_modx->context.key == 'web'}width-100{/if}">
                    {if $_modx->context.key !== 'web'}
                      {include "file:chunks/product/rating.tpl"}
                    {/if}
                    {if !($isCustomCalculator || $isShtaketnik)}
                    <div class="product-info__shipped mobile-flex">
                        {'@FILE snippets/shippedToday.php' | snippet}
                    </div>
                    {/if}


                    {if '@FILE snippets/product/isCollerovka.php' | snippet: ['id' => $_modx->resource.id]}
                        <div id="collerovka"></div>
                    {/if}

                    <div class="product-info__relinkav">
                      {if $_modx->context.key in list ['gazosilikatstroy','gazoclone']}
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

                      {* {if $_modx->resource.article && ($isCustomCalculator || $isShtaketnik)}
                        <div class="product-info__article article mb-2"> Арт. {$_modx->resource.article} </div>
                      {/if} *}

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
                        {case 'krovelnyjstroymarket'}
                          {set $randomStock = $_modx->runSnippet('@FILE snippets/random.php', ['begin' => 500, 'end'=> 2000]) }
                          {if $_modx->resource.unit[0] == 'упаковка'}
                            {set $unit = '@FILE snippets/formOfWord.php' | snippet : [
                            'n' => $randomStock,
                            'f1' => 'упаковка',
                            'f2' => 'упаковки',
                            'f5' => 'упаковок'
                            ]}
                          {else}
                            {set $unit = $_modx->resource.unit[0]}
                          {/if}
                        {case default}
                        {set $unit = 'шт'}
                      {/switch}



                      {if $_modx->resource.context_key not in list ['kraska']}
                        {* При чем тут relinkingData ? *}
                        {if $isCustomCalculator}
                          <div class="product-info__availability-title has-icon icon-checkmark pc-flex">
                              Можно посмотреть в нашем&nbsp;<a class="link" href="/shourum/">шоу-руме</a>
                          </div>
                        {/if}
                        {if $_modx->context.key == 'suhiesmesi'}
                        <div class="product-info__availability-title has-icon icon-checkmark pc-flex">
                            Срок доставки: {'' | date : 'd.m.Y'}
                        </div>
                        <div class="product-info__availability-title has-icon icon-checkmark pc-flex">
                            Самовывоз: {'' | date : 'd.m.Y'}
                        </div>
                        {/if}
                        {if $relinkingData is empty}
                          {if $_modx->context.key == 'web'}
                            {include "file:_modules/warehouses/sections/warehouse-remains.tpl"}
                          {else}
                            <div class="product-info__availability-title has-icon icon-checkmark pc-flex">
                                {if $_modx->resource.parent in list $_modx->runSnippet('@FILE snippets/getCategoriesListIds.php', ['parent' => '125530,125537'])}
                                    В наличии металл {$_modx->runSnippet('@FILE snippets/random.php', ['begin' => 2000, 'end'=> 4000])} м<sup>2</sup>
                                  {elseif $_modx->context.key == 'krovelnyjstroymarket'}
                                    {* гибкой черепице упаковки *}
                                    
                                    На складе {$randomStock} {$isGibkaya ? 'уп.' : $unit}
                                  {elseif $_modx->context.key == 'suhiesmesi'}
                                      В наличии {$_modx->runSnippet('@FILE snippets/random.php', ['begin' => 100, 'end'=> 2000])} шт
                                  {else}
                                    На складе {$_modx->runSnippet('@FILE snippets/random.php', ['begin' => 700, 'end'=> 1000])} {$unit}
                                {/if}
                            </div>
                          {/if}

                        {/if}

                        {if $isCustomCalculator || $isShtaketnik}
                          <div class="product-info__prod-time pc-flex has-icon icon-checkmark">
                              Срок изготовления: 2-3 дня
                          </div>
                          <div class="product-info__warranty pc-flex has-icon icon-checkmark">
                              Гарантия на товар: 30 лет
                          </div>
                          {* {if $settingCardKrovlya['width']}
                            <div class="product-info__width pc-flex">
                                Ширина листа: {$settingCardKrovlya['width']} мм
                            </div>
                          {/if} *}
                        {/if}
                      {/if}
                    </div>

                    {if $_modx->resource.context_key not in list ['suhiesmesi','web']}
                      {* При чем тут relinkingData ? *}
                      {if ($relinkingData is not empty) && ($_modx->resource.context_key != 'kraska')}
                        <div class="product-info__avstock">
                            <div class="product-info__availability-title has-icon icon-checkmark pc-flex">
                              На складе {$_modx->resource.stockNum} {$unit}
                            </div>
                            <div class="product-info__shipped pc-flex">
                                {'@FILE snippets/shippedToday.php' | snippet}
                            </div>
                        </div>
                      {else}
                        <div class="product-info__avstock">
                        {if $_modx->resource.context_key == 'kraska'}
                            <div class="product-info__availability-title has-icon icon-checkmark pc-flex">
                            В наличии {$_modx->resource.stockNum} {$unit}
                            </div>
                        {elseif !($isCustomCalculator || $isShtaketnik)}
                          <div class="product-info__shipped pc-flex">
                            {if $_modx->resource.parent in list $_modx->runSnippet('@FILE snippets/getCategoriesListIds.php', ['parent' => '125530,125537,125541,171134,171121'])}
                                Дата производства при заказе сегодня: <span class="bold"> &nbsp; {'+2 days' | date : 'd.m.Y'} </span>
                                {elseif $_modx->context.key == 'krovelnyjstroymarket'}
                                  Дата доставки при заказе сегодня: <span class="bold">&nbsp; {'+1 days' | date : 'd.m.Y'} </span>
                                {else}
                                {'@FILE snippets/shippedToday.php' | snippet}
                            {/if}

                          </div>
                        {/if}
                        </div>
                      {/if}
                    {/if}
                  </div>
                  <div>
                    {* Перемещенный прайс для профлиста и штакетника *}
                    {if $isCustomCalculator || $isShtaketnik}
                    <div class="product-info__price{if $prodValues['outputOldPrice']?} active{/if}">
                      <b>Цена:</b>
                      <p class="product-info__price-value">
                        <span class="js-product__price" data-default="{$prodValues['defaultPrice']}">{$prodValues['outputPrice']}</span> ₽{$unit ? '/'~$unit :''}
                      </p>
                      {if $prodValues['outputOldPrice']?}
                        <div class="js-product__old-price">
                          <span class="js-product__old-price-val" data-default="{$prodValues['defaultOldPrice']}">
                              {$prodValues['outputOldPrice']}
                          </span>
                          ₽{$unit ? '/'~$unit :''}
                        </div>
    
                        <div class="product-info__price-mes">
                            <p class="product-info__price-mes-header">Снижение цены!</p>
                            <p class="product-info__price-mes-body">Мы регулярно снижаем цены на наши товары, чтобы покупка у нас была еще выгоднее!</p>
                            <span class="product-info__price-mes-close"></span>
                        </div>
                      {/if}
                    </div>
                    {/if}
                    {*  *}
                  </div>
                </div>
              </div>

              {if $_modx->resource.context_key == 'web'}
              
                  {set $linksData = '@FILE snippets/getRelinkingData_Thickness.php' | snippet}
                  {$linksData}
                
              {/if}
            
              <div class="product-info__bottom">
                  {* Перелинковка характеристиками *}
                  {include 'file:chunks/product/product-relinking-block.tpl' linksData=$linksData}
                  {* Конец перелинковка характеристиками *}
                {if !$isCustomCalculator && !$isShtaketnik}
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

                      <div class="product-info__price-mes">
                          <p class="product-info__price-mes-header">Снижение цены!</p>
                          <p class="product-info__price-mes-body">Мы регулярно снижаем цены на наши товары, чтобы покупка у нас была еще выгоднее!</p>
                          <span class="product-info__price-mes-close"></span>
                      </div>
                    {/if}
                    </div>
                  </div>
                {/if}
              </div>
                

              <div class="product-info__actions">
                  {*  *}
                  {if $isCustomCalculator and $settingCardKrovlya['width']}
                    {set $skipOneClickButton = true}
                    {include "file:chunks/product/product-elems-double.tpl" prodId=$_modx->resource.id}
                  {else}
                    {include "file:chunks/product/product-elems.tpl" prodId=$_modx->resource.id}
                  {/if}  
                  {*  *}
              </div>
              {if !$skipOneClickButton}
              <button data-fancybox="" href="#callback" class="product-info__fast-buy btn btn_style_trans">Купить в 1 клик</button>
              {/if}

              {if $isShtaketnik && !$isCustomCalculator}
                {include 'file:chunks/product/link-calculator.tpl'}
              {/if}

            </div>
              {if $_modx->resource.context_key in list ["web"]}
                {"@FILE _modules/restrictions/restrictions.php" | snippet}
              {/if}
              {if $_modx->resource.context_key in list ['kraska', 'suhiesmesi']}
                  <div class="product-info__undertext">
                    <p class="product-info__undertext-span">
                      <svg xmlns="http://www.w3.org/2000/svg" version="1.0" class="icon" preserveAspectRatio="xMidYMid meet">
                          <use xlink:href="/assets/template/img/svg-sprite.svg#icon-location-product"></use>
                      </svg>
                      <span class="product-info__undertext-span-header">Самовывоз: </span> сегодня
                    </p>
                    <p class="product-info__undertext-span">
                      <svg xmlns="http://www.w3.org/2000/svg" version="1.0" class="icon" preserveAspectRatio="xMidYMid meet">
                          <use xlink:href="/assets/template/img/svg-sprite.svg#icon-delivery-product"></use>
                      </svg>
                      <span class="product-info__undertext-span-header">Доставка: </span> 1-2 дня
                    </p>
                  </div>
              {/if}
              {if $_modx->resource.context_key in list ['suhiesmesi']}
                  <div style="margin-top: 20px">
                    {include "file:_modules/calculator-opt/chunks/calculator-opt.tpl" product=$_modx->resource}
                  </div>
              {/if}

              {if $isCustomCalculator || $isShtaketnik}
                  <div class="product-info__undertext">
                    <p class="product-info__undertext-span">
                        <svg xmlns="http://www.w3.org/2000/svg" version="1.0" width="16pt" height="16pt" class="icon" viewBox="0 0 512.000000 512.000000" preserveAspectRatio="xMidYMid meet">
                            <use xlink:href="/assets/template/img/svg-sprite.svg#icon-delivery-product"></use>
                        </svg>
                        <span class="product-info__undertext-span-header">Дата производства при заказе сегодня: </span> {'+2 days' | date : 'd.m.Y'}
                    </p>
                  </div>
              {/if}
              {switch $_modx->resource.context_key}
                {case 'gazosilikatstroy'}
                    <p class="product-info__discount"><span class="product-info__discount-start">Скидка</span> 30% на доставку с <span class="product-info__discount-end">разгрузкой</span></p>
                {case 'gazoclone'}
                    <p class="product-info__discount"><span class="product-info__discount-start">Скидка</span> 30% на доставку с <span class="product-info__discount-end">разгрузкой</span></p>
                {case 'krovelnyjstroymarket'}
                    {if !$isCustomCalculator && !$isShtaketnik}
                    <p class="product-info__discount"><span class="product-info__discount-start">Скидка</span> 30% на доставку с <span class="product-info__discount-end">разгрузкой</span></p>
                    {/if}
                {case 'web'}
                    <div class="product-info__discount big"><span class="product-info__discount-start"></span><div><div class="product-info__discount-title">В комплекте дешевле!</div><div class="product-info__discount-text">Заказывайте утеплитель вместе с плитными материалами со скидкой до 30%</div></div></div>
              {/switch}
              </div>

            {* Special osnova *}
            {if $isCustomCalculator}
            <div class="product-info__relinkav product-info mobile-flex">
                <div class="product-info__availability-title has-icon icon-checkmark mobile-flex">
                    Можно посмотреть в нашем&nbsp;<a class="link" href="/shourum/">шоу-руме</a>
                </div>
                <div class="product-info__availability-title has-icon icon-checkmark mobile-flex">
                    На складе {$randomStock} {$isGibkaya ? 'уп.' : $unit}
                </div>
                <div class="product-info__prod-time mobile-flex">
                    Срок изготовления: 2-3 дня
                </div>
                <div class="product-info__warranty mobile-flex">
                    Гарантия на товар: 30 лет
                </div>
            </div>
            {/if}
            {* /Special *}

            {if $isCustomCalculator || $isShtaketnik}
              <div class="blueprint-request">
                <a class="blueprint-request__button" data-fancybox href="#blueprint">
                  <img src="/assets/template/img/icons/blueprint.png" alt="">
                  <p class="blueprint-request__text">
                    <strong>Отправьте чертеж</strong> и получите расчет материалов бесплатно
                   </p>
                </a>
              </div>
            {/if}


           
          </div>
        </div>
      </div>
    </article>