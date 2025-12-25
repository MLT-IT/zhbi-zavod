<ul class="mobile-menu__list" data-menu="{$submenu_id}">
    {foreach $items as $item}
        <li class="mobile-menu__item">
            {if $item.type == 'submenu'}
                <a href="#" class="mobile-menu__link" data-submenu="{$item.submenu_id}">
                    {if $item.icon}
                        <div class="mobile-menu__icon">
                            <svg><use xlink:href="{$item.icon}"></use></svg>
                        </div>
                    {/if}
                    <span>{$item.title}</span>
                    <svg class="mobile-menu__arrow" width="24" height="24" viewBox="0 0 24 24" fill="none">
                        <path d="M9 18L15 12L9 6" stroke="#333" stroke-width="2"/>
                    </svg>
                </a>
            {else}
                <a href="{$item.url}" class="mobile-menu__link">
                    {if $item.icon}
                        <div class="mobile-menu__icon">
                            <svg><use xlink:href="{$item.icon}"></use></svg>
                        </div>
                    {/if}
                    <span>{$item.title}</span>
                </a>
            {/if}
        </li>
    {/foreach}
</ul>