{set $tags = "@FILE modules/tags-store/snippets/getTags.php" | snippet : [
    "tvName" => "small_tags"
    "resourceImageTVName" => "main_image"
]}

{if count($tags)}
<div class="small-tags">
    <div class="fw-700 mb-16">Часто ищут:</div>
    <div class="small-tags__row">
        {include "file:modules/tags-store/chunks/small-tags/tags-tv.wrapper.tpl"}
    </div>
</div>
{/if}