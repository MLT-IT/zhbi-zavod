<div class="h-menu header__catalog menugen_v2--catalog" data-dropdown>
    <button class="h-menu__btn btn btn_style_base">Каталог</button>
    <div class="h-menu__dropdown">
        <a class="h-menu__link-to-catalog" href="/catalog/">Перейти в каталог</a>
        <div class="h-catalog">
          <div class="h-catalog__menu">
              <ul class="h-catalog__menu-list">
                  {foreach $data as $item index=$index}
                      <li class="{$item['class']}">
                          <a href="{$item['link']}" class="h-catalog__menu-item {if $index==0}active{/if}" data-submenu="submenu-{$index}">
                              <div class="h-catalog__ico_wrapper">
                                  {if isset($item['img'])}
                                      <img src="{$item['img']}" alt="">
                                  {/if}
                              </div>
                              {$item['title']}
                          </a>
                      </li>
                  {/foreach}
              </ul>
          </div>

          <div class="h-catalog__submenu" data-level="2">
              {foreach $data as $item index=$index}
                  <ul class="h-catalog__submenu-list {if $index==0}active{/if}" id="submenu-{$index}">
                      {foreach $item['children'] as $child}
                          <li><a href="{$child['link']}" class="h-catalog__submenu-item">{$child['title']}</a></li>
                      {/foreach}
                      {foreach $item['spoiler'] as $schild}
                          <li class="h-catalog__submenu-spoiler-li"><a href="{$schild['link']}" class="h-catalog__submenu-item">{$schild['title']}</a></li>
                      {/foreach}
                      {if $item['spoiler']}<li><a href="#" class="h-catalog__submenu-spoiler-btn">Показать еще</a></li>{/if}
                  </ul>
              {/foreach}
          </div>
        </div>
    </div>
</div>
