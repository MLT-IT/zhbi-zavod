{extends "file:layouts/base.tpl"} 

{block 'page-content'}
    {include "file:sections/breadcrumbs/wrapper.tpl"}

    <div class="section-margin">
        <div class="container">
            <h1 class="section-title">{$_modx->resource.pagetitle}</h1>
            <div class="page-content">
                {set $searchQuery = $.get.search ?: ''}

                {if $searchQuery}
                    {set $product_ids = '@FILE modules/fast-search/snippets/ajax.php' | snippet : [
                        'isInit' => 0,
                        'returnIds' => 1,
                        'searchQuery' => $searchQuery
                    ]}
чччч {$product_ids}
                    {if $product_ids}
                        {set $outer = '!pdoPage' | snippet :[
                            'element' => 'msProducts',
                            'parents' => 0,
                            'resources' => $product_ids,
                            'limit' => 24,
                            'includeThumbs' => 'webp',
                            'tpl' => '@FILE modules/product-cards/chunks/v1/wrapper.tpl',
                            'tplWrapper' => '@INLINE {$output}'
                            'ajaxMode' => 'button'
                        ]}

                        <p class="fs-24-17">Результаты поиска по запросу «{$searchQuery}»</p>

                        <div class="search-listing section-margin">
                            <div class="container">
                                <div class="search-listing__row">
            
                                    <div class="search-listing__content" id="pdopage">
                                        <div class="section-margin">
                                            <div class="search-listing__products rows">
                                                {$outer}
                                            </div>
                                            {'page.nav' | placeholder}
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>

                    {else}
                        <p class="fs-24-17">По запросу «{$searchQuery}» ничего не найдено.</p>
                    {/if}
                {else}
                    <p class="fs-24-17">Введите запрос в строке поиска.</p>
                {/if}
            </div>
        </div>
    </div>

{/block}