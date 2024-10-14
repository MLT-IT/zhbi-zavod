export default function initTooltipPopups() {
  // Всплывашка на цене со скидкой, старая лапша
  if ($(".js-product_with-discount").length) {
    let timeout = setTimeout(function () {
      $(".product-info__price").removeClass("active");
    }, 7000);
    $(
      ".js-product_with-discount .product-info__price-value, .js-product_with-discount .product-info__price-mes-close"
    ).on("click", function (e) {
      e.stopPropagation();
      clearTimeout(timeout);
      $(this).closest(".product-info__price").toggleClass("active");
    });
  }
  // новый тултип на листинге основы шоурум
  toolTipPopup();
}

function toolTipPopup(className = 'popup-mes', delay = 7000) {
  const popUps = document.querySelectorAll(`.${className}`);
  if(!popUps || !popUps.length) {
    return;
  }
  popUps.forEach((popItem) => {
    const popParent = popItem.parentElement;
    // popParent.style.position = 'relative';
    popParent.classList.add('active')
    const timer = setTimeout(() => {
      popParent.classList.remove('active')
    }, delay);
    document.addEventListener('click', (e) => {
      e.stopImmediatePropagation();
      const {target} = e;
      if(!target.closest(`.${className}`) || target.classList.contains(`${className}__close`)){
        clearTimeout(timer);
        popParent.classList.remove('active');
      }
    })
  } )
}


/**
 * example usage
       <div class="popup-mes">
          {* <p class="popup-mes__header">Снижение цены!</p> *}
          <p class="popup-mes__body">Товар можно посмотреть вживую в нашем шоу-руме!</p>
          <span class="popup-mes__close"></span>
      </div>
 */
