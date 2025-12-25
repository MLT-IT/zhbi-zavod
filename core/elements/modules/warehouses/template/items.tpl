{set $items = "@FILE modules/warehouses/snippets/selection-items.php" | snippet}
{if $items}
    {set $date = $_modx->runSnippet("@FILE snippets/getCurrentDate.php", ["modifyDate" => "0 day"])}
    {foreach $items as $index => $item}
        {set $pdoid = 'pdopage_'~$index}
        {set $pdonav = 'page_'~$index}

        {set $outer = '!pdoPage' | snippet :[
            'parents' => $item['parents'],
            'where' => '{"class_key":"msProduct"}',
            'limit' => 10,
            'sortby' => '{"priority":"ASC"}',
            'includeTVs' => 'priority',
            
            'tpl' => '@FILE modules/warehouses/chunks/product-on-warehouse.tpl',
            'tplWrapper' => '@INLINE {$output}',
            'ajaxTplMore' => '@INLINE <button class="btn btn-bordered btn-more">Показать еще</button>'
            
            'ajaxMode' => 'button',
            
            'pageNavVar' => $pdonav,
            'pageVarKey' => $index,
            'ajaxElemWrapper' => '#'~$pdoid,
            'ajaxElemRows' => '#'~$pdoid~' .rows',
            'ajaxElemPagination' => '#'~$pdoid~' .pagination',
            'ajaxElemMore' => '#'~$pdoid~' .btn-more',
            'ajaxElemLink' => '#'~$pdoid~' .pagination a',
        ]}

        {if $outer}
        <div class="warehouse-table" id="{$pdoid}">
            <div class="warehouse-table__header">
                <h2>{$item['title']} на {$date}</h2>
            </div>
            {set $range_remains = $_modx->resource.range_remains}
            {if $range_remains}
                {$_modx->setPlaceholder('range-remains', $range_remains | split : '-')}
            {/if}
            <div class="table-wrapper">
                <table class="table centered">
                    <thead>
                        <tr>
                            <th class="pricetable-col">Товар</th>
                            <th class="pricetable-col">Количество в наличии</th>
                        </tr>
                    </thead>
                    <tbody class="rows">{$outer}</tbody>
                </table>
            </div>
            {$_modx->getPlaceholder($pdonav)}
        </div>
        {/if}
    {/foreach}
{/if}