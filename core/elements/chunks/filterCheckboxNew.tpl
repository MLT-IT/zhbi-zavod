{set $key = $table ~ $delimeter ~ $filter}

{*if $disabled?}
    {set $priority = 0}
{else}
    {set $priority = $num | ereplace : '/\D/' : ''}
{/if*}

{if $filter in list ['cvet', 'ottenok', 'surface', 'brand', 'proizvoditel']}
    {set $dataVal = $title | toLowerAndRemoveChars}
{/if}

{set $limit = 5}
{* На кирпиче в некотрых категориях нужно выводить не 5, а 6 производителей. Если будешь это менять / убирать, подправь и в funcsCatalog.js *}
{if ($_modx->resource.id in list [37609,19847,37478]) && ($key == 'msoption|proizvoditel')}
    {set $limit = 6}
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
