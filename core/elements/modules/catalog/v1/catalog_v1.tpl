{set $sourceBasePath = $_modx->runSnippet('@FILE snippets/getTvSourceBasePath.php', ['tvName' => 'mainIcon'])}
    <section class="catalog-v1 assort wrapper assort_active_sidebar assort__container">
        <div class="catalog-v1_wrapper assort__tabs">
            <div class="catalog-v1_menu_wrapper assort__sidebar">
                {foreach $catalog as $idx => $category}
                    {set $active = 'active'}
                    {if $idx > 0}{set $active = ''}{/if}
                    <span class="assort__sidebar-item" data-tab="{$category.assort_id}">
                        {* <svg class="assort__svg">
                            <use xlink:href="/assets/template/img/svg-sprite.svg?v=2.83#{$category.ico_id}"></use>
                        </svg> *}
                        <img class="assort__svg" src="{$category.ico_id}" alt="">
                        {$category.name}
                    </span>
                {/foreach}
            </div>
            <div class="catalog-v1_categories_wrapper assort__contents-wrap">
                {foreach $catalog as $idx => $category}
                    {set $active = 'active'}
                    {if $idx > 0}{set $active = ''}{/if}
                    <div class="assort__content-wrap columns-flex {$active}" data-tab="{$category.assort_id}">
                        <div class="assort__content assort__content_columns-flex">
                            <div class="assort__back">
                                <span class="assort__back-btn"></span>
                                <span class="assort__back-text">Категории ЖБИ</span>
                            </div>
                            <div class="assort__item assort__item_fullwidth">
                                <a href="{$category.link}" class="assort__item-title equal-margins">{$category.name}</a>
                            </div>
                            {foreach $category.childs as $child}
                                <div class="assort__item">
                                    <a href="{$child.link}" class="assort__item-img-wrap">
                                        <img class="assort__item-img" src="{$child.img}" alt="">
                                    </a>
                                    <a class="assort__item-title" href="{$child.link}">{$child.name}</a>
                                </div>
                            {/foreach}
                        </div>
                    </div>
                {/foreach}
                
            </div>
        </div>
    </section>
