<div class="sect-mainlist__filter">
    <form action="{$_modx->resource.id | url}" method="post" id="mse2_filters" class="listing__filter-form">
        <div class="listing__filters-header">
            Фильтры
            <span class="listing__close-filter-btn"></span>
        </div>
        {if $filters != 'Нечего фильтровать'}
            {$filters}
        {/if}
        <button type="reset" style="display: none;" class="listing__reset-filters-action">Сбросить</button>
    </form>
    <div class="listing__filter-btn"></div>
</div>
