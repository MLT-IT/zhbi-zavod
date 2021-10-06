<section class="contacts">
    <div class="wrapper">
        <div class="contacts__left">
            <h1 class="title-1 contacts__title">Контакты</h1>
            <ul class="contacts__list">
                <li class="contacts__item fadeInUp">
                    <div class="contacts__item-key"><span>Отдел продаж</span></div><a class="contacts__item-value" href="tel:{'phone' | option}">{'phone' | option}</a>
                </li>
                <li class="contacts__item fadeInUp">
                    <div class="contacts__item-key"><span>Приём заявок</span></div>
                    <div class="contacts__item-value">Ежедневно с 08:00-21:00</div>
                </li>
                <li class="contacts__item fadeInUp">
                    <div class="contacts__item-key"><span>Работа офиса</span></div>
                    <div class="contacts__item-value">Пн-пт с 08:00 - 21:00</div>
                </li>
                <li class="contacts__item fadeInUp">
                    <div class="contacts__item-key"><span>E-mail для заявок</span></div><a class="contacts__item-value" href="mailto:{'mail_1' | option}">{'mail_1' | option}</a>
                </li>
                <li class="contacts__item contacts__item_content_address fadeInUp">
                    <div class="contacts__item-key"><span>Адрес</span></div>
                    <div class="contacts__item-value">{'address' | option}</div>
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
            <div class="map__container fadeInUp">
                <script type="text/javascript" charset="utf-8" async src="https://api-maps.yandex.ru/services/constructor/1.0/js/?um=constructor%3Abfd296294102bdce3e6b7d6aa53834630ca08e070f70374c9375fe45b57664ba&amp;width=100%25&amp;height=400&amp;lang=ru_RU&amp;scroll=true"></script>
            </div>
        </div>
    </div>
</section>
