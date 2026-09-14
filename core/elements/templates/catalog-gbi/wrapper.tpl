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
        </div>
      </article>
    </section>

    {set $catalog = '@FILE modules/catalog/snippets/catalogFromDatabase.php' | snippet : ['parent_id' => $_modx->resource.id]}
    {if $_modx->resource.alias == 'catalog'}
      {include 'file:modules/catalog/v1/catalog_v1.tpl'}
    {else}
      {include 'file:modules/catalog/v1/category_v1.tpl'}
    {/if}

    {include "file:sections/delivery/wrapper.tpl" styleClass='section_view_bg'}
    {insert "file:sections/payment/wrapper.tpl"}
    {include "file:modules/contacts-block/wrapper.tpl" styleClass='section_view_bg'}
  </main>
{/block}
