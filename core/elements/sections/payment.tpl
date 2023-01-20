<section class="payment">
    <div class="wrapper">
        <h2 class="title-2 payment__title">Способы оплаты</h2>
        <div class="payment__list" data-dropdown="">
            <div class="payment__item">
                <div class="payment__item-top">
                    <svg class="svg icon-card" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-card"></use>
                    </svg><span>Банковская карта</span>
                    <svg class="svg icon-arrow" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-arrow"></use>
                    </svg>
                </div>
                <div class="payment__item-content"><b>Оплата банковской картой, через Интернет, возможна через системы электронных платежей.</b>
                    <p>Минимальная сумма платежа — 1 рубль.
                        <br>Максимальная сумма платежа отсутствует.</p>
                    <p>Номер карты (PAN) должен иметь не менее 15 и не более 19 символов</p><b>Мы принимаем платежи с сайта по следующим банковским картам   </b>
                    <div class="payment__item-list">
                        <img src="{$_modx->config['template_path']}img/payment/payment1.png" alt="Платежная система МИР">
                        <img src="{$_modx->config['template_path']}img/payment/payment2.png" alt="Платежная система Виза">
                        <img src="{$_modx->config['template_path']}img/payment/payment3.png" alt="Платежная система Виза Электрон">
                        <img src="{$_modx->config['template_path']}img/payment/payment4.png" alt="Платёжная система Маэстро">
                        <img src="{$_modx->config['template_path']}img/payment/payment5.png" alt="Платежная система Мастер Кард">
                    </div>
                </div>
            </div>
            <div class="payment__item">
                <div class="payment__item-top">
                    <svg class="svg icon-card" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-money"></use>
                    </svg><span>Наличный расчёт</span>
                    <svg class="svg icon-arrow" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-arrow"></use>
                    </svg>
                </div>
                <div class="payment__item-content">
                    <p>Вы можете оплатить наличными по факту приема материала после проверки качества и количества заказанного материала.</p>
                </div>
            </div>
            <div class="payment__item">
                <div class="payment__item-top">
                    <svg width="30" height="30" class="svg icon-card" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-bank"></use>
                    </svg><span>Безналичный расчёт</span>
                    <svg class="svg icon-arrow" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-arrow"></use>
                    </svg>
                </div>
                <div class="payment__item-content">
                    <p>Менеджер отправит Вам счет, Вы проверяете номенклатуру товара, количество. После оплаты осуществляется доставка либо Вы забираете товар со склада самовывоза.</p>
                </div>
            </div>
            {*
                <div class="payment__item">
                <div class="payment__item-top">
                    <svg class="svg icon-money" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-money"></use>
                    </svg><span>Наличные</span>
                    <svg class="svg icon-arrow" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-arrow"></use>
                    </svg>
                </div>
                <div class="payment__item-content"><b>Оплата банковской картой, через Интернет, возможна через системы электронных платежей.</b>
                    <p>Минимальная сумма платежа — 1 рубль.
                        <br>Максимальная сумма платежа отсутствует.</p>
                    <p>Номер карты (PAN) должен иметь не менее 15 и не более 19 символов</p><b>Мы принимаем платежи с сайта по следующим банковским картам   </b>
                    <div class="payment__item-list">
                        <img src="{$_modx->config['template_path']}img/payment/payment1.png" alt="">
                        <img src="{$_modx->config['template_path']}img/payment/payment2.png" alt="">
                        <img src="{$_modx->config['template_path']}img/payment/payment3.png" alt="">
                        <img src="{$_modx->config['template_path']}img/payment/payment4.png" alt="">
                        <img src="{$_modx->config['template_path']}img/payment/payment5.png" alt="">
                    </div>
                </div>
            </div>
            *}
        </div>
    </div>
</section>
