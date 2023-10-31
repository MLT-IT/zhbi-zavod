{set $key = $table ~ $delimeter ~ $filter}
{set $limit = 5}

<div class="filter-item__option{if $disabled?} {$disabled}{/if}{if $idx >= $limit} filter-item__option_excess{/if}">
  <a href="{$_modx->resource.id | url}?[[+filter_key]]=[[+value]]" class="default-checkbox filter-item__link">
    <input class="default-checkbox__input" type="checkbox" name="{$filter_key}" id="mse2_{$key}_{$idx}" value="{$value}" {$checked} {$disabled}>
    <label for="mse2_{$key}_{$idx}" class="default-checkbox__label" data-val="{$value}"> 
      <span class="default-checkbox__label-text">{$title}</span>
    </label>
  </a>
</div>
