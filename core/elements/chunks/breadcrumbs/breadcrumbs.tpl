<section class="breadcrumbs section__breadcrumbs{$styleClass ? ' ' ~ $styleClass : ''}">
  <div class="breadcrumbs__container">
    <ul itemscope itemtype="https://schema.org/BreadcrumbList" class="breadcrumbs__items">
      {'pdoCrumbs' | snippet : [
        'tpl' => '@FILE chunks/breadcrumbs/breadcrumbs-item.tpl',
        'tplCurrent' => '@FILE chunks/breadcrumbs/breadcrumbs-item-current.tpl',
        'tplWrapper' => '@INLINE [[+output]]',
        'showHome' => 1,
        'showAtHome' => 0,
        'hideSingle' => 1,
        'where' => '{"template:!=":0}'
      ]}
    </ul>
  </div>
</section>
