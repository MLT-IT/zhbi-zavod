{set $catalogId = $_modx->runSnippet('@FILE snippets/getIdByAlias.php', ['alias' => 'catalog'])}
<!--<p>CATALOG ID: {$catalogId}</p>
<p>RESOURCE: {$_modx->resource.id}</p>
<p>PARENT: {$_modx->resource.parent}</p>
<p>HERE: {$catalogId == $_modx->resource.parent ? $_modx->resource.id : $_modx->resource.parent}</p>
-->
{set $sourceBasePath =  $_modx->runSnippet('@FILE snippets/getTvSourceBasePath.php', ['tvName' => 'mainIcon'])}
    <section class="catalog-v1 assort wrapper assort_active_content assort__container">
        <div class="catalog-v1_wrapper assort__tabs">
            <div class="catalog-v1_menu_wrapper assort__sidebar">
                {set $here = ($catalogId == $_modx->resource.parent) ? $_modx->resource.id : $_modx->resource.parent}
                {$_modx->runSnippet('!pdoMenu',[
                    'parents' => $catalogId,
                    'class_key' => 'msCategory',
                    'level' => 1,
                    'depth' => 0,
                    'limit' => 20,
                    'includeTVs' => 'mainImage, mainIcon, menuindex',
                    'processTVs' => 1,
                    'tvPrefix' => '',
                    'sortby' => '{"menuindex":"ASC"}',
                    'hereId' => $here,
                    'tpl' => '@INLINE 
                        <a href="{$_modx->makeUrl($id)}" class="assort__sidebar-item1">
                            <img class="assort__svg" src="{$sourceBasePath~($mainIcon ?: $mainImage)}" alt="">
                            {$menutitle}
                        </a>
                    ',
                    'tplHere' => '@INLINE 
                        <a href="{$_modx->makeUrl($id)}" class="assort__sidebar-item1 active">
                            <img class="assort__svg" src="{$sourceBasePath~($mainIcon ?: $mainImage)}" alt="">
                            {$menutitle}
                        </a>
                    ',

                ])}
            </div>
            <div class="catalog-v1_categories_wrapper assort__contents-wrap">
                <div class="assort__content-wrap columns-flex active">
                    <div class="assort__content assort__content_columns-flex">
                        {* <div class="assort__back">
                            <span class="assort__back-btn"></span>
                            <span class="assort__back-text">Назад</span>
                        </div> *}

                        {$_modx->runSnippet('!pdoResources',[
                            'parents' => $_modx->resource.id,
                            'class_key' => 'msCategory',
                            'level' => 1,
                            'depth' => 0,
                            'limit' => 100,
                            'includeTVs' => 'mainImage, mainIcon, menuindex',
                            'tvPrefix' => '',
                            'processTVs' => 1,
                            'sortby' => '{"menuindex":"ASC"}',
                            'tplOuter' => '@INLINE {$wrapper}',
                            'tpl' => '@FILE modules/catalog/v1/category_item.tpl' 
                        ])}
                        {* 
                        'processTVs' => 1,
                        *}
                    </div>
                </div>
            </div>
        </div>
    </section>
