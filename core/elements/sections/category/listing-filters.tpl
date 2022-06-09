{* <div class="listing__filter-button active"></div> *}
<div class="listing__filter" data-dropdown=".listing__filter-block-header">
    {include "file:sections/category/listing-menu.tpl"}
    <form action="{$_modx->resource.id | url}" method="post" id="mse2_filters" class="listing__filter-form">
        {if $filters != 'Нечего фильтровать'}
            {$filters}
        {/if}
        <button type="reset" style="display: none;" class="listing__reset-filters-action">Сбросить</button>

    </form>

    <div class="listing__filter-btn"></div>
    <div class="listing__close-filter-btn"></div>

</div>
