{var $key = $table ~ $delimeter ~ $filter}
{set $limit = 5}

{switch $key}
    {case 'msoption|cvet'}
        {set $keyClass = 'cvet'}
    {case 'msoption|proizvoditel'}
        {set $keyClass = 'proizvoditel'}
    {case 'mse2_msoption|cvet-ral'}
        {set $keyClass = 'cvet'}
{/switch}

<div data-disable-close class="filter-item{if $keyClass?} filter-item_type_{$keyClass}{/if}{if $idx >= $limit} filter-item_excess{/if}" id="mse2_{$key}"  data-key="{$key}" data-dropdown="responsive">
  <div class="filter-item__top active"><span class="filter_title filter-item__title">{('mse2_filter_' ~ $table ~ '_' ~ $filter) | lexicon}:</span></div>
  <div class="filter-item__dropdown">
    <div class="filter-item__options">
      {$rows}
    </div>
  </div>
</div>
