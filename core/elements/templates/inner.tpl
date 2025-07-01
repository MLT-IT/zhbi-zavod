{extends "file:layouts/default.layout.tpl"}

{block "page"}
  <main class="layout__main">
    {include "file:chunks/breadcrumbs/breadcrumbs.tpl"}

    <article class="inner section">
      <div class="inner__container">
        <h1 class="margin-bottom-md section__title">{$_modx->resource.pagetitle}</h1>
        <div class="content">
            {$_modx->resource.content}
            {if $_modx->resource.alias == 'besplatnyij-zamer'}
              {include "file:sections/zamer.tpl"}
            {/if}
        </div>
      </div>

      {if $_modx->resource.alias == 'akcii'}
        {if $_modx->resource.context_key in list ['krovelnyjstroymarket']}
          <div class="inner__container">
            <div class="banner">
              <picture class="banner__bg">
                <source srcset=" assets/template/pictures/main-screen/krovelnyjstroymarket/main-screen-mob.jpg " media="(max-width: 480px)" />
                <img class="banner__bg-img" src="assets/template/pictures/main-screen/krovelnyjstroymarket/main-screen.jpg"/>
              </picture>
              <div class="banner__title">
                Скидка 15% на изготовление металлочерепицы Grand line в размер
              </div>
              <p class="banner__text">Акция до конца месяца</p>
              <div class="banner__action">
                <span
                  data-fancybox=""
                  data-src="#callback"
                  class="banner__btn btn btn_style_yellow"
                  >Заказать со скидкой</span>
              </div>
            </div>
          </div>
          
          <br><br>
          {include "file:sections/actions.tpl" show_more_hide=true}

          <br><br>
          <div class="inner__container">
            <div class="content">
              <ol>
                <li>Скидка на доставку продукции  - 30%</li>
                <li>Крупным оптовым покупателям скидка 5% на весь заказ</li>
                <li>Строительство под ключ! Получите скидку на комплексную поставку материалов для строительства</li>
              </ol>
              <p>* Подробную информацию уточняйте по телефону у наших менеджеров</p>
            </div>
          </div>

        {/if}
      {/if}
    </article>

  </main>
{/block}
