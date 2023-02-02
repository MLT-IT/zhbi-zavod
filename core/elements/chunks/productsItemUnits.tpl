{if $condition}
    {if $_modx->resource.context_key not in ['kirpich-m', 'fasady-pro']}
      <div class="js-product__selprice listing__products-item-selprice">
        <span class="js-product__selprice-span">Цена за</span>
        <select name="unit" class="custom-select js-product__units-select">
          <option value="1" selected>{$pricePer}</option>
            {foreach $itemUnits as $val}
              <option value="{$val['id']}">{$val['title']}</option>
            {/foreach}
        </select>
      </div>
    {else}
      <div class="js-product__selprice product-card__units-wrap">
        <input type="hidden" name="unit" value="1">
        <span class="product-card__unit-span">Цена за</span>
        <span class="product-card__unit-link active" data-val="1">{$pricePer}</span>
          {foreach $itemUnits as $val}
            <span class="product-card__unit-link" data-val="{$val['id']}">{$val['title']}</span>
          {/foreach}
      </div>
    {/if}
{else}
  <input type="hidden" name="unit" value="1">
{/if}
