{extends "file:layouts/default.layout.tpl"}

{block "page"}
<main class="layout__main">
    {include "file:chunks/breadcrumbs/breadcrumbs.tpl"}

    <div class="warehouse-page">
        <div class="wrapper">
            <section class="warehouse-contacts">
            <div class="warehouse-contacts__contacts">
                <h2 class="contacts__title section__title">{$_modx->resource.pagetitle}</h2>
                <ul class="contacts__list">
                <li class="contacts__item">
                    <div class="contact__title"><span>Часы работы</span></div>
                    <div class="contact__value">Ежедневно с 8:00 до 21:00</div>
                </li>
                <li class="contacts__item">
                    <div class="contact__title"><span>Телефон</span></div>
                    <a
                    class="contact__value"
                    href="tel:{$_modx->getPlaceholder('localdata').offices.0.phone}"
                    >
                    <span itemprop="telephone">
                        {$_modx->getPlaceholder('localdata').offices.0.phone}, доб. 1
                    </span>
                    </a>
                </li>
                </ul>
                <div class="warehouse-contacts__controls">
                <div
                    class="btn btn_size_small btn_style_trans"
                    data-src="#callback"
                    data-fancybox=""
                >
                    РАССЧИТАТЬ СТОИМОСТЬ ДОСТАВКИ
                </div>
                <div
                    class="btn btn_style_shadow"
                    data-src="#callback"
                    data-fancybox=""
                >
                    ОСТАВИТЬ ЗАЯВКУ НА САМОВЫВОЗ
                </div>
                </div>
            </div>
            <div class="warehouse-contacts__photo">
                {if $_modx->resource.mainImage}
                <img
                alt="{$_modx->resource.pagetitle}"
                src="{$_modx->resource.mainImage}"
                />
                {/if}
            </div>
            </section>
            
            {set $items = "@FILE _modules/warehouses/snippets/selection-items.php" | snippet}
           


            {if $items}
                {set $date = $_modx->runSnippet("@FILE snippets/getCurrentDate.php", ["modifyDate" => "0 day"])}
                {foreach $items as $index => $item}
                    {set $pdoid = 'pdopage_'~$index}
                    {set $pdonav = 'page_'~$index}

                    <div class="warehouse-table" id="{$pdoid}">
                        <div class="warehouse-table__header">
                            <h2>{$item['title']} на {$date}</h2>
                        </div>

                        {set $range_remains = $_modx->resource.range_remains}
                        {if $range_remains}
                            {$_modx->setPlaceholder('range-remains', $range_remains | split : '-')}
                        {/if}

                        <div class="table-wrapper">
                            <table class="table centered">
                                <thead>
                                    <tr>
                                        <th class="pricetable-col">Товар</th>
                                        <th class="pricetable-col">Количество в наличии</th>
                                    </tr>
                                </thead>
                                <tbody class="rows">
                                    {'!pdoPage' | snippet :[
                                        'parents' => $item['parents'],
                                        'where' => '{"class_key":"msProduct"}',
                                        'limit' => 10,
                                        'sortby' => '{"priority1":"ASC", "HitsPage":"ASC"}',
                                        'includeTVs' => 'priority1,HitsPage',
                                        
                                        'tpl' => '@FILE _modules/warehouses/chunks/product-on-warehouse.tpl',
                                        'tplWrapper' => '@INLINE {$output}',
                                        'ajaxTplMore' => '@INLINE <button class="btn btn-default btn-more">Показать еще</button>'
                                        
                                        'ajaxMode' => 'button',
                                        
                                        'pageNavVar' => $pdonav,
                                        'pageVarKey' => $pdonav,

                                        'ajaxElemWrapper' => '#'~$pdoid,
                                        'ajaxElemRows' => '#'~$pdoid~' .rows',
                                        'ajaxElemPagination' => '#'~$pdoid~' .pagination',
                                        'ajaxElemMore' => '#'~$pdoid~' .btn-more',
                                        'ajaxElemLink' => '#'~$pdoid~' .pagination a',
                                    ]}
                                </tbody>
                            </table>
                        </div>

                        {$_modx->getPlaceholder($pdonav)}
                    </div>
                {/foreach}
            {/if}
        </div>
    </div>

</main>

{/block}
