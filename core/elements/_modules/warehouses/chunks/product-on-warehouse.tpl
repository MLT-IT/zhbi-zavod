{if $count > 0}
    <tr>
        <td>
            {$pagetitle}
        </td>
        <td>
            {if $count > 0}{$count}{else}Нет в наличии{/if} {$prefix}
        </td>
    </tr>
{/if}