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
                <li class="contacts__item fadeInUp">
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
{*                <iframe src="https://yandex.ru/map-widget/v1/?um=constructor%3A7b962d475832f8eeb3502be6df583bbdf63046c41237e6229a6e429c17422f99&amp;source=constructor" width="100%" height="100%" frameborder="0"></iframe>*}
                <iframe src="https://yandex.ru/map-widget/v1/?um=constructor%3Abbc537928a1c518013122135ec7411a0ad13bb72fec1b8404cd82e92876a5779&amp;source=constructor" width="100%" height="400" frameborder="0"></iframe>
            </div>
        </div>
    </div>
</section>
