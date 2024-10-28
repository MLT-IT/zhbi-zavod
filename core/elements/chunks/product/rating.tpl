<div class="product-info__rating rating{if $isCustomCalculator || $isShtaketnik} abs{/if}">
    <ul class="rating__stars">
      <li class="rating__star active"></li>
      <li class="rating__star active"></li>
      <li class="rating__star active"></li>
      <li class="rating__star active"></li>
      <li class="rating__star"></li>
    </ul>
    <span class="rating__reviews{if $reviewsCount > 0} rating__reviews_clickable{/if}">
      {$reviewsCount}
      {'@FILE snippets/formOfWord.php' | snippet : [
        'n' => $reviewsCount,
        'f1' => 'отзыв',
        'f2' => 'отзыва',
        'f5' => 'отзывов'
      ]}
    </span>
</div>