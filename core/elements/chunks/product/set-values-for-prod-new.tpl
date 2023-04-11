{* Если это не чанк при вызове сниппета, а страница товара, то $src['id'] будет пустым *}
{if $src['id'] is empty}
  {$src['id'] = $_modx->resouce.id}
{/if}

{set $prodValues = '@FILE snippets/product/set-values-for-prod.php' | snippet : [
  'src' => [
    'id' => $src['id'],
    'price' => $src['price'],
    'weight' => $src['weight'],
    'old_price' => $src['old_price'],
    'context_key' => $src['context_key'],
    'parent' => $src['parent'],

    'kolvo-pm' => $src['kolvo-pm'],
    'ploshad_m2' => $src['ploshad_m2'],
    'obyem_m3' => $src['obyem_m3'],
    'v_upakovke' => $src['v_upakovke'],
    'kolichestvo-metrov-v-1-tonne' => $src['kolichestvo-metrov-v-1-tonne'],
    'dlina-m' => $src['dlina-m'],
    'kol-vokub-sh' => $src['kol-vokub-sh'],
    'k_m3seam' => $src['k_m3seam'],
    'k_m2seam' => $src['k_m2seam'],
    'unit' => $src['unit'],
    'kolvom2upak' => $src['kolvom2upak'],
    'metrov-v-tonne' => $src['metrov-v-tonne'],
    'massa-1m-kg' => $src['massa-1m-kg'],
    'obschaya-ploshad' => $src['obschaya-ploshad'],
    'item_length' => $src['item_length'],
    'item_width' => $src['item_width'],

    'isFractional' => $src['isFractional'],
  ]
]}
