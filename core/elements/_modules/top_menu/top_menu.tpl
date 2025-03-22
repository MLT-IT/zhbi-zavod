{set $items = '@FILE _modules/top_menu/top_menu.php' | snippet}
<nav class="header__nav">
  <ul class="h-nav">

    {foreach $items as $item}
      <li class="h-nav__item">
        <a class="h-nav__link text-white {$item.link_classes}" href="{$item.url}" {$item.attribs}>{$item.text}</a>
        {if $item.submenu}
          <div class="h-nav__subnav h-subnav">
            <ul class="h-subnav__wrapper">
              {foreach $item.submenu as $subitem}
                <li class="h-nav__item"><a class="h-nav__link {$subitem.link_classes}" href="{$subitem.url}">{$subitem.text}</a></li>
              {/foreach}
            </ul>
          </div>
        {/if}
      </li>
    {/foreach}
  </ul>
</nav>