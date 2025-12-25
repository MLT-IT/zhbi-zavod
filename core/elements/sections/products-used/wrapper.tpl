<!-- {set $items = [
    ['title' => 'Частные застройщики', 'icon' => 'about-group'],  
    ['title' => 'Промышленные предприятия', 'icon' => 'about-plant'],    
    ['title' => 'Крупные строительные холдинги', 'icon' => 'about-building'],  
]} -->

<div class="products-used">
  <div class="container">
    <h2 class="section-title">За нашими товарами обращаются</h2>
    <div class="products-used__row">
      {foreach $items as $item}
      <div class="products-used__item">
        <svg fill="url(#svg-gradient)">
          <use
            xlink:href="/assets/template/images/icons.svg?v2#{$item['icon']}"
          ></use>
        </svg>
        <div class="products-used__item-title">{$item['title']}</div>
      </div>
      {/foreach}
    </div>
  </div>
</div>
