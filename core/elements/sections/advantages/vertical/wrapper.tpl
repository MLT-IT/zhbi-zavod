<!-- {set $items = [
  [
    "image" => "/assets/template/images/sections/advantages/advantage-5.png",
    "title" => "Гарантия качества",
    "text" => "Заменим дефектный материал или вернём деньги",
    "resource" => [
      "uri" => $_modx->getPlaceholder("makeurls.garantii"),
      "title" => "Условия возврата",
    ],
  ],
  [
    "image" => "/assets/template/images/sections/advantages/advantage-8.png",
    "title" => "Бесплатный выезд замерщика",
    "text" =>
      "Наша компания предоставляет услугу бесплатного замера. Наш специалист произведет полный расчет необходимых материалов и поможет сократить расходы.",
    "resource" => [
      "uri" => $_modx->getPlaceholder("makeurls.zamer"),
      "title" => "Заказать бесплатный замер",
    ],
  ],
  [
    "image" => "/assets/template/images/sections/advantages/advantage-6.png",
    "title" => "Доставка и самовывоз",
    "text" =>
      "Вы можете заказать доставку по СПб и ЛО или оформить самовывоз с нашего склада в Санкт-Петербурге",
    "resource" => [
      "uri" => $_modx->getPlaceholder("makeurls.dostavka"),
      "title" => "Условия доставки и самовывоза",
    ],
  ],
]} -->

<div class="advantages-vertical">
    {foreach $items as $item}
    <div class="advantages-vertical__item {if $is_shadow}base-box-shadow{/if}">
        <div class="advantages-vertical__item-image">
            <img src="{$item['image']}" />
        </div>
        <div class="advantages-vertical__item-title fs-20 fw-700">{$item['title']}</div>
        <div class="advantages-vertical__item-text">{$item['text']}</div>

        {if $item['resource']}
        <a class="link-dashed" href="{$item['resource']['uri']}">{$item['resource']['title']}</a>
        {/if}
    </div>
    {/foreach}
</div>