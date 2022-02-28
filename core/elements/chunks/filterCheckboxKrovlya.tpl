{set $key = $table ~ $delimeter ~ $filter}

{*if $disabled?}
    {set $priority = 0}
{else}
    {set $priority = $num | ereplace : '/\D/' : ''}
{/if*}


{if $filter === 'cvet'}
    {set $dataVal = $title | toLowerAndRemoveChars}
{/if}

<a {*data-priority="{$priority}"*} href="{$_modx->resource.id | url}?[[+filter_key]]=[[+value]]" class="filter-option listing__filter-option{if $disabled?} {$disabled}{/if}" {if $dataVal?}data-val="{$dataVal}"{/if}>
    <label for="mse2_{$key}_{$idx}" class="filter-option__label">
        <span class="custom-checkbox filter-option__checkbox">
            <input class="custom-checkbox__input" type="checkbox" name="{$filter_key}" id="mse2_{$key}_{$idx}"
                   value="{$value}" {$checked} {$disabled}/>
            <span class="custom-checkbox__checkmark"></span>
        </span>
        <span class="filter-option__title">{$title}</span>
        {*
        <sup class="filter-option__num">
            {if $num?}
                ({$num})
            {/if}
        </sup>
        *}
    </label>
</a>
