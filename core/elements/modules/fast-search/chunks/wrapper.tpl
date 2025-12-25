{if $products}
<div class="fast-search-container">
  <ul class="fast-search-categories border" data-fast-search-limit-items="3">
    <li data-fast-search-limit-protection>Категории:</li>
    {$categories}
  </ul>
  <ul>
    <li>Товары:</li>
    {$products}
    <li>
      <div class="fast-search-button mt-16">
        <button class="btn btn-primary" style="width: 100%;">Показать еще</button>
      </div>
    </li>
  </ul>
</div>
{else}
<div class="fast-search-container one-column">
  <ul class="fast-search-categories" data-fast-search-limit-items="3">
    <li data-fast-search-limit-protection>Категории:</li>
    {$categories}
  </ul>
</div>
{/if}
