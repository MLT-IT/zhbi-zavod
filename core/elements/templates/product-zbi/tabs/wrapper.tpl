  <article class="product__infoblocks infoblocks infoblocks_style_shadow section">
    <div class="infoblocks__container" data-tabs data-tabs-hiddable="479">
      <div class="infoblocks__top">
        <div class="infoblocks__tabs">
          <a class="infoblocks__tab" href="javascript:;" data-tab="Описание">Описание</a>

          <a class="infoblocks__tab active" href="javascript:;" data-tab="Характеристики">Характеристики</a>

          <a class="infoblocks__tab" href="javascript:;" data-tab="Условия доставки">Условия доставки</a>

          <a class="infoblocks__tab" href="javascript:;" data-tab="Прайс">Прайс</a>

          <a class="infoblocks__tab" href="javascript:;" data-tab="Отзывы">Отзывы</a>

          {if $renderVideo ?}
            <a class="infoblocks__tab" href="javascript:;" data-tab="Видео">Видео</a>
          {/if}

        </div>
      </div>

      <div class="infoblocks__content">

        {include "file:templates/product-zbi/tabs/description.tpl"}

        {include "file:templates/product-zbi/tabs/characteristics.tpl"}

        {include "file:templates/product-zbi/tabs/delivery.tpl"}

        {include "file:templates/product-zbi/tabs/price.tpl"}

        {include "file:templates/product-zbi/tabs/reviews.tpl"}

        {if $renderVideo == 1}
        {include "file:templates/product-zbi/tabs/video.tpl"}
        {/if}

      </div>

      {include "file:chunks/guarantees.tpl"}
    </div>

  </article>
