<div class="infoblocks__advantages">

{if $_modx->context.key == 'trotuarnaya-plitka'}
{set $items = [
  [
  "image" => "assets/template/pictures/advantages/advantage-plit-1.png",
  "title" => "Тротуарная плитка всегда на складе",
  "text" => "Всегда храним на складе более 4000 м2 тротуарной плитки.<br>Максимальная загрузка производства 500 м2 в день."
  ],  
  [
  "image" => "assets/template/pictures/advantages/advantage-plit-2.png",
  "title" => "Бесплатный расчет материала",
  "text" => "Наши менеджеры помогут Вам с выбором материала и бесплатно произведут расчёт всего заказа"
  ], 
  [
  "image" => "assets/template/pictures/advantages/advantage-plit-3.png",
  "title" => "Гарантия от производителя",
  "text" => "Осуществляем замену дефектного материала со всеми издержками или возврат полной суммы заказа в течении 5 лет с момента заказа"
  ], 
]}
{foreach $items as $item}
<div class="infoblocks__advantage">
  <div class="advantage">
    <div class="advantage__icon">
      <img class="advantage__icon-image" src="{$item['image']}"/>
    </div>
    <p class="advantage__title">{$item['title']}</p>
    <p class="advantage__text">{$item['text']}</p>
  </div>
</div>
{/foreach}
{else}
{if $_modx->resource.proizvoditel.0 && $_modx->resource.context_key in list ["kraska"]}
  <div class="infoblocks__vendor">
    <div class="vendor-infoblock">
      <div class="vendor-infoblock__icon" data-val="{$_modx->resource.proizvoditel.0}"></div>
      <p class="vendor-infoblock__title"><a href="/catalog/?msoption|proizvoditel={$_modx->resource.proizvoditel.0}">{$_modx->resource.proizvoditel.0}</a></p>
    </div>
  </div>
{/if}

  {if $_modx->resource.proizvoditel.0 && $_modx->resource.context_key in list ["suhiesmesi"]}
    <div class="infoblocks__advantage">
      <div class="advantage">
        <div class="advantage__icon"><img class="advantage__icon-image" src="assets/template/advantages/advantage-9.png"></div>
        <p class="advantage__title">Широкий ассортимент</p>
        <p class="advantage__text">Подберем смесь под любую задачу — от отделки до крупных объектов</p></div>
    </div>
  {/if}

  {if $_modx->resource.context_key not in list ["tagnerud"]}
  <div class="infoblocks__advantage">
    <div class="advantage">
      <div class="advantage__icon"><img class="advantage__icon-image" src="assets/template/pictures/advantages/advantage-5.png"></div>
      <p class="advantage__title">Гарантия качества</p>
      <p class="advantage__text">Заменим дефектный материал или вернём деньги</p><a class="advantage__link link" href="/garantii/">Условия возврата</a>
    </div>
  </div>
  {/if}
  {if $_modx->resource.context_key in list ["krovelnyjstroymarket"]}
  <div class="infoblocks__advantage">
    <div class="advantage">
      <div class="advantage__icon"><img class="advantage__icon-image"
          src="assets/template/pictures/advantages/advantage-8.png"></div>
      <p class="advantage__title">Бесплатный выезд замерщика</p>
      <p class="advantage__text">Наша компания предоставляет услугу бесплатного замера. Наш специалист произведет полный расчет необходимых материалов и поможет сократить расходы.
      </p><a class="advantage__link link" href="/akcii/besplatnyij-zamer/">Заказать бесплатный замер</a>
    </div>
  </div>
  {/if}
  <div class="infoblocks__advantage">
    <div class="advantage">
      <div class="advantage__icon"><img class="advantage__icon-image" src="assets/template/pictures/advantages/advantage-6.png"></div>
      <p class="advantage__title">Доставка и самовывоз</p>
      <p class="advantage__text">Вы можете заказать доставку по СПб и ЛО или оформить самовывоз с нашего склада в Санкт-Петербурге</p><a class="advantage__link link" href="/dostavka-i-oplata/">Условия доставки и самовывоза</a>
    </div>
  </div>
  {if $_modx->resource.context_key not in list ["krovelnyjstroymarket"]}
  <div class="infoblocks__advantage">
    <div class="advantage">
      <div class="advantage__icon"><img class="advantage__icon-image" src="assets/template/pictures/advantages/advantage-7.png"></div>
      <p class="advantage__title">Оптово и розничная продажа</p>
      <p class="advantage__text">Мы продаём товары как в розницу, так и оптом. В зависимости от объёмов заказа мы предоставляем клиентам персональные скидки</p>
    </div>
  </div>
  {/if}
{/if}
</div>
