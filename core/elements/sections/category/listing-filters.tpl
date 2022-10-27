{* <div class="listing__filter-button active"></div> *}
<div class="listing__filter" data-dropdown=".listing__filter-block-header">

    {* Меню перед фильтрами *}
    {*
    {include "file:sections/category/listing-menu.tpl"}
    *}

    <form action="{$_modx->resource.id | url}" method="post" id="mse2_filters" class="listing__filter-form">
        <div class="listing__filters-header">
            Фильтры
            <span class="listing__close-filter-btn"></span>
        </div>
        {if $filters != 'Нечего фильтровать'}
            {$filters}
        {/if}

        {*
        {* Если фильтров было больше 5, значит, контейнер со скрытыми фильтрами открыт. Надо закрыть его
        {if $_modx->getPlaceholder('filter_iterator') > 5}
          </div>
          <span class="listing__btn listing__more-filters-btn" data-text="Скрыть">Показать больше</span>
        {/if}
        *}

        <button type="reset" style="display: none;" class="listing__btn listing__reset-filters-action">Сбросить</button>
    </form>

    <div class="listing__filter-btn"></div>
</div>
