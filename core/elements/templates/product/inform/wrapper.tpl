{if $_modx->resource.parent | resource : 'resource_segment' in list ['proflist','metallo4erepica']}
  {include "file:templates/product/inform/versions/v1.tpl"}
{elseif $_modx->resource.parent | resource : 'resource_segment' in list ['shtaketnik']}
  {include "file:templates/product/inform/versions/v2.tpl"}
{else}
  {include "file:templates/product/inform/versions/default.tpl"}
{/if}