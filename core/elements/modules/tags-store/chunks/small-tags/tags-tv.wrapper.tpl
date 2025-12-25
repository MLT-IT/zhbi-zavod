{set $limit_tags = 4}

{* >>> Часть тегов для превью *}
    {set $preview_items = []}
    {foreach $tags as $tag}
        {foreach $tag['items'] as $index => $category}
            {set $preview_items[] = $category}
        {/foreach}
    {/foreach}
    {if count($preview_items) >= $limit_tags}
    <div class="small-tags__items" id="preview_tags__small">
        {foreach $preview_items as $index => $category}
            {if $index < $limit_tags}
                {include "file:modules/tags-store/chunks/common/tag.item.tpl" category=$category}
            {/if}
        {/foreach}
    </div>
    {/if}
{* <<< *}

<div class="{if count($preview_items) >= $limit_tags}small-tags__hidden{/if}" data-opened-element="small-tags">
    {foreach $tags as $tag}
        <div class="small-tags__group">
            {if $tag['group_name']}
                <div class="small-tags__group-name">{$tag['group_name']}</div>
            {/if}
            
            <div class="small-tags__items">
                {foreach $tag['items'] as $category}
                    {include "file:modules/tags-store/chunks/common/tag.item.tpl" category=$category}
                {/foreach}
            </div>
        </div>
    {/foreach}
</div>
{if count($preview_items) >= $limit_tags}
    <button class="btn color-red hover-opacity pl-0" data-opened-btn="small-tags" data-active-text="Скрыть" onclick="preview_tags__small.classList.toggle('hidden')">
        Показать все
    </button>
{/if}