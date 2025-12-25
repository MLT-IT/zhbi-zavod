{foreach $options as $option}
  {if $option.value is array}
      {set $value = $option.value | join : ', '}
  {else}
      {set $value = $option.value}
  {/if}
  
  {if $value}
    <tr>
      <td class="fw-700">{$option.caption}</td>
      <td class="fw-700">{$value}</td>
    </tr>  
  {/if}
{/foreach}