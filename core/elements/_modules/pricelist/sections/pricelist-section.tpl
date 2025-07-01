{if $_modx->resource.id in list [231023, 255363, 255364, 255365, 255366]}
{set $ctx = $_modx->context.key}
{set $data = '@FILE snippets/fromJSON.php' | snippet: ['input' => 'warehouse-pricelist/'~$ctx~'/pricelist-tables.json']}
{set $remains = "@FILE _modules\warehouses\snippets\remains.php" | snippet: ['begin' => 100, 'end' => 300]}
<article class="infoblocks section{$styleClass ? ' ' ~ $styleClass : ''}">
  <div class="infoblocks__container">
    <div class="infoblocks__content">
      {*<span class="infoblocks__title section__title">{$data.title}</span>
      <p class="infoblocks__subtitle">{$data.text}</p>*}

      {foreach $data.tables as $tbl}

        {set $data1 = 'msProducts' | snippet : [
          'parents' => $tbl.parents
          'tpl' => '@FILE _modules/pricelist/json/item.tpl'
          'depth' => 10
          'limit' => $data.limit
          'context' => $_modx->resource.context_key
          'includeTVs' => 'priority1,HitsPage',
          'sortby' => '{"priority1":"ASC", "HitsPage":"ASC"}'
        ]}
        {*<pre>{$data1 | print_r}</pre>*}
        {set $data2 = '@FILE snippets/MSProductsOutput2JSON.php' | snippet : ['input' => $data1]}
        {set $data2 = $data2 | fromJSON}
        <div class="infoblocks__title section__title">{$tbl.title} {'' | date : 'd.m.Y'}</div>
        <div class="table">
          <table class="table__table table-delivery">
            <thead>
            <tr class="table__row">
              {foreach $data.header as $h}
                <td class="table__cell">{$h}</td>
              {/foreach}
            </tr>
            </thead>
            <tbody>
            {foreach $data2 as $row}
              <tr class="table__row">
                <td class="table__cell">{$row.name}</td>
                <td class="table__cell">{$row.price}</td>
                {set $remains = "@FILE _modules/warehouses/snippets/remains_here.php" | snippet: ['range' => $_modx->resource.range_remains, 'id' => $row.id]}
                <td class="table__cell">{$remains} {$row.unit}</td>
              </tr>
            {/foreach}
            </tbody>
          </table>
        </div>
      {/foreach}

      {*<div class="infoblocks__bottom"><a class="btn btn_style_shadow" data-fancybox="" href="#callback">{$data.button}</a></div>*}
    </div>
  </div>
</article>
{/if}