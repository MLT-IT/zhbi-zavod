{set $a1 = 'Официальные дилеры 8-ми производителей'}
{set $a2 = 'Более 40 складов по Санкт-Петербургу и Ленинградской области'}
{set $a3 = 'Оплата после проверки материала'}
{set $a4 = 'Держим на складе более 800 м3'}

{switch $_modx->resource.context_key}
  {case 'kraska'}
    {set $a1 = 'Официальные дилеры крупнейших производителей'}
    {set $a4 = 'Держим на складе более 800 наименований'}
  {case 'krovelnyjstroymarket'}
    {set $a1 = 'Официальные дистрибьюторы 17-ти кровельных производств и металлобаз'}
    {set $a2 = 'Ежедневно производим более 1000 м2 металлочерепицы и профнастила'}
    {set $a3 = 'Оплата после проверки материала'}
    {set $a4 = 'Держим на складе более 8000 м2'}
  {case 'krovelnyjstroymarket'}
    {set $a1 = 'Предоставляем продукцию 15 производителей'}
  {case 'beltermo'}
    {set $a1 = 'Официальные дилеры продукции Белтермо'}
  {case 'plitnye'}
    {set $a1 = 'Предоставляем продукцию 15 производителей'}
  {case 'fibrofasad'}
    {set $a1 = 'Официальные дилеры 13-и производителей'}
  {case 'fibrofasad2'}
    {set $a1 = 'Официальные дилеры 13-и производителей'}
  {case 'tagnerud'}
    {set $a1 = 'Поставляем керамзит в течение двух дней'}
  {case 'profnastil'}
    {set $a1 = 'Официальные дилеры Grand Line и Металл-Профиль'}
    {set $a4 = ' Держим на складе более 15000 м2'}
  

  {case 'gibkaya-cherepiza'}
    {set $a1 = 'Официальные дилеры более 6 брендов'}
    {set $a4 = ' Держим на складе более 15000 м2'}
  {case 'falcevaya-krovlya'}
    {set $a1 = 'Официальные дилеры Grand Line и Металл-Профиль'}
    {set $a4 = ' Держим на складе более 15000 м2'}
  {case 'metallocherepica'}
    {set $a1 = 'Официальные дилеры Grand Line и Металл-Профиль'}
    {set $a4 = ' Держим на складе более 15000 м2'}
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
