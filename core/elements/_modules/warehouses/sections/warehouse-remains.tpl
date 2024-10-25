{set $data = "@FILE _modules/warehouses/snippets/warehouseRemains.php" | snippet}

<ul class="warehouse-remains">
  <li class="warehouse-remains__item">
    <span>Наличие на <b>{'' | date : 'd.m'}</b></span>
    <span><b>{$data['total_remains']} уп.</b></span>
  </li>
  {foreach $data['warehouses'] as $warehouse}
  <li>
    <a href="{$warehouse['uri']}" class="warehouse-remains__item">
      <span><b>{$warehouse['menutitle'] ?: $warehouse['pagetitle']}</b></span>
      <span><b>{$warehouse['remains']} уп.</b></span>
    </a>
  </li>
  {/foreach}
</ul>
