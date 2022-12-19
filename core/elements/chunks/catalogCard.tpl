<a class="catalog__card" href="{$uri}">
    {set $src = 'phpthumbon' | snippet : [
      'input' => $_pls['tv.mainImage'],
      'options' => '&w=350&far=1'
    ]}
    <img class="catalog__card-img" src="{$src}" alt="{$menutitle}">
    <div class="catalog__card-title">
        <span class="catalog__card-title-span">{$menutitle}</span>
    </div>
</a>
