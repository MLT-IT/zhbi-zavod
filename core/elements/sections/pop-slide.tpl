{set $unit = 'м3'}


{if $_modx->resource.context_key == 'krovelnyjstroymarket'}
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
{/if}
{if $_modx->resource.context_key == 'kraska'}
  {set $unit = 'упаковку'}
{/if}


<a href="{$uri}" class="swiper-slide preview-card">
  <div class="preview-card__picture">
    <img src="/assets/images/loader.svg" class="preview-card__image lazy" data-src="{$img}" alt="{$name}">
  </div>
  <p class="preview-card__name">{$name}</p>
  <p class="preview-card__price">от {$minprice} ₽ </p>
  <span class="preview-card__notion">{$custom_unit ? $custom_unit : 'Стоимость за 1 ' ~ $unit}</span>
  <span class="preview-card__btn btn btn_style_shadow">перейти</span>
</a>
