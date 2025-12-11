<section class="section catalog-tiled">
  <div class="catalog-tiled__container" itemscope itemtype="https://schema.org/Collection">
  <meta itemprop="name" content="Каталог товаров для кровли">
  {set $params = [
    'depth' => 0,
    'limit' => 0,
    'tpl' => '@FILE modules/catalog-tiled/chunks/item.tpl',
    'where' => '{"template:IN":[5,36]}',
    'includeTVs' => 'mainImage',
    'tvPrefix' => ''
  ]}

  {set $resources = '171121,171134,313901,314877,314878,314879,314880,314881,314882,314883,314884,315199'}
  {set $params['resources'] = $resources}
  {set $params['parents'] = 0}
  {set $params['sortby'] = 'FIELD(modResource.id, ' ~ $resources ~ ')'}
  {set $params['sortdir'] = 'ASC'}

  {$_modx->runSnippet('pdoResources', $params)}
  </div>
</section>