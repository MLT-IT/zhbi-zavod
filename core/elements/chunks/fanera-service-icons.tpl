	  {set $icons = [
	  ['title' => 'Для доставки данного материала используются автомашины «Тоннаж до 1.5 т», т.к. использовать автомобиль меньшего объема не позволяют габариты товара.',
	  'src' => '/assets/template/img/icons/delivery.svg',
	  'alt'=>'Доставка материала'],
	  ['title' => 'Для удобства транспортировки мы можем раcпилить данный товар.',
	  'src' => '/assets/template/img/icons/circular-saw.svg',
	  'alt'=>'Распил материала']
	  ]}
	  
	  <div class="product-service-icons">
		{foreach $icons as $icon}
		<div class="listing__products-item-chars-val-info-wrap product-service-icons__item">
		  <span class="listing__products-item-chars-val-info-btn">
            <img src="{$icon.src}" alt="{$icon.alt}"/>
		  </span>
		  <div class="listing__products-item-chars-val-info">
			{$icon.title}
		  </div>
		</div>
		{/foreach}
	  </div>