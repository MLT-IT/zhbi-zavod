{set $uniqueProducts = $unique_products | round}
<a href="/cart/" class="header__action_type_minicart header__action icon-btn icon-btn_style_white"{$uniqueProducts > 0 ? ' data-amount="'~$uniqueProducts~'"' : ''}>
  <svg class="icon-btn__icon" aria-hidden="true">
    <use xlink:href="assets/template/pictures/icons.svg#svg-basket"></use>
  </svg>
</a>
