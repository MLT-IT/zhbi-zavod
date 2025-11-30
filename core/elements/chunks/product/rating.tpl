<div class="product-info__rating rating{if $isCustomCalculator || $isShtaketnik} abs{/if}">
    <ul class="rating__stars">
      <li class="rating__star active"></li>
      <li class="rating__star active"></li>
      <li class="rating__star active"></li>
      <li class="rating__star active"></li>
      {if $_modx->context.key == 'trotuarnaya-plitka'}
      <li class="rating__star active__part"></li>
      {else}
        <li class="rating__star"></li>
      {/if}
    </ul>
    <span class="rating__reviews{if $reviewsCount > 0} rating__reviews_clickable{/if}">
      {if $_modx->context.key == 'fibrofasad' || $_modx->context.key == 'trotuarnaya-plitka' }
        {set $reviewsCount = $_modx->runSnippet('@FILE snippets/random.php', ['begin' => 1, 'end'=> 5, 'id' => $_modx->resource.id])}
      {/if}
      {$reviewsCount}
      {'@FILE snippets/formOfWord.php' | snippet : [
        'n' => $reviewsCount,
        'f1' => 'отзыв',
        'f2' => 'отзыва',
        'f5' => 'отзывов'
      ]}
    </span>
</div>