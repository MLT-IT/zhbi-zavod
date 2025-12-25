{extends "file:layouts/base.tpl"} 

{block 'page-content'}
    {include "file:sections/breadcrumbs/wrapper.tpl"}

    <div class="section-margin">
        <div class="container">
            <h1 class="section-title">{$_modx->resource.pagetitle}</h1>
            <div class="page-content">
        {'!SimpleSearch' | snippet : [
            'containerTpl' => '@INLINE 
            <p class="simplesearch-results fs-24-17">{$resultInfo}</p>

            <div class="simplesearch-results-list">
                {$results}
            </div>

            <div class="simplesearch-paging">
                <span class="simplesearch-result-pages">Страницы с результатами поиска:</span>
                {$paging}
            </div>
            '
            'tpl' => '@INLINE 
            <div class="simplesearch-result">
                <div class="fs-24-17">{$idx}. <a href="{$link}" title="{$longtitle}" class="fw-700 fs-24-17">{$pagetitle}</a></div>
                <div class="extract">
                    <p>{$extract}</p>
                </div>
            </div>
            '
        ]}
            </div>
        </div>
    </div>

{/block}