{* Вывод опций *}
{foreach [$extraOptions, $options] as $opts}
    {foreach $opts as $option}
        {if $option.value[0] != ""}
          <tr class="table__row">
            <td class="table__cell">
                {$option.caption}
            </td>
            <td class="table__cell">
                {if $option.value is array}
                    {$option.value | join : ', '}
                {else}
                    {$option.value}
                {/if}
            </td>
          </tr>
        {/if}
    {/foreach}
{/foreach}



