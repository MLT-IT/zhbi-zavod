{set $unit = 'м3'}

{switch $_modx->resource.context_key}
{case 'krovelnyjstroymarket'}
  {if $key in list [125540, 125537,125536,125539,125533,125529,123488, 123489, 123490,  123491,  123492,  123493,  123494,  123495,  123496,  123497,  123498, 123499]}
      {set $unit = 'шт'}
    {elseif $key in list[125531]}
      {set $unit = 'лист'}
    {elseif $key in list[125538]}
      {set $unit = 'упаковку'}
    {elseif $key in list[125541]}
      {set $unit = 'п.м.'}
    {else}
      {set $unit = 'м2'}
  {/if}
{case 'kraska'}
  {set $unit = 'упаковку'}
{case 'suhiesmesi'}
  {set $unit = 'упаковку'}
{case 'kirpich-m5'}
  {set $unit = 'шт.'}
{case 'plitnye'}
  {set $unit = 'лист'}
{case 'fibrofasad'}
  {set $unit = 'шт'}
{case 'gbi-zavod78'}
  {set $unit = 'шт'}
{case default}
  {set $unit = 'шт'}
{/switch}


<a href="{$uri}" class="swiper-slide preview-card">
  <div class="preview-card__picture">
    <img src="/assets/images/loader.svg" class="preview-card__image lazy" data-src="{$img}" alt="{$name}">
  </div>
  <p class="preview-card__name">{$name}</p>
  {* {if $_modx->resource.context_key not in ['gbi-zavod78']} *}
  <p class="preview-card__price">от {$minprice} ₽ </p>
  <span class="preview-card__notion">{$custom_unit ? $custom_unit : 'Стоимость за 1 ' ~ $unit}</span>
  {* {/if} *}
  <span class="preview-card__btn btn btn_style_shadow">перейти</span>
</a>
