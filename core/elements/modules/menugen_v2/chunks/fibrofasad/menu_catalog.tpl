<div class="h-menu header__catalog menugen_v2--catalog" data-dropdown>
    <button class="h-menu__btn btn btn_style_base">Каталог</button>
    <div class="h-menu__dropdown">
        <a class="h-menu__link-to-catalog" href="/catalog/">Смотреть все товары <span>&gt;</span></a>
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
                <div class="h-catalog__submenu-wrap {if $index==0}active{/if}" id="submenu-{$index}">
                  <p class="h-catalog__link-all-p"><a href="{$item.link}" class="h-catalog__link-all">{$item.linkTextAll}&nbsp;<span>&gt;</span></a></p>
                  <p class="h-catalog__brands">Бренды</p> 
                  <ul class="h-catalog__submenu-list" >
                      {foreach $item['children'] as $child}
                          <li class="h-catalog__submenu-item">
                            <a href="{$child['link']}" class="h-catalog__submenu-item-wrap">
                                <div class="h-catalog__submenu-item-img-wrap">
                                    <img class="h-catalog__submenu-item-img" src="{$child['img'] ?: 'assets/template/img/modules/menugen_v2/noimage.jpg'}">
                                </div>
                                <div class="h-catalog__submenu-item-text">
                                    {$child['title']}
                                </div>
                            </a>
                          </li>
                      {/foreach}
                      {foreach $item['spoiler'] as $schild}
                          <li class="h-catalog__submenu-spoiler-li"><a href="{$schild['link']}" class="h-catalog__submenu-item">{$schild['title']}</a></li>
                      {/foreach}
                      {if $item['spoiler']}<li><a href="#" class="h-catalog__submenu-spoiler-btn">Показать еще</a></li>{/if}
                  </ul>
                </div>
              {/foreach}
          </div>
        </div>
    </div>
</div>
