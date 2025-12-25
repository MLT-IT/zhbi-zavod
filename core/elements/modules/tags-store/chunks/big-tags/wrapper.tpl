<div class="big-tags section-margin bg-light-gray-2">
    <div class="container">
        <div class="big-tags__row">
            {if $_modx->resource.big_tags}
                {include "file:modules/tags-store/chunks/big-tags/tags-tv.wrapper.tpl"}
            {else}
                {include "file:modules/tags-store/chunks/big-tags/tags-children.wrapper.tpl"}
            {/if}
        </div>
    </div>
</div>