<div class="product-card__actions services-item">
  <button class="btn btn_style_trans"><img src='{$item->image}' alt=""></button>
  <div class="popup-mes noflash">
    <p class="popup-mes__header">{$item->title}</p>
    <p class="popup-mes__body">{$item->text | striptags}<a class="btn btn_size_small"
        href="{$item->link}">Подробнее</a>
    </p>
    <span class="popup-mes__close"></span>
  </div>
</div>
