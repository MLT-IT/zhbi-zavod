<form action="{$_modx->resource.id | url}" method="post" id="mse2_filters" class="sect-mainlist__filters-wrap">
    {if $filters != 'Нечего фильтровать'}
        {$filters}
    {/if}
    <button type="reset" style="display: none;" class="listing__reset-filters-action">Сбросить</button>
</form>
