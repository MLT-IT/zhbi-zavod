{* Вывод опций *}

{if $_modx->context.key === 'krovelnyjstroymarket'}

    {set $link_options = $_modx->resource.parent | resource : 'link_options'}
    {if $link_options}
        {set $link_options = $link_options | split}
        {set $parent_link = $_modx->makeURL($_modx->resource.parent,'','','full')}
    {/if}

    {foreach [$extraOptions, $options] as $opts}
        {foreach $opts as $option}
            {if $option.value[0] != ""}
            {if $option.value is array}
                {set $value = $option.value | join : ', '}
            {else}
                {set $value = $option.value}
            {/if}

            <tr class="table__row">
                <td class="table__cell">
                    {$option.caption}
                </td>
                <td class="table__cell">
                    {if $option.key in list $link_options}
                        <a href="{$parent_link}?{$option.key}={$value}">{$value}</a>
                    {else}
                        {$value}
                    {/if}
                </td>
            </tr>
            {/if}
        {/foreach}
    {/foreach}

{else}

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

{/if}



