{set $key = $table ~ $delimeter ~ $filter}

{if $idx > 5}
  {$_modx->setPlaceholder('category-listing-show-btn-more', true)}
  {set $classes = "hidden"}
{else}
  {$_modx->setPlaceholder('category-listing-show-btn-more', false)}
{/if}

<div class="category-listing__filter-value {$classes}">
  <label class="{$disabled} custom-checkbox" for="mse2_{$key}_{$idx}" data-wizard-key="{$filter_key}" data-wizard-value="{$value}" >
    <input
      type="checkbox"
      name="{$filter_key}"
      id="mse2_{$key}_{$idx}"
      value="{$value}"
      {$checked}
      {$disabled}
    />
    <span class="checkmark" data-wizard-after></span>
    <span class="category-listing__filter-value-text">{$title}</span>
  </label>
</div>
