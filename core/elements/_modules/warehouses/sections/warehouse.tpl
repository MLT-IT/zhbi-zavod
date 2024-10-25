<div class="warehouse-table__item">
    <div class="warehouse-table__header">
        <h2>Наличие товаров на {$_modx->runSnippet("@FILE snippets/getCurrentDate.php", ["modifyDate" => "0 day"])}</h2>
    </div>
    {$_modx->runSnippet("@FILE modules/warehoses/snippets/list.php", [
    "parents" => "18986",
    "where" => $where,
    "unique" => md5($_modx->resource.pagetitle),
    "prefix" => "шт."
    ])}
</div>
