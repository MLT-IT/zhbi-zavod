<!-- {set $items = [
    ['text' => 'Предоставляем продукцию 15 производителей', 'image' => '/assets/template/images/sections/advantages/advantage-1.png'],
    ['text' => 'Ежедневно производим более 1000 м2 металлочерепицы и профнастила', 'image' => '/assets/template/images/sections/advantages/advantage-2.png'],    
    ['text' => 'Оплата после проверки материала', 'image' => '/assets/template/images/sections/advantages/advantage-3.png'],
    ['text' => 'Держим на складе более 8000 м2', 'image' => '/assets/template/images/sections/advantages/advantage-4.png'],
]} -->

<div class="advantages-horizontal bg-light-gray-2 section-margin">
    <div class="container">
        <div class="advantages-horizontal__row">
            {foreach $items as $item}
            <div class="advantages-horizontal__item">
                <div class="advantages-horizontal__item-image"><img src="{$item['image']}" /></div>
                <div class="advantages-horizontal__item-text fs-20">{$item['text']}</div>
            </div>
            {/foreach}
        </div>
    </div>
</div>