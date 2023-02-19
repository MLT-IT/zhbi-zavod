{if $products}
<div class="fast-search-container">
    <ul class="fast-search-categories border" fast-search-limit-items="3">
        <li fast-search-limit-protection>Категории:</li>
        {$categories}
    </ul>
    <ul>
        <li>Товары:</li>
        {$products}
        <li>
            <div class="fast-search-button">
                <button class="custom-btn">Показать еще</button>
            </div>
        </li>
    </ul>
</div>
{else}
<div class="fast-search-container one-column">
    <ul class="fast-search-categories" fast-search-limit-items="3">
        <li fast-search-limit-protection>Категории:</li>
        {$categories}
    </ul>
</div>
{/if}