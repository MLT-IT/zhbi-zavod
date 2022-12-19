{* Кажется, этот чанк нигде не используется. Вместо него теперь сниппет getTags *}

{set $params = [
  'parents' => $_modx->resource.id,
  'tpl' => '@FILE sections/category/listing-tags-item.tpl',
  'tplWrapper' => "@FILE sections/category/listing-tags-wrapper.tpl",
  'templates' => 5,
  'includeTVs' => 'mainImage',
  'sortby' => 'menuindex',
  'sortdir' => 'ASC',
  'limit' => 0,
  'depth' => 0,
  'select' => 'menutitle,uri'
]}

{*
{if $_modx->resource.template == 4}
    {set $params['depth'] = '0'}
{/if}
*}

{switch $_modx->resource.parent}
{case 13127}
{set $params['parents'] = 4}
{case 10987}
{set $params['parents'] = 3028}
{case 13128}
{set $params['parents'] = 3989}
{case 13129}
{set $params['parents'] = 4950}
{case 13130}
{set $params['parents'] = 5911}
{case 13131}
{set $params['parents'] = 6872}
{case 13132}
{set $params['parents'] = 7833}
{/switch}

{if $_modx->resource.context_key === 'armatura-178'}
    {set $params['where'] = '{"hidemenu:=": 0}'}
{/if}

{* Дополнительные теги для кровли *}
{set $extraTagsIdsArray = [56941,15436]}
{set $extraTagsIdsString = $extraTagsIdsArray | implode : ','}
{if $_modx->resource.context_key === 'krovlya' && $_modx->resource.template !== 4 && $_modx->resource.id not in list $extraTagsIdsArray}
    {* Получаем все категории-потомки для $extraTagsIds, чтобы проверить, может, текущий ресурс - это один из них? *}
    {set $excludeDescendantsIds = 'pdoResources' | snippet : [
      'parents' => $extraTagsIdsString,
      'where' => '{"template:=": "5"}',
      'depth' => 9000,
      'limit' => 0,
      'returnIds' => 1,
      'sortby' => 'id',
      'sortdir' => 'ASC',
    ]}
    {set $excludeDescendantsIds = $excludeDescendantsIds | split : ','}

    {* Если текущий ресурс - это не тот тег, который мы хотим добавить к основным. И не его потомок. То добавляем дополнительные теги *}
    {if $_modx->resource.id not in list $excludeDescendantsIds}
        {* Получаем id дочерних элементов текущей категории. Это необходимо для вывода основных тегов, т.к. теперь вывожу теги я через resources *}
        {set $resourcesIds = 'pdoResources' | snippet : [
        'parents' => $_modx->resource.id,
        'where' => '{"template:=": "5"}',
        'depth' => 0,
        'limit' => 0,
        'returnIds' => 1,
        ]}
        {if $resourcesIds ?}
            {set $resourcesIds = $resourcesIds ~ ','}
        {/if}
        {set $resourcesIds = $resourcesIds ~ $extraTagsIdsString}
        {set $params['resources'] = $resourcesIds}
        {set $params['parents'] = 0}
    {/if}
{/if}

{'!pdoResources' | snippet : $params}
