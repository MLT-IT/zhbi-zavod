{extends "file:layouts/base.tpl"}

{block 'page-content'}
{include "file:sections/breadcrumbs/wrapper.tpl"}

<div>
  <div class="container">
    <h1 class="section-title">{$_modx->resource.pagetitle}</h1>

    {if $_modx->context.key !== 'gbi-zavod78'}
    {include "file:sections/promo-banner/v2/wrapper.tpl"}
    {/if}
  </div>
</div>

<div class="section-margin section-padding bg-light-gray-2">
  <div class="container">
    <h2 class="section-title">Акции и скидки</h2>

    {include "file:sections/promotions/wrapper.tpl"}
  </div>
</div>

<div class="section-margin page-content">
  <div class="container">
    <ol>
      <li>Скидка на доставку продукции — 30%</li>
      <li>Крупным оптовым покупателям скидка 5% на весь заказ</li>
      <li>Строительство под ключ! Получите скидку на комплексную поставку материалов для строительства</li>
    </ol>
    <p>* Подробную информацию уточняйте по телефону у наших менеджеров</p>
  </div>
</div>

{/block}