{var $key = $table ~ $delimeter ~ $filter}
<label for="mse2_{$key}_{$idx}" class="filter-option listing__filter-option{if $disabled?} {$disabled}{/if}">
    <span class="custom-checkbox filter-option__checkbox">
        <input class="custom-checkbox__input" type="checkbox" name="{$filter_key}" id="mse2_{$key}_{$idx}" value="{$value}" {$checked} {$disabled}/>
        <span class="custom-checkbox__checkmark"></span>
    </span>
    <span class="filter-option__title">{$title}</span>
    <sup class="filter-option__num">
        {if $num?}
            ({$num})
        {/if}
    </sup>
</label>
