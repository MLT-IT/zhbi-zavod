{set $items = "@FILE modules/split-unit/snippets/splitUnit.php" | snippet : [
  'formula' => $_modx->context.key,
  'fields' => [
    'unit' => $_pls['unit'][0],
    'price' => $price,
    'old_price' => $old_price,
    'kolvom2upak' => $_pls['kolvom2upak'][0]
  ]
]}

<div class="product-card__price">
  {include "file:modules/split-unit/chunks/prices.tpl" items=$items}
</div>
{if count($items) > 0}
  {include "file:modules/split-unit/chunks/controls.tpl" items=$items}
{/if}