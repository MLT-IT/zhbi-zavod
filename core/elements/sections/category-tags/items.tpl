{if $items}
    {set $limit_items = 9}

    <div class="category-tags__items" data-opened-element="category-tags{$group_index}">
        {foreach $items as $index => $category}
            {set $thumb = 'phpthumbof' | snippet : [
                'input' => "{$category['main_image']}",
                'options' => '&w=80&zc=1&bg=ffffff'
            ]}
            <a class="category-tags__item {if $index >= $limit_items}hidden{/if}" href="{$category['uri']}">
                <img class="category-tags__item-image" src="{$thumb}" />
                {$category['menutitle']}
            </a>
        {/foreach}

        {if count($items) >= $limit_items}
            <button class="category-tags__item show-more color-red" data-opened-btn="category-tags{$group_index}" data-active-text="Скрыть">
                Показать все
            </button>
        {/if}
    </div>
{/if}