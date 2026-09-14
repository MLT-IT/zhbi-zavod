{set $thumb = $mainImage ?: $mainIcon}
{* {set $thumb = 'phpthumbon' | snippet : [
  'input' => "{$mainImage}",
  'options' => '&w=300&h=200&zc=1'
]} *}
{set $url = $_modx->makeUrl($id)}
<div class="assort__item">
    <a href="{$url}" class="assort__item-img-wrap">
      <img class="assort__item-img" src="{$thumb}" alt="">
    </a>
    <a class="assort__item-title" href="{$url}">{$pagetitle}</a>
</div>
                            