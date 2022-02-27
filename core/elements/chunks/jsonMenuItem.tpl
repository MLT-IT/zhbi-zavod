{if $_pls['tv.menutitleTV'] ?}
    {set $name = $_pls['tv.menutitleTV']}
{else}
    {set $name = $menutitle}
{/if}

{ "uri": "/{$uri}", "name": "{$name}" {if $wrapper?}, "children" : [{$wrapper}]{/if} },
