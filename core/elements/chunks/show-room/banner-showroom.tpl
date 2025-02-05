{set $isBannerVisible = true}
{set $isLinkToFBCatalog = false}
{set $title = 'Посмотрите товары в нашем Шоу-руме <br>онлайн'}
{set $description = 'Наши специалисты ознакомят Вас с нашим ассортиментом <br>и проведут бесплатную консультацию.'}
{set $button = 'Отправить заявку'}
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
{case 'fibrofasad'}
  {set $isLinkToFBCatalog = true}
  {set $title = 'Фиброцементный сайдинг от лучших производителей!'}
  {set $description = 'В нашем ассортименте представлены гладкие и фактурные панели и сайдинг.'}
  {set $button = 'Перейти в каталог'}
{/switch}

{if $isBannerVisible}
<div class="showroom-banner">
  <div class="showroom-banner__background">
    <picture>
      {set $file = 'assets/template/banners/'~$site_context~'/banner-showroom-bg.webp'}
      {if ('@FILE snippets/fileExists.php' | snippet : ['input' => $file])}
      <source srcset="{$file}" type="image/webp">
      {/if}
      <img src="assets/template/banners/{$site_context}/banner-showroom-bg.jpg">
    </picture>
  </div>
  <div class="showroom-banner__wrapper">
    <p class="showroom-banner__title">{$title}</p>
    <p class="showroom-banner__description">{$description}</p>
    <div class="banner__action"><a class="banner__btn btn btn_style_base" {if $isLinkToFBCatalog}href="{$_modx->makeUrl(125346)}"{else}data-fancybox href="#showRoom"{/if}>{$button}</a></div>
  </div>
</div>
{/if}