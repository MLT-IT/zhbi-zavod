  <article class="product__infoblocks infoblocks infoblocks_style_shadow section">
    <div class="infoblocks__container" data-tabs data-tabs-hiddable="479">
      <div class="infoblocks__top">
        <div class="infoblocks__tabs">
          <a class="infoblocks__tab" href="javascript:;" data-tab="Описание">Описание</a>
          <a class="infoblocks__tab active" href="javascript:;" data-tab="Характеристики">Характеристики</a>
          <a class="infoblocks__tab" href="javascript:;" data-tab="Условия доставки">Условия доставки</a>

          {if $renderCerts ?}
            <a class="infoblocks__tab" href="javascript:;" data-tab="Сертификаты">Сертификаты</a>
          {/if}


            <a class="infoblocks__tab" href="javascript:;" data-tab="Отзывы">Отзывы</a>

          {if $renderVideo ?}
            <a class="infoblocks__tab" href="javascript:;" data-tab="Видео">Видео</a>
          {/if}

            {if $_modx->resource.recommendForUse != "" && $_modx->context.key in list ['suhiesmesi', 'kraska']}
                <a class="infoblocks__tab" href="javascript:;" data-tab="Рекомендации по применению">Рекомендации по применению</a>
            {/if}

        </div>
      </div>

      <div class="infoblocks__content">
        {include "file:templates/product/tabs/description.tpl"}
        {include "file:templates/product/tabs/characteristics.tpl"}
        {include "file:templates/product/tabs/delivery.tpl"}
        {include "file:templates/product/tabs/reviews.tpl"}

        {if $renderCerts ?}
          {include "file:templates/product/tabs/certs.tpl"}
        {/if}

        {if $renderVideo == 1}
          {include "file:templates/product/tabs/video.tpl"}
        {/if}

          {if $_modx->resource.recommendForUse != "" && $_modx->context.key in list ['suhiesmesi', 'kraska']}
              {include "file:templates/product/tabs/recommend-use.tpl"}
         {/if}

      </div>

      {include "file:chunks/guarantees.tpl"}
    </div>

    {if $_modx->context.key == "kraska" && $_modx->resource.parent in list $_modx->runSnippet("@FILE snippets/getCategoriesListIds.php", ['parent' => '125345,117397']) }
        <div class="infoblocks__container calculator-kraski">
            {include "file:chunks/calculator-kraski.tpl"}
        </div>
    {/if}

  </article>
