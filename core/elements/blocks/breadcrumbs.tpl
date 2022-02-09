{'pdoCrumbs' | snippet : [
    'tpl' => '@FILE blocks/breadcrumbs-item.tpl',
    'tplCurrent' => '@FILE blocks/breadcrumbs-item-current.tpl',
    'tplWrapper' => '@INLINE <ul itemscope itemtype="https://schema.org/BreadcrumbList" class="breadcrumbs '~$class~'">[[+output]]</ul>',
    'showHome' => 1,
    'showAtHome' => 0,
    'hideSingle' => 1
]}
