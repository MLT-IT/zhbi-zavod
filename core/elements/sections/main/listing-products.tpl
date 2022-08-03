{*
data-default - какое направление сортировки будет, когда нажмем на ссылку в первый раз (то есть когда данная сортировка еще не активна).
data-dir - какое направление сейчас.
data-single-dir - запретить менять направление сортировки, нажимая по ней второй раз?
*}

<div class="listing__sort sect-mainlist__sort">
    {* <span class="listing__reset-filters">Сбросить фильтры</span> *}
    <div id="mse2_sort" class="listing__sort-list"><span>Сортировать: </span>
        {if $_modx->resource.context_key in list ['pro-fanera', 'kirpich-m', 'plitaosb', 'plity-mdvp']}
            <a href="#" data-sort="tv|HitsPage" data-dir="" data-default="desc" class="listing__sort-item min{if $.get.sort == 'tv|HitsPage'} active{/if}" data-single-dir="1">по популярности</a>
            <a href="#" data-sort="ms|price" data-dir="{if $.get.sort == ''}asc{/if}" data-default="asc" class="listing__sort-item_with-reverse-arrow listing__sort-item min{if $.get.sort == ''} active{/if}">по цене</a>
        {else}
            <a href="#" data-sort="" data-dir="" class="listing__sort-item min{if $.get.sort == ''} active{/if}" data-single-dir="1">по популярности</a>
            <a href="#" data-sort="ms|price" data-dir="" data-default="desc" class="listing__sort-item_with-arrow listing__sort-item min{if $.get.sort == 'ms|price:desc'} active{/if}">по цене</a>
        {/if}
        <a href="#" data-sort="ms_product|pagetitle" data-dir="" data-default="desc" class="listing__sort-item_with-arrow listing__sort-item min{if $.get.sort == 'ms_product|pagetitle:desc'} active{/if}">по алфавиту</a>
    </div>
    <div class="listing__sort-select-container">{*<span>Сортировать: </span>*}
        <div class="listing__sort-select">
            <select class="listing__sort-select-elem" name="sort">
                <option value="1">по популярности</option>
                <option value="2">по цене ↓</option>
                <option value="3">по цене ↑</option>
                <option value="4">по алфавиту</option>
            </select>
        </div>
    </div>
</div>

<div class="listing__products-list rows grid js-catalog" id="mse2_results">
    {$results}
</div>
<div class="mse2_pagination">
    {$pagenav}
</div>

<div class="hidden-data">
    <span id="mse2_total">{$total ?: 0}</span>
</div>
