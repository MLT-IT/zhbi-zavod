{if $linksData[$key]?}
<div class="product-card__select-wrap product-card__select-wrap_type_full product-tabs__section product-tabs__section_thickness">
    <div class="product-card__select-span">Толщина:</div>
    <ul class="product-info__volume-tabs">
        {set $currentId = $_modx->resource.id}
        {set $normalized = []}
        {foreach $linksData[$key] as $id => $val}
            {set $cleanTitle = $val|replace:'мм':''|replace:'MM':''|replace:'mm':''|replace:'ММ':''|trim}
            {set $normKey = $cleanTitle|replace:' ':''|lower}
            {if !$normalized[$normKey]? || $id == $currentId}
                {set $normalized[$normKey] = [
                    'id' => $id,
                    'title' => $cleanTitle,
                    'active' => ($id == $currentId)
                ]}
            {/if}
        {/foreach}

        {foreach $normalized as $item}
            <li class="product-info__volume-tab{if $item.active} active{/if}">
                <a href="{$_modx->makeUrl($item.id, '', '', 'full')}" class="{if $item.active}active{/if}">{$item.title} мм</a>
            </li>
        {/foreach}
    </ul>
</div>
{/if}
