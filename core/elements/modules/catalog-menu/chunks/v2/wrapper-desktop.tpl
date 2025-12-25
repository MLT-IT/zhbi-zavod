<div class="catalog-menu mr-8">
  <button class="btn btn-primary d-flex gap-8 catalog-menu__main-btn" data-catalog-open="catalog-modal-desktop">
    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none"><path fill="#FFF" d="M3 6h18v2H3zM3 11h18v2H3zM3 16h18v2H3z"/></svg>
    Каталог
  </button>
  <div class="catalog-menu__row" id="catalog-modal-desktop">
    <div class="catalog-menu__overlay" data-catalog-close></div>
    <div class="catalog-menu__container" id="catalog-menu-desktop">
      {$_modx->runSnippet("@FILE modules/menu/uteplitel/snippets/getMenu.php")}
    </div>
  </div>
</div>

