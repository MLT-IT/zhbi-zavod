<input type="hidden" name="unit" value="1">
{if $prodValues['condition']}
  <div class="product-card__volume">
    <span class="product-card__volume-title">Цена за</span>
    <span class="product-card__volume-tab active" data-val="1">{$prodValues['pricePer']}</span>
    {foreach $prodValues['itemUnits'] as $val}
      <span class="product-card__volume-tab" data-val="{$val['id']}">{$val['title']}</span>
    {/foreach}
  </div>
{/if}
