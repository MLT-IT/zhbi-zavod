<div class="mobile-menu">
    <nav class="mobile-menu__nav">
        <div class="mobile-menu__header">
            <button class="mobile-menu__back">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                    <path d="M15 18L9 12L15 6" stroke="#333" stroke-width="2"/>
                </svg>
                <span>Назад</span>
            </button>
            <h3 class="mobile-menu__title">Меню</h3>
        </div>


        <ul class="mobile-menu__list active">
            {foreach $menu as $item}
                {if $item['submenu_id']}
                    <li class="mobile-menu__item">
                        <a href="#" class="mobile-menu__link {$item['class']}" data-submenu="{$item['submenu_id']}">
                            <span>{$item['title']}</span>
                            <svg class="mobile-menu__arrow" width="24" height="24" viewBox="0 0 24 24" fill="none">
                                <path d="M9 18L15 12L9 6" stroke="#333" stroke-width="2"/>
                            </svg>
                        </a>
                    </li>
                    {else}
                    <li class="mobile-menu__item">
                        <a href="{$item['url']}" class="mobile-menu__link {$item['class']}">
                            <span>{$item['title']}</span>
                        </a>
                    </li>

                {/if}
            {/foreach}
        </ul>


        {$submenus}
    </nav>
</div>
