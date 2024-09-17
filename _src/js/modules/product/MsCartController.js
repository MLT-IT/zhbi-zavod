import logger from "../debug/Logger";

export class MsCartController {
  product = null;
  config = {
    selectors: {
      product: {
        wrapper: ".js-product",
        price: ".js-product__price",
      },
      forms: {
        add: ".js-product__form-add",
        change: ".js-product__form-change",
        action: '[name="ms2_action"]',
        count: '[name="count"]',
      },
    },
    inCartClassName: "js-product-in-cart", // no dot!
  };

  constructor(elem) {
    if (!elem instanceof HTMLElement) {
      logger.log("Node invalid");
      return false;
    }
    if (elem.classList.contains(this.config.selectors.product.wrapper.substr(1))) {
      // logger.log(`Product classes ${elem.classList}`)
      this.product = elem;
    } else {
      this.product = document.querySelector(
        this.config.selectors.product.wrapper
      );
    }
    if (!this.product) {
      logger.log("Product with cart not found");
      return false;
    }
  }

  get price() {
    const priceNode = this.product.querySelector(
      this.config.selectors.product.price
    );
    const result =
      +priceNode.value ||
      +priceNode.dataset.val ||
      +priceNode.dataset.default ||
      parseFloat(priceNode.innerText) ||
      0;
    // logger.log(`Base price is ${result}`);
    return result;
  }

  get isInCart() {
    // inCartClassName устанавливается в другом коде вообще, по клику на кнопку "В корзину", здесь из ДОМ просто проверяем
    logger.log(`Checking inCart status; Product classes: ${[...this.product.classList]}`)
    return this.product.classList.contains(this.config.inCartClassName);
  }

  update(val) {
    try {
      const { form, action } = this.getFormAndAction();
      action.addEventListener('click', (e) => logger.warn('Action button triggered', e.target))
      const countField = form.querySelector(this.config.selectors.forms.count);
      logger.log(`Product in cart: ${this.isInCart}`);
      logger.log(
        `Updating cart volume = ${val} in place of ${
          countField.value
        }`
      );
      countField.setAttribute("value", val);
      countField.value = val;
      logger.log(
        `New form input value = ${
          countField.value
        }`
      );

      if (this.isInCart) {
        // send hidden form of current product
        // already triggers in funcsProduct, but should certainly be here
        logger.log("Product in cart, sending update to MS");
        action.click();
      }
    } catch (e) {
      logger.error("error updating cart", e);
    }
  }

  getActiveForm() {
    if (this.isInCart) {
      return this.product.querySelector(this.config.selectors.forms.change);
    } else {
      return this.product.querySelector(this.config.selectors.forms.add);
    }
  }

  getFormAndAction() {
    const form = this.getActiveForm();
    const action = form.querySelector(this.config.selectors.forms.action);
    return {
      form,
      action,
    };
  }
}
