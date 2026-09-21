{if $_modx->context.key !== 'gbi-zavod78'}
<div class="sidebar-banner">
  <div class="advertisement_note advertisement_note__small">Реклама</div>
  {* Баннер для заборов *}

  {if $_modx->resource.resource_segment in list ['shtaketnik']}
  <a class="btn btn-dark" href="/servisyi-rascheta/raschet-shtaketnika-dlya-zabora/">
    Рассчитать забор
  </a>
  <img src="/assets/template/images/sections/sidebar-banner/sidebar-zabor.png" />
  {else}
  <a class="btn btn-dark" href="/servisyi-rascheta/raschet-krovli-iz-metallocherepiczyi/">
    Рассчитать кровлю
  </a>
  <img src="/assets/template/images/sections/sidebar-banner/sidebar-krovlya.png" />
  {/if}
</div>
{/if}