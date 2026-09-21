{set $peers = "@FILE modules/product-card/snippets/getGostTuOption.php" | snippet}

{if $peers}
{set $standart = $_modx->resource.standart[0]}
<div class="standart-switcher">
  <div class="standart-switcher__title">Стандарт:</div>
  <div class="standart-switcher__row">
    <span class="btn btn-bordered active">{$standart}</span>
    {foreach $peers as $peer}
      <a class="btn btn-bordered" href="{$_modx->makeUrl($peer['id'])}" title="{$peer['pagetitle']}">
        {$peer['standart']}
      </a>
    {/foreach}
  </div>
</div>
{/if}
