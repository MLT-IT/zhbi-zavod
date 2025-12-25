{* Теги - подкатегории *}

{* Выборка дочерних подкатегорий *}
{if $_modx->getPlaceholder('context.category_template_id')}
    {set $categories = "@FILE modules/map-resources/mapGetResourcesByWhere.php" | snippet : [
        'data' => $_modx->getPlaceholder('map-resources.category'),
        'where' => '{"parent":'~$_modx->resource.id~',"template":'~$_modx->getPlaceholder('context.category_template_id')~'}'
    ]}

    {include "file:sections/category-tags/items.tpl" items=$categories}
{else}
Не найдена опция category_template_id
{/if}