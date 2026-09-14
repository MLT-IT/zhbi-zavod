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

  {if $_modx->resource.groupingTags}
    {set $tags = "@FILE snippets/groupingTags.php" | snippet : [
    'tplItem' => '@INLINE<li class="catalog-screen__tag">
                            <a href="/{$uri}" class="catalog-screen__tag-link">
                              <div class="catalog-screen__tag-picture">
                                {if $image}
                                <img class="catalog-screen__tag-image" src="{$image}" />
                                {/if}
                              </div>
                              <div class="catalog-screen__tag-name">
                                {$name ?: $menutitle ?: $pagetitle}
                              </div>
                            </a>
                          </li>'
    'tplFirstItems' => '@INLINE <ul class="catalog-screen__items items-hidden" data-grouping-tags-first>{$items}<li class="catalog-screen__tag catalog-screen__tag_type_more" data-tag-show-more-btn data-grouping-tags-toggle style="display: flex;align-items: center;"></li></ul>'
    'tplItems' => '@INLINE <h2 class="section__title">{$group_title}</h2>
                           <ul class="catalog-screen__items">
                             {$items}
                           </ul>'
    'tplOuter' => '@INLINE <div class="catalog-screen__products" id="grouping_tags_outer" style="display:none;">{$output}</div><div class="catalog-screen__products" id="grouping_tags_first_outer">{$output_first}</div> '
    ]}
  {else}
    {set $tags = '@FILE snippets/getTags.php' | snippet :[
      'tpl' => '@FILE chunks/create-menu/tags-item.tpl',
      'tplWrapper' => '@INLINE
                      {if $output}
                      <div class="catalog-screen__products">
                          <ul class="catalog-screen__items">
                              {$output}
                              <li class="catalog-screen__tag catalog-screen__tag_type_more" data-tag-show-more-btn></li>
                          </ul>
                      </div>
                      {/if}',
      'idTagsBlock' => 'block-1',
      'onlyCustomTags' => true
    ]}
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

          {if $_modx->resource.context_key == 'fibrofasad' && $_modx->resource.id == 125346}
            {insert "file:modules/catalog-tiled/sections/catalog-tiled.tpl"}
          {else}
            {$tags}
          {/if}
        </div>
      </article>
    </section>

    {include "file:templates/catalog/listing.tpl"}

    {*
    {switch $_modx->resource.context_key}
      {case 'web'}
        {include "file:sections/uteplitel-info/wrapper.tpl"}
      {case 'gazosilikatstroy'}
        {include "file:sections/gazobeton-info/wrapper.tpl"}
    {/switch}
    *}

    {include "file:sections/delivery/wrapper.tpl" styleClass='section_view_bg'}
    {if $_modx->resource.context_key == 'tagnerud'}
          {include "file:sections/tagnerud-info/wrapper.tpl"}
    {/if}
    {include "file:sections/payment/wrapper.tpl"}
    {include "file:modules/contacts-block/wrapper.tpl" styleClass='section_view_bg'}
  </main>
{/block}
