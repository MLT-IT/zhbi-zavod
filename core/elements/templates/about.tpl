{extends "file:layouts/default.layout.tpl"}

{block "page"}
  {include "file:chunks/svg-gradient.tpl" w=48 h=48}

  <main class="layout__main">
    {include "file:chunks/breadcrumbs/breadcrumbs.tpl"}

    <article class="inner section">
      <div class="inner__container">
        <h2 class="margin-bottom-md section__title">{$_modx->resource.pagetitle}</h2>
        <div class="content">
            {$_modx->resource.content}
        </div>
      </div>
    </article>

    <section class="about">
      <div class="about__container">

        <section class="wrapper section sect-segment">
          <h2 class="section__title margin-bottom-md">За нашими товарами обращаются</h2>
          <ul class="sect-segment__items-wrap">
            <li class="sect-segment__item">
              <div class="sect-segment__item-svg-wrap">
                <svg fill="url(#svg-gradient)" class="svg sect-segment__item-svg" xmlns="http://www.w3.org/2000/svg"
                     xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                  <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#about-group"></use>
                </svg>
              </div>
              Частные застройщики
            </li>
            <li class="sect-segment__item">
              <div class="sect-segment__item-svg-wrap">
                <svg fill="url(#svg-gradient)" class="svg sect-segment__item-svg" xmlns="http://www.w3.org/2000/svg"
                     xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                  <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#about-plant"></use>
                </svg>
              </div>
              Промышленные предприятия
            </li>
            <li class="sect-segment__item">
              <div class="sect-segment__item-svg-wrap">
                <svg fill="url(#svg-gradient)" class="svg sect-segment__item-svg" xmlns="http://www.w3.org/2000/svg"
                     xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                  <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#about-building"></use>
                </svg>
              </div>
              Крупные строительные холдинги
            </li>
          </ul>
        </section>

        <section class="wrapper sect-benefits">
          <h2 class="section__title margin-bottom-md">Какие выгоды вы получите, обратившись к нам</h2>
          <ul class="sect-benefits__items-wrap">
            <li class="sect-benefits__item">
              <div class="sect-benefits__item-svg-wrap">
                <svg fill="url(#svg-gradient)" class="svg sect-benefits__item-svg"
                     xmlns="http://www.w3.org/2000/svg"
                     xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="28" height="36">
                  <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#about-wallet"></use>
                </svg>
              </div>
              <div class="sect-benefits__item-content">
                <p class="sect-benefits__item-title">Низкая цена</p>
                <p class="sect-benefits__item-text">
                  Наши цены выгодны благодаря нашему процессу производства, обеспечивающему отличное качество и экономическую эффективность без наценок.
                </p>
              </div>
            </li>
            <li class="sect-benefits__item">
              <div class="sect-benefits__item-svg-wrap">
                <svg fill="url(#svg-gradient)" class="svg sect-benefits__item-svg"
                     xmlns="http://www.w3.org/2000/svg"
                     xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="44" height="32">
                  <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#about-cert"></use>
                </svg>
              </div>
              <div class="sect-benefits__item-content">
                <p class="sect-benefits__item-title">Сертифицированные товары</p>
                <p class="sect-benefits__item-text">
                  Наши изделия производятся в соответствии со всеми документами и стандартами качества.
                </p>
              </div>
            </li>
            <li class="sect-benefits__item">
              <div class="sect-benefits__item-svg-wrap">
                <svg fill="url(#svg-gradient)" class="svg sect-benefits__item-svg"
                     xmlns="http://www.w3.org/2000/svg"
                     xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="40" height="40">
                  <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#about-warehouse"></use>
                </svg>
              </div>
              <div class="sect-benefits__item-content">
                <p class="sect-benefits__item-title">Обширный ассортимент</p>
                <p class="sect-benefits__item-text">
                  Мы предлагаем широкий выбор товаров под все ваши нужды.
                </p>
              </div>
            </li>
            <li class="sect-benefits__item">
              <div class="sect-benefits__item-svg-wrap">
                <svg fill="url(#svg-gradient)" class="svg sect-benefits__item-svg"
                     xmlns="http://www.w3.org/2000/svg"
                     xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="36" height="38">
                  <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#about-cellphone"></use>
                </svg>
              </div>
              <div class="sect-benefits__item-content">
                <p class="sect-benefits__item-title">Удобные формы заказа</p>
                <p class="sect-benefits__item-text">
                  Вы можете позвонить нам или оставить заявку на сайте, и мы сами свяжемся с Вами в удобное для Вас время.
                </p>
              </div>
            </li>
            <li class="sect-benefits__item">
              <div class="sect-benefits__item-svg-wrap">
                <svg fill="url(#svg-gradient)" class="svg sect-benefits__item-svg"
                     xmlns="http://www.w3.org/2000/svg"
                     xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="36" height="38">
                  <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#about-cart"></use>
                </svg>
              </div>
              <div class="sect-benefits__item-content">
                <p class="sect-benefits__item-title">Быстрая доставка</p>
                <p class="sect-benefits__item-text">
                  Мы осуществляем своевременную доставку товаров прямо к вашему объекту.
                </p>
              </div>
            </li>
          </ul>
        </section>

      </div>
    </section>

  </main>

{/block}
