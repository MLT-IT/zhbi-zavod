{* $open_tabs - Открыть все вкладки. Используется на странице "Контакты" *}
{* $bg - Серый фон у секции *}

<div class="address-map {if $bg}bg-light-gray-2 section-padding{else}section-margin{/if}">
  <div class="container">

      {if !$open_tabs}
        <div class="address-map__top">
          <h2 class="section-title">Адреса</h2>
          <div class="d-flex gap-8">
            <button class="btn btn-bordered text-uppercase active" data-opened-btn="address-map1" data-close-early="address-map" data-toggle-not="true">Склады</button>
            <button class="btn btn-bordered text-uppercase" data-opened-btn="address-map2" data-close-early="address-map" data-toggle-not="true">Офис</button>
          </div>
        </div>
      {/if}

      <div class="address-map__window opened" data-opened-element="address-map1">
        {include "file:sections/address-map/tab-1.tpl"}
      </div>

      {if $open_tabs}<br/><br/><hr/><br/><br/>{/if}
      
      <div class="address-map__window {if $open_tabs}opened{/if}" data-opened-element="address-map2">
        {include "file:sections/address-map/tab-2.tpl"}
      </div>
  </div>
</div>
