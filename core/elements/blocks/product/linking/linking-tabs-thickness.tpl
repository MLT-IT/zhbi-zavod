{if $linksData[$key]?}
<div class="product-card__select-wrap product-card__select-wrap_type_full product-tabs__section product-tabs__section_thickness">
    <div class="product-card__select-span">Толщина:</div>
    <ul class="product-info__volume-tabs">
        {set $currentId = $_modx->resource.id}
        {set $currentVal = $_modx->resource[$key][0]}
        {set $currentClean = $currentVal|replace:'мм':''|replace:'MM':''|replace:'mm':''|replace:'ММ':''|replace:' ':''|trim|lower}
        {set $normalized = []}
        {foreach $linksData[$key] as $id => $val}
            {set $cleanTitle = $val|replace:'мм':''|replace:'MM':''|replace:'mm':''|replace:'ММ':''|trim}
            {set $normKey = $cleanTitle|replace:' ':''|lower}
            {set $isActiveVal = ($normKey == $currentClean)}
            {if !$normalized[$normKey]? || $isActiveVal}
                {set $normalized[$normKey] = [
                    'id' => $id,
                    'title' => $cleanTitle,
                    'active' => $isActiveVal
                ]}
            {/if}
        {/foreach}

        {if !$normalized[$currentClean]?}
            {set $normalized[$currentClean] = [
                'id' => $currentId,
                'title' => $currentVal|replace:'мм':''|replace:'MM':''|replace:'mm':''|replace:'ММ':''|trim,
                'active' => true
            ]}
        {/if}

        {foreach $normalized as $item}
            {set $itemUrl = $_modx->makeUrl($item.active ? $currentId : $item.id, '', '', 'full')}
            <li class="product-info__volume-tab{if $item.active} active{/if}">
                <a href="{$itemUrl}" class="{if $item.active}active{/if}">{$item.title} мм</a>
            </li>
        {/foreach}
    </ul>
</div>
{/if}
