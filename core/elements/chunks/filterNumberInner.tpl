{var $key = $table ~ $delimeter ~ $filter}
<div class="filter-number__half">
    <label for="mse2_{$key}_{$idx}" class="filter-number__label">
        {$title}
        <input type="text" name="{$filter_key}" id="mse2_{$key}_{$idx}" value="{$value}"
               data-current-value="{$current_value}" class="filter-number__input"/>
    </label>
</div>
