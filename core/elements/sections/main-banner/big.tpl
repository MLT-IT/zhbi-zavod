<div class="main-banner__big">
  <div class="advertisement_note">Реклама</div>
  {if $_modx->context.key === 'gbi-zavod78'}
  <div class="main-banner__big-title fs-36 fw-700">
    Дорожные плиты<br/>
    <span class="color-red">Скидка 20%</span> на доставку
  </div>
  <div class="main-banner__big-text">
    Для дорог, подъездных путей и площадок.<br/>
    В наличии и под заказ.
  </div>

  <div class="main-banner__big-advantages">
    <div class="main-banner__big-advantages-item">
      <svg viewBox="0 0 24 24" fill="none" width="32" height="32">
        <path d="M12 2l8 3v6c0 5-3.5 8.5-8 10-4.5-1.5-8-5-8-10V5l8-3z" style="stroke: var(--color-red)" stroke-width="1.5" stroke-linejoin="round"/>
        <path d="M8.5 12l2.5 2.5 4.5-5" style="stroke: var(--color-red)" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
      </svg>
      <span>Контроль<br/>качества</span>
    </div>
    <div class="main-banner__big-advantages-sep"></div>
    <div class="main-banner__big-advantages-item">
      <svg viewBox="0 0 24 24" fill="none" width="32" height="32">
        <path d="M1.5 7.5h11v9h-11z" style="stroke: var(--color-red)" stroke-width="1.5" stroke-linejoin="round"/>
        <path d="M12.5 10.5h4l3 3v3h-7z" style="stroke: var(--color-red)" stroke-width="1.5" stroke-linejoin="round"/>
        <circle cx="6" cy="18" r="1.6" style="stroke: var(--color-red)" stroke-width="1.5"/>
        <circle cx="17" cy="18" r="1.6" style="stroke: var(--color-red)" stroke-width="1.5"/>
      </svg>
      <span>Оперативная<br/>отгрузка</span>
    </div>
    <div class="main-banner__big-advantages-sep"></div>
    <div class="main-banner__big-advantages-item">
      <svg viewBox="0 0 24 24" fill="none" width="32" height="32">
        <circle cx="12" cy="8" r="3.2" style="stroke: var(--color-red)" stroke-width="1.5"/>
        <path d="M5 19.5c0-3.3 3.1-6 7-6s7 2.7 7 6" style="stroke: var(--color-red)" stroke-width="1.5" stroke-linecap="round"/>
        <path d="M4 10.5a8 8 0 0 1 16 0" style="stroke: var(--color-red)" stroke-width="1.5" stroke-linecap="round"/>
        <rect x="3" y="10.5" width="2.2" height="4" rx="1.1" style="stroke: var(--color-red)" stroke-width="1.3"/>
        <rect x="18.8" y="10.5" width="2.2" height="4" rx="1.1" style="stroke: var(--color-red)" stroke-width="1.3"/>
      </svg>
      <span>Бесплатная<br/>консультация</span>
    </div>
  </div>

  <picture class="main-banner__big-image">
    <source
      srcset="/assets/template/images/sections/main-banner/{$_modx->context.key}/big-mobile.jpg"
      media="(max-width: 480px)"
    />
    <img src="/assets/template/images/sections/main-banner/{$_modx->context.key}/big-desktop.jpg" />
  </picture>

  <a class="btn btn-primary" href="/dorozhnye-plity/">
    В каталог
  </a>
  {else}
  <div class="main-banner__big-title fs-36 fw-700">
    Закажите дорожные плиты сейчас и получите
    <span class="color-red">скидку 20%</span> на доставку.
  </div>
  <div class="main-banner__big-text">Акция до конца месяца</div>

  <picture class="main-banner__big-image">
    <source
      srcset="/assets/template/images/sections/main-banner/{$_modx->context.key}/big-mobile.jpg"
      media="(max-width: 480px)"
    />
    <img src="/assets/template/images/sections/main-banner/{$_modx->context.key}/big-desktop.jpg" />
  </picture>

  <button class="btn btn-primary" onclick="modals.events.open('modal-callback')">
    Заказать со скидкой
  </button>
  {/if}
</div>
