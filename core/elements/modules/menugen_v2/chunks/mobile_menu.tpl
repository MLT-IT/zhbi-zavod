<nav class="header__nav js-mobile_menu_v4 mobile_menu_v4">
    <div class="header__nav-contents-wrap">
        <div class="header__nav-content header__nav-content_type_main active" data-key="-1">
            
            {if isset($data["meta"]["title"]) && !empty($data["meta"]["title"])}
                <div class="header__nav-text">{$data["meta"]["title"]}</div>
            {/if}
            {if isset($data["meta"]["catalog"]) && $data["meta"]["catalog"]}
                <span class="header__nav-header header__mobile-menu-link header__mobile-menu-arrow header__mobile-menu-arrow_color_1" data-key="0">
                    <span class="header__nav-header-burger burger">
                        <span class="burger__stick"></span>
                        <span class="burger__stick"></span>
                        <span class="burger__stick"></span>
                    </span>
                    Каталог
                </span>
            {/if}
			
			
			{foreach $data["menu"] as $item}
                <span class="header__nav-item">
                    <a class="header__nav-link" href="{$item['url']}">
                        {$item["title"]}
                    </a>
                </span>
            {/foreach}

            
        </div>
        {foreach $catalog as $catalog_group}
                <div class="js-header__nav-content header__nav-content" data-key="{$catalog_group['key']}">
                    <span class="header__nav-item header__nav_back">
                        <span data-key="{$catalog_group['back']}" class="header__nav-link header__mobile-menu-link header__mobile-menu-arrow header__mobile-menu-arrow_color_2 header__mobile-menu-arrow_reverse">
                            Назад
                        </span>
                    </span>
                    <span class="header__nav-item header__nav_title">
                        <a class="header__nav-link " href="{$catalog_group['link']}">
                            {$catalog_group['title']}
                        </a>
                    </span>
                    
                    {foreach $catalog_group.menu as $menu_item}
                        {if $menu_item.child>-100}
                            <span class="header__nav-item header__mobile-menu-arrow header__mobile-menu-arrow_color_2">
                                {if isset($menu_item['img'])}
                                    <div class="ico_wrapper"><img src="{$menu_item['img']}" alt=""></div>
                                {/if}
                                <span data-key="{$menu_item.child}" class="header__mobile-menu-link header__nav-link">
                                    {$menu_item.title}
                                </span>
                            </span>
                        {else}
                            <span class="header__nav-item">
                                {if isset($menu_item['img'])}
                                    <div class="ico_wrapper"><img src="{$menu_item['img']}" alt=""></div>
                                {/if}
                                <a class="header__nav-link" href="{$menu_item.link}">
                                    {$menu_item.title}
                                </a>
                            </span>
                        {/if}
                    {/foreach}
                    {foreach $catalog_group.spoiler as $spoiler_item}
                        <span class="js-header__nav-spoiler-item header__nav-spoiler-item">
                            <a class="header__nav-link" href="{$spoiler_item.link}">
                                {$spoiler_item.title}
                            </a>
                        </span>
                    {/foreach}
                    {if $catalog_group.spoiler}
                        <span class="header__nav-item">
                            <a href="#" class="js-header__nav-spoiler header__nav-spoiler">Показать еще</a>
                        </span>
                    {/if}
                </div>
        {/foreach}
    </div>
</nav>