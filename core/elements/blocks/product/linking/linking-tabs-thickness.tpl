{if $linksData[$key]?}
<div class="product-card__select-wrap product-card__select-wrap_type_full product-tabs__section product-tabs__section_thickness">
    <div class="product-card__select-span">Толщина:</div>
    <ul class="product-info__volume-tabs">
        {foreach $linksData[$key] as $id => $val}
            {set $isActive = $_modx->resource[$key][0] == $val}
            <li class="product-info__volume-tab{if $isActive} active{/if}">
                {if $isActive}
                    <span>{$val} мм</span>
                {else}
                    <a href="{$_modx->makeUrl($id, '', '', 'full')}">{$val}</a>
                {/if}
            </li>
        {/foreach}
    </ul>
</div>
{/if}
