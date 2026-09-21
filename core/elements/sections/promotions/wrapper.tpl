{if $_modx->context.key === 'web'}
<div class="promotions">
  <div class="promotions__row">
    <div class="promotions__item promotions__item--big">
      <div class="advertisement_note">Реклама</div>
      <picture class="promotions__item-bg">
        <source srcset="/assets/template/images/sections/promotions/krovlya-1-mobile.png" media="(max-width: 768px)">
        <img class="promotions__item-bg-img" src="/assets/template/images/sections/promotions/krovlya-1.png"
          alt="Точный расчет кровли">
      </picture>
      <div class="promotions__item-content">
        <h3 class="promotions__item-title">
          Точный расчет <br> кровли <span class="color-red">в подарок!</span>
        </h3>
        <p class="promotions__item-text">
          Специалисты<br> произведут точный расчет<br> всех материалов <br>под Ваш заказ <br>бесплатно
        </p>
        <button class="btn btn-primary bg-red" onclick="modals.events.open('modal-callback')">
          получить расчет
        </button>
      </div>
    </div>

    <div class="promotions__grid">
      <div class="promotions__item">
        <div class="advertisement_note">Реклама</div>
        <picture class="promotions__item-bg">
          <source srcset="/assets/template/images/sections/promotions/krovlya-2-mobile.png" media="(max-width: 768px)">
          <img class="promotions__item-bg-img" src="/assets/template/images/sections/promotions/krovlya-2.png"
            alt="Металлочерепица Grand Line">
        </picture>
        <div class="promotions__item-content">
          <img class="promotions__item-logo" src="/assets/template/images/sections/promotions/grand-logo.png"
            alt="Grand Line">
          <h3 class="promotions__item-title promotions__item-title--small">
            Скидка на металлочерепицу<br><span class="color-brand-red">Grand Line</span>
            <span class="promotions__item-label bg-red">от 310 ₽ за м2</span>
          </h3>
          <a class="btn btn-primary bg-red" href="{$_modx->makeUrl(74907)}">
            перейти в каталог
          </a>
        </div>
      </div>

      <div class="promotions__item">
        <div class="advertisement_note">Реклама</div>
        <picture class="promotions__item-bg">
          <source srcset="/assets/template/images/sections/promotions/krovlya-3-mobile.png" media="(max-width: 768px)">
          <img class="promotions__item-bg-img" src="/assets/template/images/sections/promotions/krovlya-3.png"
            alt="Профлист Металл-Профиль">
        </picture>
        <div class="promotions__item-content">
          <img class="promotions__item-logo" src="/assets/template/images/sections/promotions/mp-logo.png"
            alt="Металл-Профиль">
          <h3 class="promotions__item-title promotions__item-title--small">
            Скидка на профлист<br><span class="color-brand-blue">Металл-Профиль</span>
            <span class="promotions__item-label bg-blue">от 250 ₽ за м2</span>
          </h3>
          <a class="btn btn-primary bg-blue" href="{$_modx->makeUrl(90889)}">
            перейти в каталог
          </a>
        </div>
      </div>
    </div>
  </div>
</div>
{else}
<div class="promotions">
  <div class="promotions__row">
    <div class="promotions__item promotions__item--big">
      <div class="advertisement_note">Реклама</div>
      <picture class="promotions__item-bg">
        <source srcset="/assets/template/images/sections/promotions/zbi-1-mobile.jpg" media="(max-width: 768px)">
        <img class="promotions__item-bg-img" src="/assets/template/images/sections/promotions/zbi-1.jpg"
          alt="Скидка 20% на доставку манипулятором">
      </picture>
      <div class="promotions__item-content">
        <h3 class="promotions__item-title">
          Скидка 20% на <span class="color-red">доставку манипулятором</span>
        </h3>
        <p class="promotions__item-text">
          Скидка 20% на доставку ЖБИ манипулятором при заказе от 60 м3
        </p>
        <a class="btn btn-primary bg-red" href="/akcii/">
          узнать подробности акции
        </a>
      </div>
    </div>

    <div class="promotions__grid">
      <div class="promotions__item">
        <div class="advertisement_note">Реклама</div>
        <picture class="promotions__item-bg">
          <img class="promotions__item-bg-img" src="/assets/template/images/sections/promotions/zbi-2.png"
            alt="Плита дорожная 2П 30-18-30 ГОСТ">
        </picture>
        <div class="promotions__item-content">
          <h3 class="promotions__item-title promotions__item-title--small">
            Плита дорожная 2П 30-18-30 ГОСТ<br><span class="color-brand-red">8 800 руб/шт</span>
          </h3>
          <p class="promotions__item-text">Самые низкие цены на ЖБИ</p>
          <a class="btn btn-primary bg-red" href="/dorozhnye-plity/">
            перейти в каталог
          </a>
        </div>
      </div>

      <div class="promotions__item">
        <div class="advertisement_note">Реклама</div>
        <picture class="promotions__item-bg">
          <img class="promotions__item-bg-img" src="/assets/template/images/sections/promotions/zbi-3.jpg"
            alt="Железобетонный Лоток ЛК 300.60.60">
        </picture>
        <div class="promotions__item-content">
          <h3 class="promotions__item-title promotions__item-title--small">
            Железобетонный Лоток ЛК 300.60.60<br><span class="color-brand-blue">3 760 руб/шт</span>
          </h3>
          <p class="promotions__item-text">Доставка уже завтра</p>
          <a class="btn btn-primary bg-blue" href="/lotki-zhelezobetonnye/">
            перейти в каталог
          </a>
        </div>
      </div>
    </div>
  </div>
</div>
{/if}
