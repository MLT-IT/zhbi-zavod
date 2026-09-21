{set $remains = '@FILE snippets/random.php' | snippet : [
  'id' => $_modx->resource.id,
  'begin' => 50
  'end'=> 300
]}
<ul class="product-page__inform-list">
  <li>
    <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="none">
      <rect width="12" height="12" rx="6" fill="#49BF63" />
      <path d="m4 5.895 1.52 1.62a.1.1 0 0 0 .152-.007L8.4 4" stroke="#fff" stroke-linecap="round" />
    </svg>
    <span>В наличии {$remains} {$_modx->resource.unit[0]}</span>
  </li>
  <li>
    <svg xmlns="http://www.w3.org/2000/svg" width="14" height="16" fill="none" viewBox="0 0 14 16">
      <path d="M7 0 0 3v5c0 4.14 2.98 8.02 7 9 4.02-.98 7-4.86 7-9V3L7 0Z" fill="var(--color-red)"/>
    </svg>
    <span>Контроль качества на каждом этапе</span>
  </li>
  <li>
    <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="none" viewBox="0 0 24 24">
      <circle cx="12" cy="12" r="10" stroke="var(--color-red)" stroke-width="2"/>
      <path d="M12 6v6l4 2" stroke="var(--color-red)" stroke-width="2" stroke-linecap="round"/>
    </svg>
    <span>Производство от <a class="link-dashed" href="/dostavka-i-oplata/">1 дня</a></span>
  </li>
</ul>

{include "file:modules/product-card/chunks/standart-switcher.tpl"}
