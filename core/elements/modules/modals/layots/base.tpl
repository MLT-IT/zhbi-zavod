{block 'params'}{/block}

<div
  class="modal modal-callback"
  id="{$id}"
>
  <div class="modal-overlay" data-modal-close></div>

  <div class="modal-container">

    <div data-modal-body-before>
      <div class="modal-callback__header">
        <div class="modal-title">{$title}</div>
      </div>
      
      {if $description}<div class="modal-description">{$description}</div>{/if}

      <div class="modal-callback__body">
        {block 'body'}{/block}
      </div>

      <div class="modal-icon-close" data-modal-close></div>
    </div>

    <div
      class="modal__success-window"
      data-modal-body-after
    >
      <div class="modal__success-title">Спасибо за заявку!</div>
      <div class="modal__success-description">С вами свяжется в ближайшее время наш менеджер</div>
      <div class="modal__success-footer">
        <button data-modal-close class="btn btn-primary">ОК</button>
      </div>
    </div>
  </div>
</div>
