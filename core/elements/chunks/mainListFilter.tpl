{set $key = $table ~ $delimeter ~ $filter}

<a href="{$_modx->resource.id | url}?{$filter_key}={$value}" class="sect-mainlist__filter{if $disabled?} {$disabled}{/if} hidden" {if $dataVal?}data-val="{$dataVal}"{/if}>
    <label for="mse2_{$key}_{$idx}" class="sect-mainlist__filter-label">
        <input class="hidden sect-mainlist__filter-input" type="checkbox" name="{$filter_key}" id="mse2_{$key}_{$idx}"
               value="{$value}" {$checked} {$disabled} />
        <span class="sect-mainlist__chips chips-item chips-item_type_reset">
            {$value}
        </span>
    </label>
</a>
