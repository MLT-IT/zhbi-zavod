{set $price_list = "@FILE templates/product/tabs/price/getPriceList.php" | snippet}

{if $price_list}
<div class="product-price-list">
  <table class="product-price-list__table">
    <thead>
      <tr>
        <th>Наименование</th>
        <th>Характеристики</th>
        <th>Цена</th>
      </tr>
    </thead>
    <tbody>
      {foreach $price_list as $item}
      <tr class="{if $item['current']}active{/if}">
        <td>
          <a href="{$item['url']}" class="link">{$item['name']}</a>
        </td>
        <td>
          {if $item['article']}<div>Маркировка: {$item['article']}</div>{/if}
          {foreach $item['characteristics'] as $char}
            <div>{$char['label']}: {$char['value']}</div>
          {/foreach}
        </td>
        <td>{$item['price']} ₽</td>
      </tr>
      {/foreach}
    </tbody>
  </table>
</div>
{else}
<p>Прайс по данной категории пока не заполнен.</p>
{/if}
