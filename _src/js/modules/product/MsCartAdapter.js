

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
        count: '[name="count"',
      },
    },
    inCartClassName: "js-product-in-cart", // no dot!
  };

  constructor(elem) {
    if (!elem instanceof HTMLElement) {
      console.log("Node invalid");
      return false;
    }
    if (elem.classList.contains(this.config.selectors.product)) {
      this.product = elem;
    } else {
      this.product = document.querySelector(this.config.selectors.product);
    }
    if (!this.product) {
      console.log("Product with cart not found");
      return false;
    }
  }

  update(val) {
    const { form, action } = this.getFormAndAction();
    form.querySelector(this.config.selectors.forms.count).value = val;
    if (this.isInCart()) {
      action.click();
    }
  }

  getActiveForm() {
    if (this.isInCart()) {
      return this.product.querySelector(
        `.${this.config.selectors.forms.change}`
      );
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

  isInCart() {
    // inCartClassName устанавливается в другом коде вообще, по клику на кнопку "В корзину", здесь из ДОМ просто проверяем
    return this.product.classList.contains(this.inCartClassName);
  }
}
