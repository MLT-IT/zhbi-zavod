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

  function closeOne(item, parent, e, timer = null){
    if(e.target.closest(`.${parentClassName}`) !== parent||e.target.classList.contains(`${className}__close`)) {
      timer && clearTimeout(timer);
      parent.classList.remove("active");
      item.style = '';
    }
  }

  popUps.forEach((popItem) => {
    try {
      const popParent = popItem.closest(`.${parentClassName}`);
      if (!popParent) {
        throw new Error("[toolTipPopup] cant find parent");
      }
      let timer = false;

      if (!popItem.classList.contains("noflash")) {
        popParent.classList.add("active");
        timer = setTimeout(() => {
          popParent.classList.remove("active");
        }, delay);
      }

      const evt = popItem.dataset['event'];
      //console.log(evt);
      switch(evt){
        case 'hover':
          popParent.addEventListener('mouseover', (e) => {
            const p = e.target.closest(`.${parentClassName}`);
            //console.log('hover! ');
            //console.log(p);
            const opened =  document.querySelectorAll(`.${parentClassName}`);
            //console.log(opened);
            opened.forEach((item) => {
              if(!item.classList.contains('active'))return;
              item.classList.remove("active");
              const popup = item.querySelector(`.${className}`);
              if(popup)popup.style = '';
              //console.log(popup);
            });           
            p.classList.add("active");
            fixModalPosition(popItem);
            
          });
          document.addEventListener("click", (e) => {
            closeOne(popItem, popParent, e, timer);
          });
        break;
        default:
          document.addEventListener("click", (e) => {
            e.stopPropagation();
            const { target } = e;
            // if (!target.closest(`.${className}`) || target.classList.contains(`${className}__close`)) {
            closeOne(popItem, popParent, e, timer);
            if(target.closest(`.${parentClassName}`) === popParent && !target.classList.contains(`${className}__close`)){
              popParent.classList.add("active");
              fixModalPosition(popItem);
            }
          });
        break;
      }

      
    } catch (e) {
      console.warn("[toolTipPopup] Error", e);
    }
  });
}

/**
 * 
 * @param {HTMLElement} modal 
 */
function fixModalPosition(modal) {
  const parent = modal.parentElement;
  const parentLeft = parent.getBoundingClientRect().left;
  const rect = modal.getBoundingClientRect();
  const { left, width } = rect;
  const { innerWidth } = window;
  console.log(`left:${left}, width:${width}, innerWidth:${innerWidth}`);
  
  if (left < 0 ) {
    // modal.style.transform = `translateX(90%)`;
    modal.style.left = `${10 - parentLeft}px`;
  }
  if (left+width > innerWidth) {
    // modal.style.transform = `translateX(-${Math.abs(left+width-innerWidth)+10}px)`;
    modal.style.left = `${innerWidth - width - 10 + parentLeft}px`;
  }
}

/**
 * example usage
       <div class="popup-mes">
          {* <p class="popup-mes__header">Снижение цены!</p> *}
          <p class="popup-mes__body">Товар можно посмотреть вживую в нашем шоу-руме!</p>
          <span class="popup-mes__close"></span>
      </div>
 */
