{set $items = [
    ['text' => 'Мы владеем 7 заводами, специализирующимися на производстве ЖБИ', 'image' => '/assets/template/images/sections/advantages/advantage-1.png'],
    ['text' => 'Строгий контроль качества каждого изделия', 'image' => '/assets/template/images/sections/advantages/advantage-2.png'],    
    ['text' => 'Собственный автопарк состоящий из 50 грузовых автомобилей и самосвалов', 'image' => '/assets/template/images/sections/advantages/advantage-3.png'],
    ['text' => 'Осуществляем отгрузку изделий 24/7', 'image' => '/assets/template/images/sections/advantages/advantage-4.png'],
]}

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