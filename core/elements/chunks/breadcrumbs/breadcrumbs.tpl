<section class="breadcrumbs section__breadcrumbs{$styleClass ? ' ' ~ $styleClass : ''}">
  <div class="breadcrumbs__container">
    <ul itemscope itemtype="https://schema.org/BreadcrumbList" class="breadcrumbs__items">
      <li itemscope itemprop="itemListElement" itemtype="https://schema.org/ListItem" class="breadcrumbs__item breadcrumbs__item_outer">
          <a class="breadcrumbs__item breadcrumbs__item_inner" itemprop="item" href="/">
              <span itemprop="name" class="breadcrumbs__val">Главная</span>
              <meta itemprop="position" content="0">
          </a>
      </li>
      {'pdoCrumbs' | snippet : [
        'tpl' => '@FILE chunks/breadcrumbs/breadcrumbs-item.tpl',
        'tplCurrent' => '@FILE chunks/breadcrumbs/breadcrumbs-item-current.tpl',
        'tplWrapper' => '@INLINE [[+output]]',
        'showHome' => 0,
        'showAtHome' => 0,
        'hideSingle' => 1,
        'where' => '{"template:!=":0}'
      ]}
    </ul>
  </div>
</section>
