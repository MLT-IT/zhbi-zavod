{foreach [$extraOptions, $options] as $opts}
    {if $opts is not empty}
        {
        {foreach $opts as $option index=$i first=$first last=$last}
            "{$option.key}":"{$option.value[0]}" {if !$last},{/if}
        {/foreach}
        }
    {/if}
{/foreach}
