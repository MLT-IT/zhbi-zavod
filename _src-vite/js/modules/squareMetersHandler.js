import CalculatorWidth from "../../../core/elements/_modules/product/CalculatorWidth";

export default function initSquareMetersHandler() {
  try {
    const calculators = document.querySelectorAll(".calcProduct");
    console.log(`FOUND ${calculators.length} PRODUCTS`);

    calculators.forEach((calculator) => {
      const product = calculator.closest(".js-product");
      let currentSize; // closure
      function togglePriceFontSize(size = 22) {
        // this контекст будет заменен на контекст объекта CalculatorWidth
        const isBig = this.priceBase * this.volume > 9999;
        const haveResult = "result" in this.nodes;
        if (haveResult) {
          currentSize = currentSize || parseFloat(getComputedStyle(this.nodes.result.price).fontSize);
          console.log(`Result price font set to ${isBig ? size : currentSize}`);
          this.nodes.result.price.style.fontSize = `${
            isBig ? size : currentSize
          }px`;
        }
      }
      if (product) {
        new CalculatorWidth(product, () =>
          console.log("Product calc created")
        ).addListener(togglePriceFontSize);
      }
    });
  } catch (e) {
    console.error("Ошибка инициализации счетчиков", e);
  }
}

// Для справки актуальный код из funcsProduct

// /**
//  * Функция инициализирует объект для калькулятора, вычисляющего квадратный метр товара.
//  * @return объект с именем «calculatorObject». - содержит обьект
//  * {
//  *     inputCount: input поле количества листов
//  *     inputLong: input поле длинны
//  *     inputWidth: input скрытое поле ширины
//  *     result: блок вывода результата
//  *     productCart: карточка товара
//  * }
//  *
//  */
// function initObjectCalculculatorSquareMeter() {
//   const parentCalcNode = document.querySelector(".product-info__actions");
//   if (parentCalcNode) {
//     const calculatorObject = {
//       inputCount: parentCalcNode.querySelector("[name='count']"),
//       inputLong: parentCalcNode.querySelector("[name='long']"),
//       inputWidth: parentCalcNode.querySelector("[name='width']"),
//       result: parentCalcNode.querySelector(".resultSum"),
//       productCart: parentCalcNode.closest(".js-product"),
//     };

//     return calculatorObject;
//   }
// }

// /**
//  * Функция вычисляет квадратный метр и цену на основе входных ширины и длины и обновляет результат.
//  * соответственно.
//  * @param calculatorObject - КалькуляторОбъект — это объект
//  */
// function calculculatorSquareMeter(calculatorObject) {
//   const price =
//     calculatorObject.productCart.querySelector(".js-product__price").dataset
//       .default || 0;
//   const result = {
//     count: 0,
//     count_m2: 0,
//     count_rub: 0,
//   };
//   // проверка на наличие ширины, если есть то расчет идет в квадтраных метрах, если нет то расчет идет в кол
//   if (calculatorObject.inputWidth.value == "") {
//     // скрываем блок подсчета метра квадратных
//     calculatorObject.result.querySelector(".resultSum-m2").style.display =
//       "none";
//     // скрываем блок выбора длинны листа
//     calculatorObject.inputLong.closest(".counter").style.display = "none";
//     result.count_rub = price * calculatorObject.inputCount.value;
//     // вывод расчета в рублях
//     calculatorObject.result.querySelector(".resultSum-rub .value").innerText =
//       prettify(result.count_rub);
//     result.count = calculatorObject.inputCount.value;
//   } else {
//     const longMeter = calculatorObject.inputLong.value / 1000;
//     const widthMeter = calculatorObject.inputWidth.value / 1000;
//     const meter = longMeter * widthMeter;
//     const sum = meter * calculatorObject.inputCount.value;
//     result.count_m2 = sum.toFixed(2);
//     result.count_rub = sum.toFixed(2) * price;
//     calculatorObject.result.querySelector(".resultSum-m2 .value").innerText =
//       result.count_m2;
//   }
//   calculatorObject.result.querySelector(".resultSum-rub .value").innerText =
//     prettify(result.count_rub.toFixed(0));

//   return result;
// }

// /**
//  * Функция рассчитывает квадратный метр товара и обновляет количество в корзине товаров.
//  * @param CalculatorObject — объект, содержащий информацию о калькуляторе, например ProductCart (массив
//  *товары в корзине) и другие свойства, необходимые для расчета.
//  */
// function calculculatorSquareMeterHandler(calculatorObject) {
//   let resultObject = calculculatorSquareMeter(calculatorObject);
//   let count = resultObject.count_m2 || resultObject.count || 1;

//   updateCountCart(calculatorObject.productCart, count);
// }

// /**
//  * Функция обновляет количество товаров в корзине и отправляет форму, если товар уже находится в корзине.
//  * @param {HTMLElement} productCart — параметр ProductCart — это ССЫЛКА НА ЭЛЕМЕНТ - убейте в себе jquery, представляющий карточку товара.
//  * @param count — параметр count представляет новое количество товаров в корзине.
//  */
// function updateCountCart(productCart, count) {
//   const forms = getActiveForm(productCart);
//   const systemForm = forms["system"]; // get HTML Element
//   systemForm.querySelector('[name="count"]').setAttribute("value", `${count}`);
//   console.log(
//     `Found  product card, update count ${
//       $systemForm.querySelector('[name="count"]').value
//     } to ${count}`
//   );
//   if (productCart.classList.contains("js-product-in-cart")) {
//     systemForm.querySelector('[type="submit"]').click();
//   }
// }

// /**
//  * Функция handlerFormCalculatorSquareMeter обрабатывает события ввода и события щелчка для объекта калькулятора и вызывает
//  * функцию «calculculatorSquareMeterHandler» при выполнении определенных условий.
//  * @param CalculatorObject — объект
//  */
// function handlerFormCalculatorSquareMeter(calculatorObject) {
//   // событие ввода в длинны
//   calculatorObject.inputLong.addEventListener("input", function ({ target }) {
//     if (
//       target.value > target.dataset.min &&
//       target.value < target.dataset.max
//     ) {
//       calculculatorSquareMeterHandler(calculatorObject);
//     }
//   });

//   calculatorObject.inputLong.addEventListener("blur", function ({ target }) {
//     if (
//       target.value > target.dataset.min &&
//       target.value < target.dataset.max
//     ) {
//       calculculatorSquareMeterHandler(calculatorObject);
//     }
//   });

//   //событие ввода количества
//   calculatorObject.inputCount.addEventListener("input", function ({ target }) {
//     if (target.value > target.dataset.min) {
//       calculculatorSquareMeterHandler(calculatorObject);
//     }
//   });

//   // событие увеличение, уменьшении
//   document.querySelectorAll(".increase, .decrease").forEach((button) => {
//     button.addEventListener("click", () => {
//       setTimeout(() => {
//         calculculatorSquareMeterHandler(calculatorObject);
//       }, 0);
//     });
//   });
// }
