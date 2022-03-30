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

{if $_modx->resource.context_key == 'armatura-178'}
    {set $params['where'] = '{"hidemenu:=": 0}'}
{/if}

{'!pdoResources' | snippet : $params}
