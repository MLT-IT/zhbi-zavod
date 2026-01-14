<!-- {set $items = [
  ['title' => 'Предоплата 40%','text' => 'вместо стандартных 100%, как у большинства'],
  ['title' => 'Оплата после проверки ','text' => 'полная оплата только после осмотра'],  
  ['title' => 'Собственное производство','text' => 'не переплачивайте посредникам'],
  ['title' => 'Склады с готовой продукцией','text' => 'покупайте материалы и забирайте их уже сегодня'],
]} -->

<div class="product-advantages">
  <div class="container">
    <div class="product-advantages__row">
      {foreach $items as $index => $item}
      {set $index = $index + 1}
      <div class="product-advantages__item">
        <div class="product-advantages__item-image">
          <img src="/assets/template/images/sections/product-advantages/{$index}.png" />
          <span>0{$index}</span>
        </div>
        <div class="product-advantages__item-title">{$item['title']}</div>
        <div class="product-advantages__item-text">{$item['text']}</div>
      </div>
      {/foreach}
    </div>
  </div>
</div>