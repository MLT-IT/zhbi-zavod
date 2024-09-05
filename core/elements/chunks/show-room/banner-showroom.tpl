{switch $_modx->resource.context_key}
{case 'web'}
  {set $link = '/akcii/likvidacziya-sklada-uspej-zabrat/'}
{case 'plitnye'}
  {set $link = '#'}
{case 'stenovye'}
  {set $link = '#'}
{case 'gazosilikatstroy'}
  {set $link = '/rasprodazha-so-sklada/'}
{case 'kraska'}
  {set $link = '#'}
{case 'suhiesmesi'}
  {set $link = '#'}
{case 'krovelnyjstroymarket'}
  {set $link = '/shourum/'}
{/switch}
<div class="showroom-banner">
  <div class="showroom-banner__background">
    <img src="/assets/template/banners/{$site_context}/banner-showroom-bg.jpg" alt="">
  </div>
  <div class="showroom-banner__wrapper">
    <p class="showroom-banner__title">Посмотрите товары в нашем Шоу-руме <br>онлайн</p>
    <p class="showroom-banner__description"> 
    Наши специалисты ознакомят Вас с нашим ассортиментом <br>
    и проведут бесплатную консультацию. </p>
    <div class="banner__action"><a class="banner__btn btn btn_style_yellow" data-fancybox href="#showRoom">Отправить заявку</a></div>
  </div>
</div>
