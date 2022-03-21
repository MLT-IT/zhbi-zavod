<div class="listing__products">
    {include "file:sections/category/listing-tags.tpl"}

    {set $tags = $_modx->getPlaceholder('tags')}
    {set $chipsClass = ''}
    {if $tags ?}
        {$_modx->getPlaceholder('tags')}
        {set $chipsClass = ' above-tags'}
    {/if}

    <div class="listing__selected-wrap" id="mse2_selected_wrapper">
        <div class="listing__selected{$chipsClass}" id="mse2_selected"></div>
    </div>

    <div class="listing__sort">
        {*
        <span class="listing__reset-filters">Сбросить фильтры</span>
        *}

        <div id="mse2_sort" class="listing__sort-list"><span>Сортировать: </span>
            <a href="#" data-sort="tv|HitsPage" data-dir="" class="listing__sort-item min{if $.get.sort == ''} active{/if}">по популярности</a>
            <a href="#" data-sort="ms|price" data-dir="" data-default="desc" class="listing__sort-item_with-arrow listing__sort-item min{if $.get.sort == 'ms|price:desc'} active{/if}">по цене</a>
            <a href="#" data-sort="ms_product|pagetitle" data-dir="" data-default="desc" class="listing__sort-item_with-arrow listing__sort-item min{if $.get.sort == 'ms_product|pagetitle:desc'} active{/if}">по алфавиту</a>
        </div>
        <div class="listing__sort-select-container"> <span>Сортировать: </span>
            <div class="listing__sort-select">
                <select class="listing__sort-select-elem" name="sort">
                    <option value="1">по популярности</option>
                    <option value="2">по цене ↓</option>
                    <option value="3">по цене ↑</option>
                    <option value="4">по алфавиту</option>
                </select>
            </div>
        </div>
        {*
        <div class="listing__sort-grid">
            <svg class="svg icon-lines" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-lines"></use>
            </svg>
            <svg class="svg icon-grid active" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-grid"></use>
            </svg>
        </div>
        *}
    </div>
    <div class="listing__products-list rows grid" id="mse2_results">
        {$results}
    </div>

    {'!AjaxForm' | snippet : [
        'hooks' => 'create_bitrix_lead',
        'snippet' => 'FormIt',
        'form' => '@FILE sections/catalog/catalog-banner.tpl',
        'customValidators' => 'checkPhone',
        'validate' => 'PHONE:required:checkPhone',
        'validationErrorMessage' => 'В форме содержатся ошибки!',
        'successMessage' => 'Сообщение успешно отправлено',
    ]}

    <div class="mse2_pagination">
        {$pagenav}
    </div>
    <div class="hidden-data">
        <span id="mse2_total">{$total ?: 0}</span>
    </div>
</div>
