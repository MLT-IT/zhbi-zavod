<section class="breadcrumbs {if $bg}bg-light-gray-2{/if}">
    <div class="container" style=" scrollbar-width: none; ">
      <ul class="breadcrumbs__items">
        {'pdoCrumbs' | snippet : [
          'tpl' => '@FILE sections/breadcrumbs/item.tpl',
          'tplCurrent' => '@FILE sections/breadcrumbs/item-current.tpl',
          'tplWrapper' => '@INLINE {$output}',
          'showHome' => 1,
          'showAtHome' => 0,
          'hideSingle' => 1,
          'where' => '{"template:!=":0}'
        ]}
      </ul>
    </div>
</section>
  