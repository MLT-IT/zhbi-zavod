{set $parent_link = $_modx->makeURL($_modx->resource.parent,'','','full')}

{foreach $options as $option}
  {if $option.value is array}
      {set $value = $option.value | join : ', '}
  {else}
      {set $value = $option.value}
  {/if}
  
  {if $value}
    <tr>
      <td class="fw-700">
        {$option.caption}
      </td>
      <td class="fw-700">
        {if $option.key in list ['ottenok','cvet','proizvoditel','pokrytie','tip','item_thickness']}
          <a class="link-primary" href="{$parent_link}?msoption|{$option.key}={$value}">{$value}</a>
        {else}
          {$value}
        {/if}
      </td>
    </tr>  
  {/if}
{/foreach}