{extends "file:layouts/default.layout.tpl"}

{block 'schema'}
    {include "file:blocks/catalog-schema.tpl"}
{/block}

{block "page"}

  <main class="layout__main">
    <section class="section section_view_top">
      {include "file:blocks/breadcrumbs.tpl"}
      <article class="catalog-screen">
        <div class="catalog-screen__container">
          <h2 class="catalog-screen__title section__title">{$_modx->resource.pagetitle ?: $_modx->resource.menutitle}</h2>
          <div class="catalog-screen__text">
            {$_modx->resource.content}
          </div>

          {* --- ^ Подкатегории --------------------- *}
          {set $categories = 'pdoResources' | snippet : [
            'depth' => 9000,
            'limit' => 0,
            'where' => '{"template:=":"5"}',
            'tpl' => '@FILE chunks/categoryItem.tpl',
            'includeTVs' => 'mainImage',
            'outputSeparator' => '||'
          ] | split : '||'}
          {set $count = $categories | count}
          {set $maxIndex = $count > 5 ? 5 : $count}

          {if $count > 0}
            <div class="catalog-screen__products" data-dropdown="responsive" data-dropdown-title=".catalog-screen__item_more" data-dropdown-body=".catalog-screen__other" data-disable-close="">
              <ul class="catalog-screen__items">
                {foreach 0..($maxIndex-1) as $index}
                  {$categories[$index]}
                {/foreach}

                {if $count > 5}
                  <li class="catalog-screen__item catalog-screen__item_more"></li>
                {/if}
              </ul>
              {* Если подкатегорий > 5, то прячем оставшиеся под споилер *}
              {if $count > 5}
                <div class="catalog-screen__other">
                  <ul class="catalog-screen__items">
                    {foreach 5..$count as $index}
                        {$categories[$index]}
                    {/foreach}
                  </ul>
                </div>
              {/if}
            </div>
          {/if}
          {* --- $ Подкатегории --------------------- *}

        </div>
      </article>
    </section>


    {* --- ^ Листинг товаров --------------------- *}
    {'!mFilter2' | snippet : [
      'element' => 'msProductsMy',
      'suggestionsMaxFilters' => 2000,
      'suggestionsMaxResults' => 100000,
      'filters' => $_modx->resource.listFilters ?: "",

      'tpls' => "@FILE sections/category/listing-products-item.tpl",
      'tplOuter' => '@FILE sections/listing.tpl',
      'tplFilter.outer.default' => '@FILE chunks/filter.tpl',
      'ajaxMode' => 'button',
      'showEmptyFilters' => 1,
      'limit' => 42,

      'tplFilter.row.default' => '@FILE chunks/mainListFilter.tpl',

      'aliases' => 'ms|price==price',
      'sort' => 'tv|priority1:asc,tv|HitsPage:asc',
      'includeTVs' => 'priority1,HitsPage,isFractional,productNotAvailable,freeShipping',

      'values_delimeter' => '~',
      'context' => $_modx->resource.context_key,

      'optionFilters' => $_modx->getPlaceholder('mspcs.option'),
      'where' => $_modx->getPlaceholder('mspcs.where'),

      'setMeta' => 0,
      'parents' => $_modx->resource.itemsParents,
      'totalVar' => 'total'
    ]}
    {* --- $ Листинг товаров --------------------- *}






    <article class="content-block section" data-dropdown="responsive" data-dropdown-title=".content-block__toggler" data-dropdown-body=".content-block__dropdown" data-disable-close="">
      <div class="content-block__container">
        <h2 class="content-block__title section__title">Купить газобетонные блоки в СПб</h2>
        <div class="content-block__preview">
          <p class="content-block__preview-text">Монолит – мультиканальный и омниканальный дистрибьютор строительных и отделочных материалов на территории РФ. В нашем интернет-магазине представлено свыше 50 000 строительных материалов от более чем 150 популярных брендов из России и Европы.Более чем за 10 лет работы более 15 000 клиентов убедились в качестве сервиса и стали нашими постоянными покупателями.</p><a class="content-block__toggler" href="#"></a>
        </div>
        <div class="content-block__dropdown">
          <div class="content-block__body">
            <h3>Основные требования к современной теплоизоляции</h3>
            <p>Качественная теплоизоляция должна максимально снижать тепловую передачу, обеспечивая сохранение комфортных температурных показателей внутри помещений. В зависимости от специфики объекта утепляться могут внутренние и наружные стены, перекрытия, мансарды, пол, кровля и другие конструкционные части зданий.</p>
            <p>Несмотря на все разнообразие теплоизоляционных материалов, к ним выдвигаются стандартные требования. Они касаются таких показателей, как:</p><img src="assets/template/pictures/content/content-1.jpg" alt="content">
            <p>Несмотря на все разнообразие теплоизоляционных материалов, к ним выдвигаются стандартные требования. Они касаются таких показателей, как:</p>
            <ul>
              <li>Низкая теплопроводность;</li>
              <li>Простота монтажа;</li>
              <li>Паропроницаемость;</li>
              <li>Влагостойкость;</li>
              <li>Пожарная безопасность;</li>
              <li>Лёгкость;</li>
              <li>Безопасность для человека;</li>
              <li>Удобство транспортировки;</li>
              <li>Долговечность.</li>
            </ul>
            <blockquote>
              <p>Соотношение этих характеристик может быть разным, что в немалой степени определяет стоимость материалов для теплоизоляции.</p>
            </blockquote>
            <h3>Виды утеплителей и их применение</h3>
            <p>На современном рынке предложен широкий выбор материалов для наружного и внутреннего утепления домов. Для стен зданий со стороны улицы может использоваться:</p>
            <ul>
              <li>Низкая теплопроводность;</li>
              <li>Простота монтажа;</li>
              <li>Паропроницаемость;</li>
              <li>Влагостойкость;</li>
              <li>Пожарная безопасность;</li>
              <li>Лёгкость;</li>
              <li>Безопасность для человека;</li>
              <li>Удобство транспортировки;</li>
              <li>Долговечность.</li>
            </ul><img src="assets/template/pictures/content/content-2.jpg" alt="content">
            <p>Качественная теплоизоляция должна максимально снижать тепловую передачу, обеспечивая сохранение комфортных температурных показателей внутри помещений. В зависимости от специфики объекта утепляться могут внутренние и наружные стены, перекрытия, мансарды, пол, кровля и другие конструкционные части зданий.</p>
            <p>Несмотря на все разнообразие теплоизоляционных материалов, к ним выдвигаются стандартные требования. Они касаются таких показателей, как:</p>
          </div>
        </div>
      </div>
    </article>
    <article class="infoblocks section section_view_bg infoblocks_style_shadow">
      <div class="infoblocks__container">
        <div class="infoblocks__content">
          <h3 class="infoblocks__title section__title">Условия доставки материала</h3>
          <p class="infoblocks__subtitle">Доставка стройматериалов по Санкт-Петербургу осуществляется по следующему тарифу:</p>
          <div class="table table_style_shadow">
            <table class="table__table">
              <tbody>
              <tr class="table__row">
                <td class="table__cell">Боротовик 1,5 т.</td>
                <td class="table__cell">14 м3</td>
                <td class="table__cell">1 000 Ꝑ</td>
              </tr>
              <tr class="table__row">
                <td class="table__cell">Боротовик 1,5 т.</td>
                <td class="table__cell">14 м3</td>
                <td class="table__cell">1 000 Ꝑ</td>
              </tr>
              <tr class="table__row">
                <td class="table__cell">Боротовик 1,5 т.</td>
                <td class="table__cell">14 м3</td>
                <td class="table__cell">1 000 Ꝑ</td>
              </tr>
              <tr class="table__row">
                <td class="table__cell">Боротовик 1,5 т.</td>
                <td class="table__cell">14 м3</td>
                <td class="table__cell">1 000 Ꝑ</td>
              </tr>
              <tr class="table__row">
                <td class="table__cell">Боротовик 1,5 т.</td>
                <td class="table__cell">14 м3</td>
                <td class="table__cell">1 000 Ꝑ</td>
              </tr>
              <tr class="table__row">
                <td class="table__cell">Боротовик 1,5 т.</td>
                <td class="table__cell">14 м3</td>
                <td class="table__cell">1 000 Ꝑ</td>
              </tr>
              <tr class="table__row">
                <td class="table__cell">Боротовик 1,5 т.</td>
                <td class="table__cell">14 м3</td>
                <td class="table__cell">1 000 Ꝑ</td>
              </tr>
              <tr class="table__row">
                <td class="table__cell">Боротовик 1,5 т.</td>
                <td class="table__cell">14 м3</td>
                <td class="table__cell">1 000 Ꝑ</td>
              </tr>
              <tr class="table__row">
                <td class="table__cell">Боротовик 1,5 т.</td>
                <td class="table__cell">14 м3</td>
                <td class="table__cell">1 000 Ꝑ</td>
              </tr>
              <tr class="table__row">
                <td class="table__cell">Боротовик 1,5 т.</td>
                <td class="table__cell">14 м3</td>
                <td class="table__cell">1 000 Ꝑ</td>
              </tr>
              </tbody>
            </table>
          </div>
        </div>
        <div class="infoblocks__advantages">
          <div class="infoblocks__advantage">
            <div class="advantage">
              <div class="advantage__icon"><img class="advantage__icon-image" src="assets/template/pictures/advantages/advantage-5.png" alt="advantage"></div>
              <p class="advantage__title">Гарантия качества</p>
              <p class="advantage__text">Заменим дефектный материал или вернём деньги</p><a class="advantage__link link" href="#">Условия возврата</a>
            </div>
          </div>
          <div class="infoblocks__advantage">
            <div class="advantage">
              <div class="advantage__icon"><img class="advantage__icon-image" src="assets/template/pictures/advantages/advantage-6.png" alt="advantage"></div>
              <p class="advantage__title">Доставка и самовывоз</p>
              <p class="advantage__text">Вы можете заказать доставку по России (ПЭК, СДЭК, Энергия, Возовоз и Деловые линии) или оформить самовывоз с нашего склада в Санкт-Петербурге</p><a class="advantage__link link" href="#">Условия доставки и самовывоза</a>
            </div>
          </div>
          <div class="infoblocks__advantage">
            <div class="advantage">
              <div class="advantage__icon"><img class="advantage__icon-image" src="assets/template/pictures/advantages/advantage-7.png" alt="advantage"></div>
              <p class="advantage__title">Оптово и розничная продажа</p>
              <p class="advantage__text">Мы продаём товары как в розницу, так и оптом. В зависимости от объёмов заказа мы предоставляем клиентам персональные скидки</p>
            </div>
          </div>
        </div>
        <div class="infoblocks__bottom"><a class="btn btn_style_shadow" href="#">заказать с доставкой</a></div>
      </div>
    </article>
    <section class="advantages-section section">
      <div class="advantages-section__container">
        <h2 class="advantages-section__title section__title">Выберете удобный способ оплаты</h2>
        <div class="advantages section">
          <div class="advantages__item advantage">
            <div class="advantage__icon"><img class="advantage__icon-image" src="assets/template/pictures/payment/payment-1.svg" alt="payment"></div>
            <p class="advantage__text">Оплата банковской картой</p>
          </div>
          <div class="advantages__item advantage">
            <div class="advantage__icon"><img class="advantage__icon-image" src="assets/template/pictures/payment/payment-2.svg" alt="payment"></div>
            <p class="advantage__text">Наличными на объекте</p>
          </div>
          <div class="advantages__item advantage">
            <div class="advantage__icon"><img class="advantage__icon-image" src="assets/template/pictures/payment/payment-3.svg" alt="payment"></div>
            <p class="advantage__text">Безналичный расчёт</p>
          </div>
        </div>
      </div>
    </section>
    <article class="contacts section section_view_bg">
      <div class="contacts__container" data-tabs="">
        <div class="contacts__top">
          <h2 class="contacts__title section__title">Адреса</h2>
          <div class="tabs">
            <ul class="tabs__list">
              <li class="tabs__item active" data-tab="склады">склады</li>
              <li class="tabs__item" data-tab="офис">офис</li>
            </ul>
          </div>
        </div>
        <div class="contacts__body">
          <div class="contacts__block active" data-tab-page="склады">
            <div class="contacts__info">
              <p class="contacts__text contacts__text_bold">Режим работы складов: 8:00 - 21:00</p>
              <address class="contacts__items">
                <div class="contact">
                  <svg class="contact__icon" aria-hidden="true">
                    <use xlink:href="assets/template/pictures/icons.svg#svg-phone"></use>
                  </svg>
                  <div class="contact__content">
                    <p class="contact__title">Телефон склада в Мурино:</p>
                    <p class="contact__value">+7 (812) 220-17-90, доб 3</p>
                  </div><a class="contact__link" href="tel:+78122201790"></a>
                </div>
                <div class="contact">
                  <svg class="contact__icon" aria-hidden="true">
                    <use xlink:href="assets/template/pictures/icons.svg#svg-phone"></use>
                  </svg>
                  <div class="contact__content">
                    <p class="contact__title">Телефон склада в Мурино:</p>
                    <p class="contact__value">+7 (812) 220-17-90, доб 3</p>
                  </div><a class="contact__link" href="tel:+78122201790"></a>
                </div>
                <div class="contact">
                  <svg class="contact__icon" aria-hidden="true">
                    <use xlink:href="assets/template/pictures/icons.svg#svg-phone"></use>
                  </svg>
                  <div class="contact__content">
                    <p class="contact__title">Телефон склада в Мурино:</p>
                    <p class="contact__value">+7 (812) 220-17-90, доб 3</p>
                  </div><a class="contact__link" href="tel:+78122201790"></a>
                </div>
              </address><a class="contacts__availability btn btn_style_base" data-fancybox="" href="#availability">Узнать наличие материала на ближайшем складе</a>
            </div>
            <div class="contacts__map"><iframe src="https://yandex.ru/map-widget/v1/?lang=ru_RU&amp;scroll=true&amp;um=constructor%3A9897d4d519ac0b96d53c1fe1657bd5a4f472e778fd55528a39aa276dbb7ce75e" frameborder="0" allowfullscreen="true" width="835px" height="450px" style="display: block;"></iframe></div>
          </div>
          <div class="contacts__block" data-tab-page="офис">
            <div class="contacts__info">
              <p class="contacts__text contacts__text_bold">Режим работы складов: 8:00 - 21:00</p>
              <address class="contacts__items">
                <div class="contact">
                  <svg class="contact__icon" aria-hidden="true">
                    <use xlink:href="assets/template/pictures/icons.svg#svg-location"></use>
                  </svg>
                  <div class="contact__content">
                    <p class="contact__title">Офис:</p>
                    <p class="contact__value">Мурино, Кооперативная 20Б</p>
                  </div>
                </div>
                <div class="contact">
                  <svg class="contact__icon" aria-hidden="true">
                    <use xlink:href="assets/template/pictures/icons.svg#svg-calendar"></use>
                  </svg>
                  <div class="contact__content">
                    <p class="contact__title">График работы офиса:</p>
                    <p class="contact__value">9:00 - 20:00</p>
                  </div>
                </div>
                <div class="contact">
                  <svg class="contact__icon" aria-hidden="true">
                    <use xlink:href="assets/template/pictures/icons.svg#svg-phone"></use>
                  </svg>
                  <div class="contact__content">
                    <p class="contact__title">Номер телефона контактного центра:</p>
                    <p class="contact__value">+7 (812) 220-17-90, доб 2</p>
                  </div><a class="contact__link" href="tel:+78122201790"></a>
                </div>
                <div class="contact">
                  <svg class="contact__icon" aria-hidden="true">
                    <use xlink:href="assets/template/pictures/icons.svg#svg-email"></use>
                  </svg>
                  <div class="contact__content">
                    <p class="contact__title">Почта для связи:</p>
                    <p class="contact__value">zakaz@www-gazobeton.ru</p>
                  </div><a class="contact__link" href="mailto::zakaz@www-gazobeton.ru"></a>
                </div>
              </address><a class="contacts__availability btn btn_style_base" data-fancybox="" href="#availability">Узнать наличие материала на ближайшем складе</a>
            </div>
            <div class="contacts__map"><iframe src="https://yandex.ru/map-widget/v1/?lang=ru_RU&amp;scroll=true&amp;um=constructor%3A9897d4d519ac0b96d53c1fe1657bd5a4f472e778fd55528a39aa276dbb7ce75e" frameborder="0" allowfullscreen="true" width="835px" height="450px" style="display: block;"></iframe></div>
          </div>
        </div>
      </div>
    </article>
  </main>













    <div class="wrapper">
        {include "file:blocks/breadcrumbs.tpl"}
    </div>
    <div class="wrapper">
        <h1 class="title-1 category-header asfs">
            {$_modx->resource.pagetitle}
        </h1>
        {if $_modx->resource.content | length > 0}
          <article class="content-block">
              {$_modx->resource.content}
          </article>
        {/if}
    </div>
{/block}
