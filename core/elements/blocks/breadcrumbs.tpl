<div class="header__topbar">
    {* Поиск *}
    <form action="/search/" class="header__search-wrap header__search-wrap_type_mobile"  fast-search-form="mobile">
        <input class="header__search" placeholder="Поиск по сайту" name="query"  fast-search-input="mobile">
        <button type="submit" class="header__search-btn"></button>
    </form>

    {'pdoCrumbs' | snippet : [
        'tpl' => '@FILE blocks/breadcrumbs-item.tpl',
        'tplCurrent' => '@FILE blocks/breadcrumbs-item-current.tpl',
        'tplWrapper' => '@INLINE <ul itemscope itemtype="https://schema.org/BreadcrumbList" class="breadcrumbs">[[+output]]</ul>',
        'showHome' => 1,
        'showAtHome' => 0,
        'hideSingle' => 1
    ]}
</div>
