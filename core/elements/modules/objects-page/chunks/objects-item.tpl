<div class="objects-list__item object swiper-slide">
  <div class="object__header">
    <h3>
      <img alt="" src="/assets/template/img/icons/object-house.png" class="object__icon"><span class="object__name">{$item->name}</span> <span class="object__year">{$item->year}</span></h3>
    <p>{$item->location}</p>
  </div>
  {set $files = $item->images | fromJSON}
  <div class="object__gallery">
    {include 'file:modules/objects-page/chunks/gallery.tpl' path='/assets/' files=$files}
  </div>
  <div class="object__details">
    {if ($item->products | len) > 1}
    <h3><img alt="" src="/assets/template/img/icons/object-products.png" class="object__icon"><span>Продукция:</span> </h3>
    <p>
      <ul>
        {foreach $item->products as $prod_id}
          {set $url = $_modx->makeUrl($prod_id)}
          <li>
            <a href="{$url}">{$prod_id | resource : 'pagetitle'}</a>
          </li>
        {/foreach}
      </ul>
    </p>
    {/if}
    <p class="description"><em>Описание:</em> {$item->description}</p>
  </div>
</div>
