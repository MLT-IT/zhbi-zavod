{* Вынес в отдельный чанк, чтобы удобнее было работать *}

<nav class="header__nav">
    <div class="header__nav-contents-wrap">

        {* Первая вкладка (Основная) *}
        <div class="header__nav-content header__nav-content_type_main active" data-key="home">
            {* Заголовок *}
            <div class="header__nav-text">
                Поставка
                {if $_modx->context.key == 'krovlya'}
                    кровли
                {elseif $_modx->context.key == 'kirpich-m'}
                    кирпича
                {elseif $_modx->context.key == 'fasady-pro'}
                    деревянных фасадов
                {else}
                    утеплителя {$brand}
                {/if}
                по Санкт-Петербургу и Ленинградской области
            </div>

            {* Поиск *}
            <form action="/search/" class="header__search-wrap header__search-wrap_type_mobile">
                <input class="header__search" placeholder="Поиск по сайту" name="query">
                <button type="submit" class="header__search-btn"></button>
            </form>

            {* Кнопка Каталог *}
            <span class="header__nav-header header__mobile-menu-link header__mobile-menu-arrow header__mobile-menu-arrow_color_1" data-key="catalog">
                <span class="header__nav-header-burger burger">
                    <span class="burger__stick"></span>
                    <span class="burger__stick"></span>
                    <span class="burger__stick"></span>
                </span>
                Каталог
            </span>

            <span class="header__nav-item"><a class="header__nav-link" href="/dostavka-i-oplata/">Доставка и оплата</a></span>

            {set $certs = '@FILE snippets/getResourceByAlias.php' | snippet : ['alias' => 'certs']}
            {set $faq = '@FILE snippets/getResourceByAlias.php' | snippet : ['alias' => 'faq']}
            {set $akcii = '@FILE snippets/getResourceByAlias.php' | snippet : ['alias' => 'akcii']}
            {if $certs->hidemenu == 0}
                <span class="header__nav-item"><a class="header__nav-link" href="/certs/">Сертификаты</a></span>
            {/if}
            {if $faq->hidemenu == 0}
                <span class="header__nav-item"><a class="header__nav-link" href="/faq/">Вопросы-ответы</a></span>
            {/if}
            {if $akcii->hidemenu == 0}
                <span class="header__nav-item"><a class="header__nav-link" href="/akcii/">Акции</a></span>
            {/if}

            <span class="header__nav-item"><a class="header__nav-link" href="/contacts/">Контакты</a></span>
        </div>

        {* Вторая вкладка (Каталог) *}
        <div class="header__nav-content" data-key="catalog">
            {* Заголовок *}
            <div class="header__nav-text">Каталог</div>
            {* Кнопка назад *}
            <span class="header__nav-item"><span data-key="home" class="header__nav-link header__mobile-menu-link header__mobile-menu-arrow header__mobile-menu-arrow_color_2 header__mobile-menu-arrow_reverse">Назад</span></span>

            {* Кнопка для перехода в Каталог *}
            <a href="/catalog/" class="header__nav-header">
                Перейти в каталог
            </a>

            {* Кнопки фильтров *}
            {foreach $menu as $key => $nevermind}
                <span class="header__nav-item header__mobile-menu-arrow header__mobile-menu-arrow_color_2"><span data-key="{$key}" class="header__mobile-menu-link header__nav-link">{$key}</span></span>
            {/foreach}
        </div>

        {* Остальные вкладки (Фильтры) *}
        {foreach $menu as $key => $menuTypes}
            {* Вкладки *}
            <div class="header__nav-content" data-key="{$key}">
                {* Заголовок *}
                <div class="header__nav-text">{$key}</div>
                {* Кнопка назад *}
                <span class="header__nav-item"><span data-key="catalog" class="header__nav-link header__mobile-menu-link header__mobile-menu-arrow header__mobile-menu-arrow_color_2 header__mobile-menu-arrow_reverse">Назад</span></span>

                {* Пункты меню *}
                {foreach $menuTypes as $items}
                    {foreach $items as $item}
                        <span class="header__nav-item"><a class="header__nav-link" href="{$item.uri}">{$item.name}</a></span>
                    {/foreach}
                {/foreach}
            </div>
        {/foreach}
    </div>
</nav>
