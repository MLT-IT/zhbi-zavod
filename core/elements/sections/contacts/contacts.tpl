<section class="contacts">
    <div class="wrapper">
        <div class="contacts__left" itemscope itemtype="http://schema.org/LocalBusiness">
            <h1 class="title-1 contacts__title">Контакты</h1>

            {* >>> meta *}
            <meta itemprop="name" content="Комплексная поставка строительных материалов {$brand}">
            <meta itemprop="priceRange" content="От 250 RUB">
            <meta itemprop="image" content="/assets/template/img/favicons/{$site_context}/favicon.ico">
            <time itemprop="openingHours" datetime="Mo-Su 08:00−21:00">
            {* <<< meta *}

            <ul class="contacts__list">
                <li class="contacts__item">
                    <div class="contacts__item-key"><span>Отдел продаж</span></div>
                    <a class="contacts__item-value" href="tel:{$_pls['+phone']}">
                        <span itemprop="telephone">{$_pls['+phone']}</span>
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
                    <a class="contacts__item-value" href="mailto:{$_pls['+email']}">
                        <span itemprop="email">{$_pls['+email']}</span>
                    </a>
                </li>
                <li class="contacts__item contacts__item_content_address" itemprop="address" itemscope itemtype="http://schema.org/PostalAddress">
                    <div class="contacts__item-key"><span>Адрес</span></div>
                    <div class="contacts__item-value" itemprop="streetAddress">{'address' | option}</div>
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
                <a class="contacts__callback yellow-btn" href="#callback" data-fancybox="">ЗАДАТЬ ВОПРОС</a>
            </div>
        </div>
        <div class="contacts__map">
            <div class="map__container">
                <script type="text/javascript" charset="utf-8" async src="https://api-maps.yandex.ru/services/constructor/1.0/js/?um=constructor%3Abfd296294102bdce3e6b7d6aa53834630ca08e070f70374c9375fe45b57664ba&amp;width=100%25&amp;height=400&amp;lang=ru_RU&amp;scroll=true"></script>
            </div>
        </div>
    </div>
</section>
