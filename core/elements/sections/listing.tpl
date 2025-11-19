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
      
      {if $_modx->resource.context_key == "krovelnyjstroymarket"}
        {include "file:_modules/category-product-rules/chunks/wrapper.tpl"}
      {/if}

        {* Старый вывод банеров до внедрения API *}
        {if $.get.old_banner}
          {include "file:sections/OLD_BANNER_SECTION.tpl"}
        {/if}
      

        {* Новый вывод *}
        {set $banner_data = "@FILE snippets/apiGetBanner.php" | snippet : [
          'resource_id' => $_modx->resource.id,
          'resource_parent' => $_modx->resource.parent,
          'banner_position' => 'category'
        ]}
        {set $banner_groups = $banner_data['data']}
        {if $banner_data['status'] && !empty($banner_groups)}
            {set $banner_group = $banner_groups[0]}

            {set $banners = $banner_group['banners_by_type']}
            {set $button_settings = $banner_group['button']}
            {set $button_classname = $banner_group['data']['button-classname']}

          <div class="category-banner">
            <picture>
              {if $banners['mobile']['image_url']}
                <source media="(max-width: 480px)" srcset="{$banners['mobile']['image_url']}">
              {/if}
              {if $banners['tablet']['image_url']}
                <source media="(max-width: 768px)" srcset="{$banners['tablet']['image_url']}">
              {/if}

              <img src="{$banners['desktop']['image_url']}" style="width:100%; height:auto;">
            </picture>

            <a class="category-banner__btn-desktop btn {$button_classname ?: 'btn_style_base'}" href="#callback" data-fancybox="">
              {$banners['desktop']['data']['button-text'] ?: "заказать со скидкой"}
            </a>
            <a class="category-banner__btn-tablet btn {$button_classname ?: 'btn_style_base'}" href="#callback" data-fancybox="">
              {$banners['tablet']['data']['button-text'] ?: "заказать со скидкой"}
            </a>
            <a class="category-banner__btn-mobile btn {$button_classname ?: 'btn_style_base'}" href="#callback" data-fancybox="">
              {$banners['mobile']['data']['button-text'] ?: "заказать со скидкой"}
            </a>
          </div>
          <style>
            .category-banner{
              position: relative;
            }
            .category-banner__btn-desktop,
            .category-banner__btn-tablet,
            .category-banner__btn-mobile{
              position: absolute;
              align-items: center;
              display: flex;
              margin: auto;
              width: max-content;
            }
            .category-banner__btn-desktop{
                /* Основные стили */
                {foreach $banners['desktop']['button'] as $key => $value}
                  {$key}:{$value};
                {/foreach}

                /* Дополнительные стили */
                {foreach $button_settings['desktop'] as $key => $value}
                  {$key}:{$value};
                {/foreach}
            }
            .category-banner__btn-tablet{
                display: none;

                /* Основные стили */
                {foreach $banners['tablet']['button'] as $key => $value}
                  {$key}:{$value};
                {/foreach}

                /* Дополнительные стили */
                {foreach $button_settings['tablet'] as $key => $value}
                  {$key}:{$value};
                {/foreach}
            }
            .category-banner__btn-mobile{
                display: none;

                /* Основные стили */
                {foreach $banners['mobile']['button'] as $key => $value}
                  {$key}:{$value};
                {/foreach}
                
                /* Дополнительные стили */
                {foreach $button_settings['mobile'] as $key => $value}
                  {$key}:{$value};
                {/foreach}
            }
            @media (max-width: 768px){
              .category-banner__btn-desktop{ display: none; }
              .category-banner__btn-tablet{ display: flex; }
            }
            @media (max-width: 480px){
              .category-banner__btn-tablet{ display: none; }
              .category-banner__btn-mobile{ display: flex; }
            }
          </style>
        {else}
          <!-- {$banner_groups | toJSON} -->
        {/if}

    </div>
  </div>
</section>
