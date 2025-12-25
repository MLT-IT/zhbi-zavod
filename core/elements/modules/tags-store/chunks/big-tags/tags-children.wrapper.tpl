{* Теги - подкатегории *}

{* Выборка дочерних подкатегорий *}
{if $_modx->getPlaceholder('context.category_template_id')}
    {set $categories = "@FILE modules/map-resources/mapGetResourcesByWhere.php" | snippet : [
        'data' => $_modx->getPlaceholder('map-resources.category'),
        'where' => '{"parent":'~$_modx->resource.id~',"template":'~$_modx->getPlaceholder('context.category_template_id')~'}'
    ]}

    {if $categories}
        {set $limit_items = 9}

        <div class="big-tags__items" data-opened-element="big-tags{$group_index}">
            {foreach $categories as $index => $category}
                {if $index >= $limit_items}
                    {set $class_names = "hidden"}
                {/if}

                {include "file:modules/tags-store/chunks/common/tag.item.tpl" category=$category class_names=$class_names}
            {/foreach}

            {if count($categories) > $limit_items}
                <button class="tags__item show-more color-red nohover" data-opened-btn="big-tags{$group_index}" data-active-text="Скрыть">
                    Показать все
                </button>
            {/if}
        </div>
    {/if}
    
{else}
    Не найдена опция category_template_id
{/if}