{set $a1 = 'Официальные дилеры 8-ми производителей'}
{set $a2 = 'Более 40 складов по Санкт-Петербургу и Ленинградской области'}
{set $a3 = 'Оплата после проверки материала'}
{set $a4 = 'Держим на складе более 800 м3'}

{switch $_modx->resource.context_key}
  {case 'kraska'}
    {set $a1 = 'Официальные дилеры крупнейших производителей'}
    {set $a4 = 'Держим на складе более 800 наименований'}
{/switch}

<div class="advantages{$styleClass ? ' ' ~ $styleClass : ''}">
  <div class="advantages__item advantage">
    <div class="advantage__icon"><img class="advantage__icon-image" src="assets/template/pictures/advantages/advantage-1.png"></div>
    <p class="advantage__text">{$a1}</p>
  </div>
  <div class="advantages__item advantage">
    <div class="advantage__icon"><img class="advantage__icon-image" src="assets/template/pictures/advantages/advantage-2.png"></div>
    <p class="advantage__text">{$a2}</p>
  </div>
  <div class="advantages__item advantage">
    <div class="advantage__icon"><img class="advantage__icon-image" src="assets/template/pictures/advantages/advantage-3.png"></div>
    <p class="advantage__text">{$a3}</p>
  </div>
  <div class="advantages__item advantage">
    <div class="advantage__icon"><img class="advantage__icon-image" src="assets/template/pictures/advantages/advantage-4.png"></div>
    <p class="advantage__text">{$a4}</p>
  </div>
</div>
