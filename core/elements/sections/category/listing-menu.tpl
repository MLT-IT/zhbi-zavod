{*<div class="listing__filter-list">
    <div class="listing__filter-list-item">Бетон</div>
    <div class="listing__filter-list-item">ЖБИ</div>
    <div class="listing__filter-list-item active">Песок</div>
    <div class="listing__filter-list-item">Щебень</div>
    <div class="listing__filter-list-item">Керамзит</div>
    <div class="listing__filter-list-item">Артматура</div>
</div>*}
{'!pdoMenu' | snippet : [
    'parents' => '0',
    'resources' => '10,11,433,9,501',
    'tpl' => '@FILE sections/category/listing-menu-item.tpl',
    'outerClass' => 'listing__filter-list',
    'rowClass' => 'listing__filter-list-item'
]}