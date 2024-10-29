{extends "file:layouts/default.layout.tpl"}

{block "page"}
<main class="layout__main">
    {include "file:chunks/breadcrumbs/breadcrumbs.tpl"}

    <section class="warehouse-contacts">
      <div class="wrapper">
          <div class="warehouse-contacts__contacts">
              <h2 class="warehouse-contacts__contacts-title">Контакты</h2>
              <ul class="contacts__list">
                  <li class="contacts__item">
                      <div class="contact__title"><span>Часы работы</span></div>
                      <div class="contact__value">
                        Ежедневно с 8:00 до 21:00
                      </div>
                  </li>
                  <li class="contacts__item">
                      <div class="contact__title"><span>Телефон</span></div>
                      <a class="contact__value" href="tel:{$_modx->getPlaceholder('localdata').offices.0.phone}">
                          <span itemprop="telephone">
                              {$_modx->getPlaceholder('localdata').offices.0.phone}, доб. 1
                          </span>
                      </a>
                  </li>
                </ul>
                <div class="warehouse-contacts__controls">
                  <div class="btn btn_size_small btn_style_trans" data-src="#callback" data-fancybox="">РАССЧИТАТЬ СТОИМОСТЬ ДОСТАВКИ</div>
                  <div class="btn btn_style_shadow" data-src="#callback" data-fancybox="">ОСТАВИТЬ ЗАЯВКУ НА САМОВЫВОЗ</div>
                </div>
            </div>
            <div class="warehouse-contacts__photo">
                {if $_modx->resource.mainImage}
                    <img alt="{$_modx->resource.pagetitle}" src="{$_modx->resource.mainImage}">
                {/if}   
            </div>
        </div>
    </section>

  </main>

{/block}
