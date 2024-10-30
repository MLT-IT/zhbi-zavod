
{* в будущем на удаление, было параллельно сделано с модулем warehouse, решено оставить модуль *}

{set $stockData = $_modx->runSnippet('@FILE snippets/product/getStockPlitnye.php', ['unit' => $_modx->resource.unit[0]])}
<div class="product-info__availability-title pc-flex">
  <span class="bold">Наличие на {'' | date : 'd.m'}</span><span class="dot-separator"></span> <span class="bold">{$stockData.totalStock.value} {$stockData.totalStock.unit}</span>
</div>
{foreach $stockData.warehouses as $wh}
<div class="product-info__availability-title pc-flex">
    <span>Склад {$wh.name}</span><span class="dot-separator"></span> {$wh.stock} {$wh.unit}
</div>
{/foreach}
<div class="product-info__shipped pc-flex">
    <span>При оформлении заказа сегодня доставим</span><span class="dot-separator"></span><span class="bold">&nbsp; {'+1 days' | date : 'd.m.Y'} </span>
</div>
