<div class="listing__filter-button active"></div>
<div class="listing__filter" data-dropdown=".listing__filter-block-header">
    {include "file:sections/category/listing-menu.tpl"}
    <form action="{$_modx->resource.id | url}" method="post" id="mse2_filters">
        {if $filters != 'Нечего фильтровать'}
            {$filters}
        {/if}
    </form>

{*    <div class="listing__filter-block">*}
{*        <div class="listing__filter-block-header">*}
{*            <div class="listing__filter-block-title">Влагостойкость</div>*}
{*            <div class="listing__filter-block-arrow"></div>*}
{*        </div>*}
{*        <div class="listing__filter-block-content">*}
{*            <div class="listing__filter-checkboxes">*}
{*                <label>*}
{*                    <input type="checkbox"><span>Что - то <span>(61)</span></span>*}
{*                </label>*}
{*                <label>*}
{*                    <input type="checkbox"><span>Что - то <span>(61)</span></span>*}
{*                </label>*}
{*            </div>*}
{*        </div>*}
{*    </div>*}
{*    <div class="listing__filter-block">*}
{*        <div class="listing__filter-block-header">*}
{*            <div class="listing__filter-block-title">Длина, мм</div>*}
{*            <div class="listing__filter-block-arrow"></div>*}
{*        </div>*}
{*        <div class="listing__filter-block-content">*}
{*            <div class="listing__filter-checkboxes">*}
{*                <label>*}
{*                    <input type="checkbox"><span>Что - то <span>(61)</span></span>*}
{*                </label>*}
{*                <label>*}
{*                    <input type="checkbox"><span>Что - то <span>(61)</span></span>*}
{*                </label>*}
{*            </div>*}
{*        </div>*}
{*    </div>*}
{*    <div class="listing__filter-block">*}
{*        <div class="listing__filter-block-header">*}
{*            <div class="listing__filter-block-title">Толщина, мм</div>*}
{*            <div class="listing__filter-block-arrow"></div>*}
{*        </div>*}
{*        <div class="listing__filter-block-content">*}
{*            <div class="listing__filter-checkboxes">*}
{*                <label>*}
{*                    <input type="checkbox"><span>Что - то <span>(61)</span></span>*}
{*                </label>*}
{*                <label>*}
{*                    <input type="checkbox"><span>Что - то <span>(61)</span></span>*}
{*                </label>*}
{*            </div>*}
{*        </div>*}
{*    </div>*}
{*    <div class="listing__filter-block">*}
{*        <div class="listing__filter-block-header">*}
{*            <div class="listing__filter-block-title">Ширина, мм</div>*}
{*            <div class="listing__filter-block-arrow"></div>*}
{*        </div>*}
{*        <div class="listing__filter-block-content">*}
{*            <div class="listing__filter-checkboxes">*}
{*                <label>*}
{*                    <input type="checkbox"><span>Что - то <span>(61)</span></span>*}
{*                </label>*}
{*                <label>*}
{*                    <input type="checkbox"><span>Что - то <span>(61)</span></span>*}
{*                </label>*}
{*            </div>*}
{*        </div>*}
{*    </div>*}
{*    <div class="listing__filter-block">*}
{*        <div class="listing__filter-block-header">*}
{*            <div class="listing__filter-block-title">Цвет</div>*}
{*            <div class="listing__filter-block-arrow"></div>*}
{*        </div>*}
{*        <div class="listing__filter-block-content">*}
{*            <div class="listing__filter-checkboxes">*}
{*                <label>*}
{*                    <input type="checkbox"><span>Что - то <span>(61)</span></span>*}
{*                </label>*}
{*                <label>*}
{*                    <input type="checkbox"><span>Что - то <span>(61)</span></span>*}
{*                </label>*}
{*            </div>*}
{*        </div>*}
{*    </div>*}
{*    <div class="listing__filter-block">*}
{*        <div class="listing__filter-block-header">*}
{*            <div class="listing__filter-block-title">Мягкая</div>*}
{*            <div class="listing__filter-block-arrow"></div>*}
{*        </div>*}
{*        <div class="listing__filter-block-content">*}
{*            <div class="listing__filter-checkboxes">*}
{*                <label>*}
{*                    <input type="checkbox"><span>Что - то <span>(61)</span></span>*}
{*                </label>*}
{*                <label>*}
{*                    <input type="checkbox"><span>Что - то <span>(61)</span></span>*}
{*                </label>*}
{*            </div>*}
{*        </div>*}
{*    </div>*}
{*    <div class="listing__filter-block">*}
{*        <div class="listing__filter-block-header">*}
{*            <div class="listing__filter-block-title">Тип</div>*}
{*            <div class="listing__filter-block-arrow"></div>*}
{*        </div>*}
{*        <div class="listing__filter-block-content">*}
{*            <div class="listing__filter-checkboxes">*}
{*                <label>*}
{*                    <input type="checkbox"><span>Что - то <span>(61)</span></span>*}
{*                </label>*}
{*                <label>*}
{*                    <input type="checkbox"><span>Что - то <span>(61)</span></span>*}
{*                </label>*}
{*            </div>*}
{*        </div>*}
{*    </div>*}
</div>