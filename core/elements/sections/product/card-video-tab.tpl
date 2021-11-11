{if $_modx->resource.video}
    {set $video = $_modx->resource.video}
{/if}

{if $video}
    <div class="content-block">
        {$video}
    </div>
{/if}
