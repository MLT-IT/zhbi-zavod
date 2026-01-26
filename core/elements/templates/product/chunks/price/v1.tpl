{set $items = "@FILE modules/split-unit/snippets/splitUnit.php" | snippet : [
  'formula' => $_modx->context.key
]}

{if count($items) > 0}
  {include "file:modules/split-unit/chunks/controls.tpl" items=$items}
{/if}

<div class="product-page__inform-price__row">
    {include "file:modules/split-unit/chunks/prices.tpl" items=$items}
</div>