{extends "file:layouts/default.layout.tpl"}

{block 'schema'}
    {include "file:chunks/catalog-schema.tpl"}
{/block}

{block "page"}

  {if (($_modx->getPlaceholder('mspcs.option') is not empty) || ($_modx->getPlaceholder('mspcs.where') is not empty)) && ($_modx->resource.strictParent is empty)}
      {set $isSeoPage = 1}
  {else}
      {set $isSeoPage = 0}
  {/if}

  <main class="layout__main">
    <section class="section {if $tags is not empty}section_view_top{else}section_view_shrink{/if}">
      {include "file:chunks/breadcrumbs/breadcrumbs.tpl"}
      <article class="catalog-screen">
        <div class="catalog-screen__container">
          <h1 class="catalog-screen__title section__title">{$_modx->resource.pagetitle ?: $_modx->resource.menutitle} {if $.get.page > 1}(Страница {$.get.page}){/if}</h1>

          {if $_modx->resource.content && $_modx->resource.context_key not in list ['tagnerud'] }
            <div class="catalog-screen__text">
              {$_modx->resource.content}
            </div>
          {/if}

          {$tags}
        </div>
      </article>
    </section>

    
    <section class="section catalog-krovlya">
      <div class="catalog-krovlya__container" itemscope itemtype="https://schema.org/Collection">
      <meta itemprop="name" content="Каталог товаров для кровли">
      {set $params = [
        'depth' => 0,
        'limit' => 0,
        'tpl' => '@FILE chunks/catalog-krovlya-item.tpl',
        'where' => '{"template:=":"5"}',
        'includeTVs' => 'mainImage',
        'tvPrefix' => ''
      ]}

      {set $resources = '125530,125532,125537,125541,125538,125536,125534,125535,125531,125540,125528,125539,125533,125529'}
      {set $params['resources'] = $resources}
      {set $params['parents'] = 0}
      {set $params['sortby'] = 'FIELD(modResource.id, ' ~ $resources ~ ')'}
      {set $params['sortdir'] = 'ASC'}

      {$_modx->runSnippet('pdoResources', $params)}
      </div>
    </section>

    {include "file:sections/delivery.tpl" styleClass='section_view_bg'}
    {include "file:sections/payment.tpl"}
    {include "file:sections/contacts.tpl" styleClass='section_view_bg'}

  </main>
{/block}
