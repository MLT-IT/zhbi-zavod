<div class="d-flex justify-sb mb-16">
  <h1 class="section-title mb-0">{$_modx->resource.pagetitle}</h1>

  {if count($products) > 0}
  <button
    class="btn btn-simple"
    onclick="cart.events.clear();setTimeout(()=>{ location.reload() }, 2000)"
  >
    Очистить корзину
  </button>
  {/if}
</div>
