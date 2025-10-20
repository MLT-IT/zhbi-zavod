<div class="h-menu header__catalog menugen_v2--catalog" data-dropdown>
    <button class="h-menu__btn btn btn_style_base">Каталог</button>
    <div class="h-menu__dropdown">
        <a class="h-menu__link-to-catalog" href="/catalog/">Перейти в каталог</a>
        <div class="h-catalog">
          <div class="menu">
              <ul class="menu__list">
                  {foreach $data as $item index=$index}
                      <li class="{$item['class']}">
                          <a href="{$item['link']}" class="menu__item {if $index==0}active{/if}" data-submenu="submenu-{$index}">
                              <div class="ico_wrapper">
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

          <div class="submenu" data-level="2">
              {foreach $data as $item index=$index}
                  <ul class="submenu__list {if $index==0}active{/if}" id="submenu-{$index}">
                      {foreach $item['children'] as $child}
                          <li><a href="{$child['link']}" class="submenu__item">{$child['title']}</a></li>
                      {/foreach}
                      {foreach $item['spoiler'] as $schild}
                          <li class="submenu__spoiler-li"><a href="{$schild['link']}" class="submenu__item">{$schild['title']}</a></li>
                      {/foreach}
                      {if $item['spoiler']}<li><a href="#" class="submenu__spoiler-btn">Показать еще</a></li>{/if}
                  </ul>
              {/foreach}
          </div>
        </div>
    </div>
</div>
