{set $data = "@FILE modules/warehouses/snippets/remains.php" | snippet}
<ul class="warehouse-remains">
  <li class="warehouse-remains__item mb-8">
    <span>Наличие на <b>{'' | date : 'd.m'}</b></span>
    <span><b>{$data['total_remains']} уп.</b></span>
  </li>

  {*
  {foreach $data['warehouses'] as $warehouse}
  <li>
    <a href="{$warehouse['uri']}" class="warehouse-remains__item">
      <span><b>{$warehouse['menutitle'] ?: $warehouse['pagetitle']}</b></span>
      <span><b>{$warehouse['remains']} уп.</b></span>
    </a>
  </li>
  {/foreach}
  *}

  <li class="warehouse-remains__item mt-8">
    <span>Самовывоз со склада {'' | date : 'd.m'}</span>
    <span><b>бесплатно</b></span>
  </li>
  <li class="warehouse-remains__item">
    <span>Доставка {'+1 days' | date : 'd.m'}</span>
    <span><b>от 949 руб.</b></span>
  </li>
</ul>
