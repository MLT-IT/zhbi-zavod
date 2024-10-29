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

function toolTipPopup(
  className = "popup-mes",
  parentClassName = "product-card__actions",
  delay = 7000
) {
  const popUps = document.querySelectorAll(`.${className}`);
  if (!popUps || !popUps.length) {
    return;
  }
  popUps.forEach((popItem) => {
    try {
      const popParent = popItem.closest(`.${parentClassName}`);
      if (!popParent) {
        throw new Error("[toolTipPopup] cant find parent");
      }
      let timer = false;
      // popParent.style.position = 'relative';
      if (!popItem.classList.contains("noflash")) {
        popParent.classList.add("active");
        timer = setTimeout(() => {
          popParent.classList.remove("active");
        }, delay);
      }
      document.addEventListener("click", (e) => {
        e.stopPropagation();
        const { target } = e;
        // if (!target.closest(`.${className}`) || target.classList.contains(`${className}__close`)) {
        if (target.closest(`.${parentClassName}`) !== popParent || target.classList.contains(`${className}__close`)) {
          timer && clearTimeout(timer);
          popParent.classList.remove("active");
        } else {
          console.log(target);
          
          popParent.classList.add("active");
        }
      });
    } catch (e) {
      console.warn("[toolTipPopup]", e);
    }
  });
}

/**
 * example usage
       <div class="popup-mes">
          {* <p class="popup-mes__header">Снижение цены!</p> *}
          <p class="popup-mes__body">Товар можно посмотреть вживую в нашем шоу-руме!</p>
          <span class="popup-mes__close"></span>
      </div>
 */
