<div class="burger-menu__link-to-catalog-wrap">
      <a class="h-menu__link-to-catalog h-menu__link-to-catalog_mobile" href="/catalog/">Перейти в каталог</a>
</div>
<div class="burger-menu__catalog">
  {set $params = [
    'depth' => 0,
    'limit' => 0,
    'tpl' => '@FILE chunks/create-menu/mobile-menu-item.tpl',
    'where' => '{"template:IN":[5,36]}',
    'includeTVs' => 'mainImage'
  ]}
  {switch $_modx->resource.context_key}
    {case 'web'}
      {set $params['parents'] = 4}
      {set $params['sortby'] = 'menuindex'}
      {set $params['sortdir'] = 'ASC'}
    {case 'gazosilikatstroy'}
      {set $resources = '101938,101936,101934,101932,101937,101929,101930,101933,101935,101931'}
      {set $params['resources'] = $resources}
      {set $params['parents'] = 0}
      {set $params['sortby'] = 'FIELD(modResource.id, ' ~ $resources ~ ')'}
      {set $params['sortdir'] = 'ASC'}
    {case 'gazoclone'}
      {set $resources = '303083,303106,303129,303178,303201,303236,303265,303287,303326,303349'}
      {set $params['resources'] = $resources}
      {set $params['parents'] = 0}
      {set $params['sortby'] = 'FIELD(modResource.id, ' ~ $resources ~ ')'}
      {set $params['sortdir'] = 'ASC'}
    {case 'kraska'}
      {set $params['parents'] = 102655}
    {case 'suhiesmesi'}
      {set $params['parents'] = 105697}
    {case 'krovelnyjstroymarket'}
      {set $resources = '125530,125532,125537,125541,125538,125536,125534,125535,125531,125540,125528,125539,125533,125529'}
      {set $params['resources'] = $resources}
      {set $params['parents'] = 0}
      {set $params['sortby'] = 'FIELD(modResource.id, ' ~ $resources ~ ')'}
      {set $params['sortdir'] = 'ASC'}
    {case 'fibrofasad'}
      {set $params['resources'] = '171123,171056,171132,171090,171124'}
    {case 'plitnye'}
      {set $params['parents'] = 177020}
      {set $params['depth'] = 0}
      {set $params['limit'] = 15}
      {set $params['sortby'] = 'menuindex'}
      {set $params['sortdir'] = 'ASC'}
    {case 'trotuarnaya-plitka'}
      {set $params['parents'] = 250499}
      {set $params['resources'] = '250500,250501,250502'}
  {/switch}
  {$_modx->runSnippet('pdoResources', $params)}
</div>
{if $_modx->context.key not in ['krovelnyjstroymarket', 'plitnye', 'web']}
<div class="burger-menu__link-to-catalog-wrap">
  <a class="h-menu__link-to-catalog h-menu__link-to-catalog_bottom h-menu__link-to-catalog_mobile btn btn_style_shadow" href="/catalog/">{$toCatalogBtnText}</a>
</div>
{/if}