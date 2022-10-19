{set $utm_city = '!utm' | snippet : ['val' => 'city']}

<section class="contacts">
    <div class="wrapper">
        <div class="contacts__left{if $utm_city['icase'] ?} contacts__left_width_full{/if}" itemscope itemtype="http://schema.org/LocalBusiness">
            <h1 class="title-1 title-1_align_left">Контакты</h1>

            {* >>> meta *}
            <meta itemprop="name" content="Комплексная поставка строительных материалов {$brand}">
            <meta itemprop="priceRange" content="От 250 RUB">
            <meta itemprop="image" content="/assets/template/img/favicons/{$site_context}/favicon.ico">
            <time itemprop="openingHours" datetime="Mo-Su 08:00−21:00">
            {* <<< meta *}

            <ul class="contacts__list">
                <li class="contacts__item">
                    <div class="contacts__item-key"><span>Отдел продаж</span></div>
                    <a class="contacts__item-value" href="tel:{'phone' | option}">
                        <span itemprop="telephone">{'phone' | option}</span>
                    </a>
                </li>
                <li class="contacts__item">
                    <div class="contacts__item-key"><span>Приём заявок</span></div>
                    <div class="contacts__item-value">Ежедневно с 08:00-21:00</div>
                </li>
                <li class="contacts__item">
                    <div class="contacts__item-key"><span>Работа офиса</span></div>
                    <div class="contacts__item-value">Пн-пт с 08:00 - 21:00</div>
                </li>
                <li class="contacts__item">
                    <div class="contacts__item-key"><span>E-mail для заявок</span></div>
                    <a class="contacts__item-value" href="mailto:{'email' | option}">
                        <span itemprop="email">{'email' | option}</span>
                    </a>
                </li>
                <li class="contacts__item contacts__item_content_address" itemprop="address" itemscope itemtype="http://schema.org/PostalAddress">
                    <div class="contacts__item-key"><span>Адрес</span></div>

                    <select class="contacts__select-address select-address" name="select-address">
                      <option value="1">Мурино, Кооперативная 20б</option>
                      <option value="2">{'address' | option}</option>
                    </select>
                </li>
            </ul>
            <div class="contacts__left-bottom">
                {*
                <div class="contacts__social">
                    <div class="contacts__social-title">Мы в соц. сетях</div>
                    <div class="contacts__social-list">
                        {include "file:elements/social-list.tpl"}
                    </div>
                </div>
                *}
                <span class="contacts__callback custom-btn" data-src="#callback" data-fancybox="">ЗАДАТЬ ВОПРОС</span>
            </div>
        </div>
        {if $utm_city['icase'] is empty}
            <div class="contacts__map">
                <div class="map__container">
                    <script type="text/javascript" charset="utf-8" async src="https://api-maps.yandex.ru/services/constructor/1.0/js/?um={'yandex_map_contacts' | get_option}&amp;width=100%25&amp;height=400&amp;lang=ru_RU&amp;scroll=true"></script>
                </div>
            </div>
        {/if}
    </div>
</section>
