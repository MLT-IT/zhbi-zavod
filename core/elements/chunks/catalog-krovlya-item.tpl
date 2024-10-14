{set $thumb = 'phpthumbon' | snippet : [
  'input' => $mainImage,
  'options' => '&w=400&h=280&zc=1'
]}
<div class="catalog-krovlya__item ck-item" itemscope itemtype="https://schema.org/CategoryCode">
  <a class="ck-item__link" href="{$uri}" itemprop="url">
    <img src="{$thumb}" alt="{$menutitle}" itemprop="image">
    <div class="ck-item__title" itemprop="name">{$menutitle}</div>
  </a>
</div>
