<section class="catalog section">
  <div class="catalog__container js-catalog" id="mse2_mfilter">
    <div class="catalog__filter filter" data-dropdown>
      <button class="filter__btn btn btn_style_base">фильтры</button>
      <div class="filter__inner">
        <form action="{$_modx->resource.id | url}" class="filter__body" id="mse2_filters" method="post">
            {$filters}
        </form>
        <button class="filter__close-btn btn btn_style_base" data-dropdown-only-close="1" data-dropdown data-dropdown-body-doc=".filter">Закрыть и применить</button>
      </div>
    </div>

    <div class="catalog__top">
      <div class="catalog__selected-wrap" id="mse2_selected_wrapper">
        <div class="catalog__selected" id="mse2_selected" style="display: none;"></div>
      </div>

      <div class="catalog__sorting sorting" data-dropdown="" id="mse2_sort">
        <button class="sorting__btn btn btn_style_black-trans">По популярности</button>
        <div class="sorting__body">
          <span class="sorting__title">Сортировать:</span>
          <a href="#" class="sorting__item{if $.get.sort == ''} active{/if}" data-sort="" data-dir="">По популярности</a>
          <a href="#" class="sorting__item{if $.get.sort == 'ms|price:desc'} active{/if} sorting__item_switch" data-sort="ms|price" data-dir="" data-default="desc">По цене</a>
          <a href="#" class="sorting__item{if $.get.sort == 'ms_product|pagetitle:desc'} active{/if} sorting__item_switch sorting__item_switch_up" data-sort="ms_product|pagetitle" data-dir="" data-default="desc">По алфавиту</a>
        </div>
      </div>
    </div>

    <div class="catalog__body">
      <div class="catalog__products" id="mse2_results">
          {$results}
      </div>
      <div id="mse2_pagination">
          {$_modx->getPlaceholder('page.nav')}
      </div>
      <div class="hidden-data">
        <span id="mse2_total">{$total ?: 0}</span>
      </div>

      <div class="banner">
        <picture class="banner__bg">
          <source srcset="assets/template/pictures/main-screen/{$_modx->resource.context_key}/main-screen-mob.jpg" media="(max-width: 480px)"><img class="banner__bg-img" src="assets/template/pictures/main-screen/{$_modx->resource.context_key}/main-screen.jpg" alt="banner">
        </picture>
        <div class="banner__title">
          {switch $_modx->resource.context_key}
            {case 'web'}
              {set $text = 'Закажите утеплитель сейчас<br>и получите <span class="text-highlighter">скидку 30%</span><br>на доставку'}
            {case 'gazosilikatstroy'}
              {set $text = 'Закажите газобетон сейчас<br>и получите <span class="text-highlighter">скидку 30%</span><br>на манипулятор'}
            {case 'kraska'}
              {set $text = 'Закажите краску сейчас<br>и получите <span class="text-highlighter">скидку 30%</span><br>на доставку'}
            {case 'suhiesmesi'}
              {set $text = 'Закажите сухие смеси сейчас<br>и получите <span class="text-highlighter">скидку 30%</span><br>на доставку'}
          {/switch}
          {$text}
        </div>
        <p class="banner__text">Акция до конца месяца</p>
        <div class="banner__action"><span data-fancybox data-src="#callback" class="banner__btn btn btn_style_yellow">Заказать со скидкой</span></div>
      </div>


    </div>
  </div>
</section>
