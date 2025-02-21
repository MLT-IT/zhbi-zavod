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
      {if $_modx->resource.context_key in list ['krovelnyjstroymarket']}
        {set $parentIds = $_modx->getParentIds($_modx->resource.id)}
        {set $isZabor = ('125537' in list $parentIds) || ('125541' in list $parentIds) || ($_modx->resource.id in list [125537,125541])}
        <div class="side-banners">
          {if $isZabor}
            {include 'file:chunks/banners/side-banner.tpl' 
            image='side-banner-2.jpg' 
            title='Калькулятор расчёта забора' 
            text='Удобный инструмент помогает сократить расходы' 
            actionUrl='/servisyi-rascheta/raschet-shtaketnika-dlya-zabora/' 
            actionText='Рассчитать забор'
            }
          {else}
            {include 'file:chunks/banners/side-banner.tpl' 
            image='side-banner-1.jpg' 
            title='Калькулятор расчёта кровли' 
            text='Удобный инструмент помогает сократить расходы' 
            actionUrl='/servisyi-rascheta/raschet-krovli-iz-metallocherepiczyi/' 
            actionText='Рассчитать кровлю'
            }
          {/if}  
        </div>
      {/if}
    </div>

    <div class="catalog__top">
      <div class="catalog__selected-wrap" id="mse2_selected_wrapper">
        <div class="catalog__selected" id="mse2_selected" style="display: none;"></div>
      </div>
      {if ($_modx->resource.template in list ['4', '36'])}
        {* CUSTOM TAGS *}
        {include 'file:chunks/selectionFiltersExpanded/wrapper.tpl'}
      {else}
        {* common tags *}
        {'@FILE snippets/getTags.php' | snippet :[
        'tpl' => '@FILE chunks/create-menu/category-item.tpl',
        'tplWrapper' => '@INLINE
        {if $output}
        <div class="catalog-screen__products catalog-screen__products_first">
          <ul class="catalog-screen__items">
            {$output}
            <li class="catalog-screen__item catalog-screen__item_type_more"></li>
          </ul>
        </div>
        {/if}',
        'idTagsBlock' => 'block-2',
        'where' => '{"template:in":[27]}',
        ]}

        {'@FILE snippets/getTags.php' | snippet :[
        'tpl' => '@FILE chunks/create-menu/category-item.tpl',
        'tplWrapper' => '@INLINE
        {if $output}
        <div class="catalog-screen__products catalog-screen__products_second">
          <ul class="catalog-screen__items">
            {$output}
            <li class="catalog-screen__item catalog-screen__item_type_more"></li>
          </ul>
        </div>
        {/if}',
        'idTagsBlock' => 'block-3',
        'where' => '{"template:in":[28]}',
        ]}
      {/if}
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

      {if $_modx->context.key == 'trotuarnaya-plitka'}
        {include "file:sections/banners/trotuarnaya-plitka.tpl" small_banner_hide=true}
      {else}
        {switch $_modx->resource.context_key}
          {case 'web'}
            {set $text = 'Закажите утеплитель сейчас<br>и получите <span class="text-highlighter">скидку 30%</span><br>на доставку'}
          {case 'gazosilikatstroy'}
            {set $text = 'Закажите газобетон сейчас<br>и получите <span class="text-highlighter">скидку 30%</span><br>на манипулятор'}
          {case 'kraska'}
            {set $text = 'Закажите краску сейчас<br>и получите <span class="text-highlighter">скидку 30%</span><br>на доставку'}
          {case 'suhiesmesi'}
            {set $text = 'Закажите сухие смеси сейчас<br>и получите <span class="text-highlighter">скидку 30%</span><br>на доставку'}
          {case 'krovelnyjstroymarket'}
            {set $text = 'Скидка 15% на изготовление металлочерепицы Grand line в размер'}
          {case 'tagnerud'}
            {set $text = 'Закажите керамзит сейчас<br>и получите <span class="text-highlighter">скидку 30%</span><br>на доставку'}
          {case 'gbi-zavod78'}
            {set $text = 'Закажите дорожные плиты сейчас<br>и получите <span class="text-highlighter">скидку 20%</span><br>на доставку'}
          {case 'kirpich-m5'}
            {set $text = 'Закажите кирпич сейчас<br>и получите <span class="text-highlighter">скидку 30%</span><br>на доставку'}
            {set $img = 'assets/template/pictures/catalog/'~$_modx->resource.context_key~'/delivery.jpg'}
            {set $img_mob = 'assets/template/pictures/catalog/'~$_modx->resource.context_key~'/delivery.jpg'}
          {case default}
            {set $text = 'Закажите продукцию сейчас<br>и получите <span class="text-highlighter">скидку 30%</span><br>на доставку'}
        {/switch}
        {if !$img}
          {set $img = 'assets/template/pictures/main-screen/'~$_modx->resource.context_key~'/main-screen.jpg'}
        {/if}
        {if !$img_mob}
          {set $img_mob = 'assets/template/pictures/main-screen/'~$_modx->resource.context_key~'/main-screen-mob.jpg'}        
        {/if}
      <div class="banner">
        <picture class="banner__bg">
          {set $file = $img_mob | replace : '.jpg': '.webp'}
          {if ('@FILE snippets/fileExists.php' | snippet : ['input' => $file])}
            <source srcset="{$file}" media="(max-width: 768px)">
          {/if}
          <source srcset="{$img_mob}" media="(max-width: 480px)">
          {set $file = $img | replace : '.jpg': '.webp'}
          {if ('@FILE snippets/fileExists.php' | snippet : ['input' => $file])}
            <source srcset="{$file}">
          {/if}
          <img class="banner__bg-img" src="{$img}">
        </picture>
        <div class="banner__title">
          {$text}
        </div>
        <p class="banner__text">Акция до конца месяца</p>
        <div class="banner__action"><span data-fancybox data-src="#callback" class="banner__btn btn btn_style_yellow">Заказать со скидкой</span></div>
      </div>
      {/if}

    </div>
  </div>
</section>
