{set $thumb = 'phpthumbof' | snippet : [
    'input' => "{$category['image']?:$category['main_image']}",
    'options' => '&w=80&zc=1&bg=ffffff'
]}
<a
  class="tags__item {$class_names}"
  href="{$category['uri']}"
>
  <img class="tags__item-image" src="{$thumb}" />
  {$category['title']?:$category['menutitle']}
</a>