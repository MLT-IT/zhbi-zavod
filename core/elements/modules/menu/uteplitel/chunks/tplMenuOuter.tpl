<div class="menu-uteplitel">
    <div class="menu-uteplitel__top">
        <a class="menu-uteplitel__top-link" href="/catalog">Смотреть все товары</a>
    </div>
    <div class="menu-uteplitel__body">
        <!-- Левая часть -->
        <div class="menu-uteplitel__left">
            <!-- Каталог -->
            <div class="menu-uteplitel__catalog">
                {foreach $catalog as $item index=$index}
                    <a href="{$item.url}" class="menu-uteplitel__catalog-item {if $index == 0}active{/if}"  data-menu="{$index}">
                        {if $item.icon}
                            <img class="menu-uteplitel__catalog-item-icon" src="{$item.icon}">
                        {/if}
                        <span class="menu-uteplitel__catalog-item-text">{$item.name}</span>
                    </a>
                {/foreach}
            </div>
            <!-- Элементы меню -->
            <div class="menu-uteplitel__items">
                {foreach $items as $item index=$itemIndex}
                    {set $index = $itemIndex + count($catalog)}
                    <a href="{$item.url}" class="menu-uteplitel__item" data-menu="{$index}">
                        {if $item.icon}
                            <img class="menu-uteplitel__item-icon" src="{$item.icon}">

                        {/if}
                        <span class="menu-uteplitel__item-text">{$item.name}</span>
                    </a>
                {/foreach}
            </div>
        </div>

        <!-- Правая часть -->
        <div class="menu-uteplitel__right">
            {foreach $catalog as $item index=$index}
            <div class="menu-uteplitel__catalog-submenu {if $index == 0}active{/if}" data-submenu="{$index}">
                {if $item.header}
                    <div class="menu-uteplitel__header">
                        <div class="menu-uteplitel__header-submenu">
                            <div class="menu-uteplitel__header-title">
                                <a href="{$item.header.url}" class="menu-uteplitel__header-title-link">{$item.header.name}</a>
                            </div>
                        </div>
                    </div>
                {/if}
                <div class="menu-uteplitel__submenus">
                    <!-- Пример подменю -->
                    {foreach $item.options as $optionItems}
                        <div class="menu-uteplitel__submenu">
                            <div class="menu-uteplitel__submenu-title">{$optionItems.name}</div>
                            <div class="menu-uteplitel__submenu-options">
                                {foreach $optionItems.items as $option}
                                    <a href="{$option.url}" class="menu-uteplitel__submenu-option">{$option.name}</a>
                                {/foreach}
                            </div>
                            <div class="menu-uteplitel__submenu-more">
                                <div class="menu-uteplitel__submenu-more-button">
                                    Смотреть все
                                </div>
                            </div>
                        </div>
                    {/foreach}

                    <!-- Дублирующиеся подменю можно генерировать через шаблонизатор -->
                </div>

                <!-- Футер меню -->
                <div class="menu-uteplitel__footer">
                    {foreach $item.footer as $footer}
                        <div class="menu-uteplitel__footer-submenu">
                            <div class="menu-uteplitel__footer-title">
                                <a href="{$footer.url}" class="menu-uteplitel__footer-title-link">{$footer.name}</a>
                            </div>
                            <div class="menu-uteplitel__footer-links">
                                {foreach $footer.items as $footerItem}
                                    <a href="{$footerItem.url}" class="menu-uteplitel__footer-link">
                                        <img class="menu-uteplitel__footer-link-icon" src="{$footerItem.icon}">
                                        <span class="menu-uteplitel__footer-link-text">{$footerItem.name}</span>
                                    </a>
                                {/foreach}
                            </div>
                        </div>
                    {/foreach}

                </div>
            </div>
            {/foreach}
            {* Дублирующиеся подменю для нижних элементов *}
            {foreach $items as $item index=$itemIndex}
                {set $index = $itemIndex + count($catalog)}
                <div class="menu-uteplitel__catalog-submenu {if $index == 0}active{/if}" data-submenu="{$index}">

                    <div class="menu-uteplitel__submenus">
                        <!-- Пример подменю -->
                        {foreach $item.options as $optionItems}
                            <div class="menu-uteplitel__submenu">
                                <div class="menu-uteplitel__submenu-title">{$optionItems.name}</div>
                                <div class="menu-uteplitel__submenu-options">
                                    {foreach $optionItems.items as $option}
                                        <a href="{$option.url}" class="menu-uteplitel__submenu-option">{$option.name}</a>
                                    {/foreach}
                                </div>
                                <div class="menu-uteplitel__submenu-more">
                                    <div class="menu-uteplitel__submenu-more-button">
                                        Смотреть все
                                    </div>
                                </div>
                            </div>
                        {/foreach}

                        <!-- Дублирующиеся подменю можно генерировать через шаблонизатор -->
                    </div>

                    <!-- Футер меню -->
                    <div class="menu-uteplitel__footer">
                        {foreach $item.footer as $footer}
                            <div class="menu-uteplitel__footer-submenu">
                                <div class="menu-uteplitel__footer-title">
                                    <a href="{$footer.url}" class="menu-uteplitel__footer-title-link">{$footer.name}</a>
                                </div>
                                <div class="menu-uteplitel__footer-links">
                                    {foreach $footer.items as $footerItem}
                                        <a href="{$footerItem.url}" class="menu-uteplitel__footer-link">
                                            <img class="menu-uteplitel__footer-link-icon" src="{$footerItem.icon}">
                                            <span class="menu-uteplitel__footer-link-text">{$footerItem.name}</span>
                                        </a>
                                    {/foreach}
                                </div>
                            </div>
                        {/foreach}

                    </div>
                </div>
            {/foreach}
        </div>
    </div>

</div>