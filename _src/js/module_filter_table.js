import initTableFilter from './modules/pricelist_table_filter'

// --------------------------------
// Создает фильтр на прайс таблицы в контенте
// --------------------------------
document.querySelectorAll('.content-block table.table-filter').forEach((table, table_count) => {
    initTableFilter(table, table_count)
})