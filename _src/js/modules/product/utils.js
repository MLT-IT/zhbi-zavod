/**
 * 
 * @param {string} num Строка для форматирования 
 * @returns 
 */
export function prettify(num) {
  try {
    var n = num;
    var separator = " ";
    return n.replace(/(\d{1,3}(?=(?:\d\d\d)+(?!\d)))/g, "$1" + separator);
  } catch {
    return num;
  }
}


/**
 * 
 * @param {HTMLElement} productItem - 
 * @returns 
 */
export function getActiveForm(productItem, classInCart = "js-product-in-cart" ) {

  if (productItem.hasClass(classInCart)) {
    // Товар уже в корзине, нужно изменить кол-во
    $formService = productItem.find(".js-product__form-change");
    $formAction = productItem.find(".js-product__controls_action_change");
  } else {
    // Товара нет в корзине
    $formService = productItem.find(".js-product__form-add");
    $formAction = productItem.find(".js-product__controls_action_add");
  }

  return {
    system: $formService,
    action: $formAction,
  }
}
