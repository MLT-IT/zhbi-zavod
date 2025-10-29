<div class="product-info__volume"><span class="product-info__volume-title">Цена за:</span>
  <input type="hidden" name="unit" value="1">
  <div class="product-card__volume">
    <ul class="product-info__volume-tabs">
      <li class="product-info__volume-tab js-product__volume-tab active" data-val="1">{$prodValues['pricePer']}</li>
      {foreach $prodValues['itemUnits'] as $val}
          {if $prodValues['pricePer'] != $val['title']}
            <li class="product-info__volume-tab js-product__volume-tab" data-val="{$val['id']}">{$val['title']}</li>
          {/if}
      {/foreach}
    </ul>
  </div>
</div>