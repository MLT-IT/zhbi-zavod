<div class="main-banner__small">
  {if $_modx->context.key === 'gbi-zavod78'}
  <div class="main-banner__small-title fs-30 fw-700">
    Подберём <span class="color-red">ЖБИ</span> под ваш объект
  </div>
  <div class="main-banner__small-text">
    Оставьте заявку и наш менеджер поможет вам с расчётами!
  </div>
  <picture class="main-banner__small-image">
    <img src="/assets/template/images/sections/main-banner/{$_modx->context.key}/small.jpg" />
  </picture>
  <button class="btn btn-primary" onclick="modals.events.open('modal-callback')">
    Оставить заявку
    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="none" viewBox="0 0 24 24"><path d="M4 12h16m0 0-6-6m6 6-6 6" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/></svg>
  </button>
  {else}
  <div class="advertisement_note advertisement_note__small">Реклама</div>
  <div class="main-banner__small-title fs-30 fw-700">
    Ликвидация склада успей забрать!
  </div>
  <picture class="main-banner__small-image">
    <img src="/assets/template/images/sections/main-banner/{$_modx->context.key}/small.jpg" />
  </picture>
  <button class="btn btn-primary" onclick="modals.events.open('modal-callback')">
    Подробнее
  </button>
  {/if}
</div>
