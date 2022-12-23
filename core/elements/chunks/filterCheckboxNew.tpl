{set $key = $table ~ $delimeter ~ $filter}

{*if $disabled?}
    {set $priority = 0}
{else}
    {set $priority = $num | ereplace : '/\D/' : ''}
{/if*}

{if $filter in list ['cvet', 'ottenok', 'surface', 'brand', 'proizvoditel']}
    {set $dataVal = $title}
{/if}

{set $limit = 5}

{* В некотрых категориях нужно выводить не 5, а 6 или больше значений некоторых фильтров. Если будешь это менять / убирать, подправь и в funcsCatalog.js *}
{if (($_modx->resource.id in list [37609,19847,37478]) && ($key == 'msoption|proizvoditel')) ||
(($_modx->resource.id == 86214) && ($key == 'msoption|profil')) ||
(($_modx->resource.id in list [16788, 86214, 22594]) && ($key == 'msoption|pokrytie'))
}
    {set $limit = 6}
{elseif (($_modx->resource.id == 16788) && ($key == 'msoption|collection')) ||
(($_modx->resource.id in list [16788, 86214, 22594]) && ($key == 'msoption|cvet'))}
    {set $limit = 8}
{/if}

<div {*data-priority="{$priority}"*} class="filter-option listing__filter-option{if $disabled?} {$disabled}{/if}{if $idx >= $limit} filter-option_excess{/if}" {if $dataVal?}data-val="{$dataVal}" {/if}data-value="{$value}">
  <a href="{$_modx->resource.id | url}?[[+filter_key]]=[[+value]]" class="filter-option__link">
      <label for="mse2_{$key}_{$idx}" class="filter-option__label">
          <span class="custom-checkbox filter-option__checkbox">
              <input class="custom-checkbox__input" type="checkbox" name="{$filter_key}" id="mse2_{$key}_{$idx}"
                     value="{$value}" {$checked} {$disabled}/>
              <span class="custom-checkbox__checkmark"></span>
          </span>
          <span class="filter-option__title">
              {$title}
          </span>
      </label>
  </a>
  {*
  <sup class="filter-option__num">
      {if $num?}
          ({$num})
      {/if}
  </sup>
  *}
</div>
