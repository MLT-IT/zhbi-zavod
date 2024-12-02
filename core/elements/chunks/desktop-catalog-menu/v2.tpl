{set $menu = '@FILE snippets/create-menu/createMenu.php' | snippet}

<div class="h-menu header__catalog" data-dropdown>
  <button class="h-menu__btn btn btn_style_base">Каталог</button>
  <div class="h-menu__dropdown">
    <a class="h-menu__link-to-catalog" href="/catalog/">Перейти в каталог</a>
    <div class="h-catalog-v2">
      <div class="h-catalog-v2-categories">
          <div class="h-catalog-v2__column">
            <div class="h-catalog-v2__column-header">{$menu['column1']['title']}</div>
            {foreach $menu['values'] as $catId => $catCols}
              <a href="{$catCols['column1']['uri']}" class="h-catalog-v2-item h-catalog-v2-item_main{$activeCatId ? '' : ' active'}" data-cat-id="{$catId}">
              {if $catCols['column1']['svg'] || $catCols['column1']['img'] || $catCols['column1']['img2']}
                <div class="h-catalog-v2-item__preview {if $_modx->resource.context_key in ['web']}h-catalog-v2-item__preview-wide{/if}">
                    {if $catCols['column1']['img'] is not empty}
                      {if $catCols['column1']['img2'] is not empty}
                        <img class="h-catalog-v2-item__image _norm" src="{$catCols['column1']['img']}">
                        <img class="h-catalog-v2-item__image _hov" src="{$catCols['column1']['img2']}">
                      {else}
                        <img class="h-catalog-v2-item__image" src="{$catCols['column1']['img']}">
                      {/if}
                    {elseif $catCols['column1']['svg'] is not empty}
                      <svg class="h-subinfo__svg" aria-hidden="true">
                        <use xlink:href="assets/template/pictures/icons.svg?{'file_version'|config}#{$catCols['column1']['svg']}"></use>
                      </svg>
                    {/if}
                </div>
              {/if}
                <span class="h-catalog-v2-item__name h-catalog-v2-item__name_bold{if $catCols['column1']['label']} h-catalog-v2-item__name_with_label{/if}">{$catCols['column1']['name']}</span>
              </a>
              {if $activeCatId is empty}
                  {set $activeCatId = $catId}
              {/if}
            {/foreach}
        </div>
      </div>
      <div class="h-catalog-v2-subcategories">
        {foreach $menu as $colKey => $colValues}
          {if $colKey in list ['values', 'column1']}
              {continue}
          {/if}
          <div class="h-catalog-v2__column">
            {if $colValues['uri']}
              <a class="h-catalog-v2__column-header" href="{$colValues['uri']}">{$colValues['title']}</a>
            {else}
              <div class="h-catalog-v2__column-header">{$colValues['title']}</div>
            {/if}
            
              {foreach $menu['values'] as $catId => $catCols}
                {if $colValues['type'] == 'composite'}
                  <div class="h-catalog-v2__parts-wrap">
                    {foreach $catCols[$colKey] as $parts}
                      <div class="h-catalog-v2__part">
                        {foreach $parts as $val}
                          <div class="h-catalog-v2-item h-catalog-v2-item_dependent{$activeCatId == $catId ? ' active' : ''}" data-cat-id="{$catId}">
                            <a href="{$val['uri']}" class="h-catalog-v2-item__name {if $val['hit']}product-hit{/if}">{$val['name']}</a>
                          </div>
                        {/foreach}
                      </div>
                    {/foreach}
                  </div>
                {else}
                    {foreach $catCols[$colKey] as $val}
                      <div class="h-catalog-v2-item h-catalog-v2-item_dependent{$activeCatId == $catId ? ' active' : ''}" data-cat-id="{$catId}">
                        <a href="{$val['uri']}" class="h-catalog-v2-item__name {if $val['hit']}product-hit{/if}">{$val['name']}</a>
                      </div>
                    {/foreach}
                {/if}
              {/foreach}
          </div>
        {/foreach}
      </div>
    </div>
  </div>
</div>