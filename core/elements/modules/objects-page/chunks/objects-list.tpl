<div class="objects-list">
  {foreach $objectsList['group'] as $type => $items}
    {switch $type}
      {case 'trk'}
        <h2>ТРК и ТРЦ</h2>
      {case 'mkd'}
        <h2>Многоквартирные дома и жилые комплексы</h2>
      {case 'road'}
        <h2>Дорожное строительство</h2>
    {/switch}
    <div class="objects-group">
    <div class="group-swiper swiper">
      <div class="swiper-wrapper">
      
      {foreach $items as $item}
        {include 'file:modules/objects-page/chunks/objects-item.tpl'}
      {/foreach}
      </div>
      {if ($items | length) > 1}
        <div class="group-nav">
          <div class="group-button-prev swiper-button-prev"></div>
          <div class="group-button-next swiper-button-next"></div>
        </div>
      {/if}
      </div>
    </div>
  {/foreach}
</div>
