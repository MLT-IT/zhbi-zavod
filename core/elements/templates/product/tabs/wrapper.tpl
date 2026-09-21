{set $btns = [
  ['title' => 'Описание', 'id' => 'tab1'],
  ['title' => 'Характеристики', 'id' => 'tab2', 'classlist' => 'active'],
  ['title' => 'Условия доставки', 'id' => 'tab3'],
]}

{if $_modx->context.key === 'gbi-zavod78'}
  {set $btns[] = ['title' => 'Прайс', 'id' => 'tab4']}
{/if}

{set $btns[] = ['title' => 'Отзывы', 'id' => 'tab5']}
{set $btns[] = ['title' => 'Сертификаты', 'id' => 'tab6']}

{set $video = $_modx->resource.video}
{if $video}
  {set $btns[] = ['title' => 'Видео', 'id' => 'tab7']}
{/if}

{set $certs = $_modx->resource.certs | fromJSON}

<div class="product-page__tabs section-margin">
  <div class="container">
    <div class="product-page__tabs-controls">
      <div class="product-page__tabs-controls-row">
        {foreach $btns as $btn}
          <button
            class="{$btn['classlist']}"
            data-opened-btn="{$btn['id']}"
            data-close-early="tabs"
            data-toggle-not="true"
          >{$btn['title']}</button>
        {/foreach}
      </div>
    </div>
    
    <div class="product-page__tabs-row">
      <div>
        <div class="product-page__tabs-wrap">
          <button
            data-opened-btn="tab1">Описание</button>
          <div class="product-page__tabs-content" data-opened-element="tab1">
            <div class="page-content">{$_modx->resource.content}</div>
          </div>
        </div>
        
        <div class="product-page__tabs-wrap">
          <button
            class="active"
            data-opened-btn="tab2">Характеристики</button>
          <div class="product-page__tabs-content opened" data-opened-element="tab2">
            {include "file:templates/product/tabs/characteristics/wrapper.tpl"}
          </div>
        </div>

        <div class="product-page__tabs-wrap">
          <button
            data-opened-btn="tab3">Условия доставки</button>
          <div class="product-page__tabs-content" data-opened-element="tab3">
            {include "file:chunks/delivery-table.tpl" is_shadow=true}
          </div>
        </div>

        {if $_modx->context.key === 'gbi-zavod78'}
        <div class="product-page__tabs-wrap">
          <button
            data-opened-btn="tab4">Прайс</button>
          <div class="product-page__tabs-content" data-opened-element="tab4">
            {include "file:templates/product/tabs/price/wrapper.tpl"}
          </div>
        </div>
        {/if}

        <div class="product-page__tabs-wrap">
          <button
            data-opened-btn="tab6">Сертификаты</button>
          <div class="product-page__tabs-content" data-opened-element="tab6">
            {include "file:modules/certificates-list/chunks/wrapper.tpl" certs=$certs}
          </div>
        </div>

        <div class="product-page__tabs-wrap">
          <button
            data-opened-btn="tab5">Отзывы</button>
          <div class="product-page__tabs-content" data-opened-element="tab5">
            
            {include 'file:modules/mltreviews/chunks/product-page.tpl'}

            <div class="mt-16">
              <button class="btn btn-primary" onclick="modals.events.open('modal-review')">Оставить отзыв</button>
            </div>
            {include "file:modules/modals/chunks/modal-review.tpl"}
          </div>
        </div>

        {if $video}
          <div class="product-page__tabs-wrap">
            <button
              data-opened-btn="tab7"
              
            >Видео</button>
            <div class="product-page__tabs-content" data-opened-element="tab7">
              {include "file:templates/product/tabs/video.tpl" video=$video}
            </div>
          </div>
        {/if}
      </div>

      {include "file:sections/advantages/vertical/wrapper.tpl" is_shadow=true is_callback_btn=true}
    </div>
  </div>
</div>
