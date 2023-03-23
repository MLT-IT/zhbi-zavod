{*
data-default - какое направление сортировки будет, когда нажмем на ссылку в первый раз (то есть когда данная сортировка еще не активна).
data-dir - какое направление сейчас.
data-single-dir - запретить менять направление сортировки, нажимая по ней второй раз?
*}

<div class="catalog__body">
  <div class="catalog__products" id="mse2_results">
    {$results}
  </div>
  {$_modx->getPlaceholder('page.nav')}
</div>

<div class="hidden-data">
  <span id="mse2_total">{$total ?: 0}</span>
</div>
