{set $remains = '@FILE snippets/random.php' | snippet : [
  'id' => $_modx->resource.id,
  'begin' => 2000
  'end'=> 4000
]}
{set $items = [
  'Можно посмотреть в нашем в нашем <a class="link-dashed" target="_blank" href="shourum">шоу-руме</a>'
  'В наличии металл '~$remains~' м2',
  'Срок изготовления: 2-3 дня',
  'Гарантия на товар: 30 лет'
]}

<div class="product-page__inform">
  <div class="product-page__inform-section">
    {include "file:templates/product/chunks/rating-reviews.tpl"}

    <div class="product-page__inform-row">
      {include "file:templates/product/chunks/inform-list.tpl" items=$items remains=$remains}
      {include "file:templates/product/chunks/price/v2.tpl"}
    </div>
  </div>

  <div class="product-page__inform-section">
    <div class="product-page__inform-price">
      {include "file:modules/cart/frontend/chunks/cart-calc.tpl" show_big_buttons=1}
    </div>
    {include "file:sections/product-calc-btn/wrapper.tpl" material="кровли" link="/servisyi-rascheta/raschet-krovli-iz-metallocherepiczyi/"}
  </div>

  {include "file:sections/delivery-date/wrapper.tpl"}
</div>
