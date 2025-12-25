<!-- {set $items = [
    ['title' => 'Низкая цена', 'icon' => 'about-wallet', 'text' => 'Наши цены выгодны благодаря нашему процессу производства, обеспечивающему отличное качество и экономическую эффективность без наценок'],  
    ['title' => 'Сертифицированные товары', 'icon' => 'about-group', 'text' => 'Наши изделия производятся в соответствии со всеми документами и стандартами качества.'],
    ['title' => 'Обширный ассортимент', 'icon' => 'about-warehouse', 'text' => 'Мы предлагаем широкий выбор товаров под все ваши нужды.'],
    ['title' => 'Удобные формы заказа', 'icon' => 'about-cellphone', 'text' => 'Вы можете позвонить нам или оставить заявку на сайте, и мы сами свяжемся с Вами в удобное для Вас время.'],
    ['title' => 'Быстрая доставка', 'icon' => 'about-cart', 'text' => 'Мы осуществляем своевременную доставку товаров прямо к вашему объекту.']
]} -->

<div class="company-profit">
  <div class="container">
    <h2 class="section-title">Какие выгоды вы получите, обратившись к нам</h2>
    <div class="company-profit__row">
      {foreach $items as $item}
      <div class="company-profit__item">
        <div class="company-profit__item-icon">
          <svg fill="url(#svg-gradient)">
            <use
              xlink:href="/assets/template/images/icons.svg?v4#{$item['icon']}"
            ></use>
          </svg>
        </div>
        <div class="company-profit__item-content">
          <div class="company-profit__item-title">{$item['title']}</div>
          <div class="company-profit__item-text">{$item['text']}</div>
        </div>
      </div>
      {/foreach}
    </div>
  </div>
</div>
