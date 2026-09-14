{set $key = $_modx->context.key}
{set $data = '@FILE snippets/fromJSON.php' | snippet : ['input' => 'raspil/'~$key~'/tag-row.json']}
<section class="tag-row {$styleClass}">
  <div class="{$containerClass}">
    <h1>{$data.title}</h1>
    <div class="tag-row__line">
      {foreach $data.list as $item}
        <a class="btn btn_size_small btn_style_trans" href="{$item.id | url}">{$item.caption}</a>
      {/foreach}
    </div>
  </div>
</section>
