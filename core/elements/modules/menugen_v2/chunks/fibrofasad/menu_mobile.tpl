{set $pfx = 'menugen-mobile-catalog-menu'}
<div class="{$pfx}">
  <div class="{$pfx}__wrap">
    {foreach $data as $catitem}
      <div class="{$pfx}__catitem">
        <div class="{$pfx}__catitem-title-wrap">
          <a class="{$pfx}__catitem-title" href="{$catitem.link}">
            <p class="{$pfx}__catitem-title-img-wrap"><img class="{$pfx}__catitem-title-img" src="{$catitem.img}"></p>
            <p class="{$pfx}__catitem-title-p">{$catitem.title}</p>
          </a>
          <div class="{$pfx}__catitem-title-link-wrap">
            <a class="{$pfx}__catitem-title-link" href="#"></a>
          </div>
        </div>
        {if $catitem.children}
          <div class="{$pfx}__catitem-children">
            {foreach $catitem.children as $subcat}
              <div class="{$pfx}__catitem-subcat">
                <a class="{$pfx}__catitem-subcat-title" href="{$subcat.link}">{$subcat.title}</a>
              </div>
            {/foreach}
          </div>
        {/if}
      </div>
    {/foreach}
  </div>
  <div class="{$pfx}__show-more-link-wrap">
    <a href="#" class="{$pfx}__show-more-link" data-toggle-text="скрыть">показать больше</a>
  </div>
  <div class="{$pfx}__catalog-link-wrap">
    <a href="/catalog/" class="{$pfx}__catalog-link">перейти в каталог</a>
  </div>
</div>