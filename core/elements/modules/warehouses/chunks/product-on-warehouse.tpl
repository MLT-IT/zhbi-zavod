
{set $remains = '@FILE snippets/random.php' | snippet : [
    'id' => $id
    'begin' => $_modx->getPlaceholder('range-remains')[0]
    'end'=> $_modx->getPlaceholder('range-remains')[1]
]}

<tr>
    <td>
        <a class="link" href="{$uri}">{$pagetitle}</a>
    </td>
    <td>
        {if $remains > 0}{$remains} уп.{else}Нет в наличии{/if} {$prefix}
    </td>
</tr>