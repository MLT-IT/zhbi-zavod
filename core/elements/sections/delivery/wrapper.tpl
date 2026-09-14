{set $product_name_rp_1 = 'материала'}
{set $product_name_rp_2 = 'стройматериалов'}

{switch $_modx->resource.context_key}
{case 'tagnerud'}
  {set $product_name_rp_1 = 'товаров'}
  {set $product_name_rp_2 = 'керамзита'}
{/switch}
<article class="infoblocks section{$styleClass ? ' ' ~ $styleClass : ''}">
  <div class="infoblocks__container">
    <div class="infoblocks__content">
      <span class="infoblocks__title section__title">Условия доставки {$product_name_rp_1}</span>
      <p class="infoblocks__subtitle">Доставка {$product_name_rp_2} по Санкт-Петербургу осуществляется по следующему тарифу (условия по ЛО уточняйте у менеджера):</p>
      <div class="table">
        {include 'file:sections/delivery-inner/wrapper.tpl'}
      </div>
    </div>

    {include "file:chunks/guarantees.tpl"}

    <div class="infoblocks__bottom"><a class="btn btn_style_shadow" data-fancybox="" href="#callback">заказать с доставкой</a></div>
  </div>
</article>
