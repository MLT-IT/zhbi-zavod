{set $tags = "@FILE modules/tags-store/snippets/getTags.php" | snippet : [
    "tvName" => "big_tags"
    "resourceImageTVName" => "main_image"
]}

{if count($tags)}
    {set $limit_tags = 9}

    {* >>> Часть тегов для превью *}
        {set $preview_items = []}
        {foreach $tags as $tag}
            {foreach $tag['items'] as $index => $category}
                {set $preview_items[] = $category}
            {/foreach}
        {/foreach}

        {if count($preview_items) >= $limit_tags}
        <div class="big-tags__items" id="preview_tags__big">
            {foreach $preview_items as $index => $category}
                {if $index < $limit_tags}
                    {include "file:modules/tags-store/chunks/common/tag.item.tpl" category=$category}
                {/if}
            {/foreach}
            <button class="tags__item show-more color-red nohover" data-opened-btn="big-tags" onclick="preview_tags__big.remove()">
                Показать все
            </button>
        </div>
        {/if}
    {* <<< *}
    
    <div class="{if count($preview_items) >= $limit_tags}big-tags__hidden{/if}" data-opened-element="big-tags">
        {foreach $tags as $tag}
            <div class="big-tags__group">
                {if $tag['group_name']}
                    <div class="big-tags__group-name">{$tag['group_name']}</div>
                {/if}
                
                <div class="big-tags__items">
                    {foreach $tag['items'] as $category}
                        {include "file:modules/tags-store/chunks/common/tag.item.tpl" category=$category}
                    {/foreach}
                </div>
            </div>
        {/foreach}
    </div>
{/if}