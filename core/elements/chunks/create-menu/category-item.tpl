<li class="catalog-screen__item catalog-screen__item_type_default">
  <a href="{$uri}" class="catalog-screen__item-picture">
    {if $_pls['mainImage'] != ""}
      <img class="catalog-screen__item-image" src="{$_pls['mainImage']}" alt="{$menutitle}">
        {else}
        <div class="catalog-screen__item-background" data-val="{$menutitle}"></div>
    {/if}

  </a>
  <a href="{$uri}" class="catalog-screen__item-name">{$_pls['tagName'] ?: $menutitle}</a>
</li>
