import { getActiveForm, prettify } from "./product/utils";

// сильно завязано на бэкэнд, пока не придумал, что можно придумать, выводится в шаблоне как data-аттрибуты со значением коэффифиента умножения
const unitsMap = {
  '1': 1,
  '2': 'data-m2',
  '3': 'data-m3',
  '4': 'data-pm',
  '5': 'data-list',
  '6': 'data-thing',
  '7': 'data-pilomat_thing',
  '8': 'data-k_m2seam',
  '9': 'data-k_m3seam',
  '10': 'data-meter',
  '11': 'data-upk',
  '12': 'data-pdn',
};

export default function initSquareMetersHandler() {
  try {
    // Находим все элементы с классом "counter"
    const counters = document.querySelectorAll(".product-counter");
    if (!counters) {
      console.log("no counters on page");

      return; // quietly stop script
    }
    // Проходимся по каждому счетчику
    counters.forEach((counter) => {
      const input = counter.querySelector(".counter__input");
      const increaseBtn = counter.querySelector(".increase");
      const decreaseBtn = counter.querySelector(".decrease");
      const minValue = parseInt(input.dataset.min)
        ? parseInt(input.dataset.min)
        : 1;
      const maxValue = parseInt(input.dataset.max)
        ? parseInt(input.dataset.max)
        : 10000000000000;
      const step = parseInt(input.dataset.step); // Получаем шаг, если он задан
      let previousValue = parseFloat(input.value); // Переменная для хранения предыдущего значения

      const calculatorObject = initObjectCalculculatorSquareMeter();

      calculculatorSquareMeter(calculatorObject);
      handlerFormCalculatorSquareMeter(calculatorObject);

      // Функция увеличения значения
      increaseBtn.addEventListener("click", () => {
        let value = parseFloat(input.value);
        if (value < maxValue) {
          input.value = value + step; // Округляем до двух знаков после запятой
        }
      });

      // Функция уменьшения значения
      decreaseBtn.addEventListener("click", () => {
        let value = parseFloat(input.value);
        if (value - step > minValue) {
          input.value = value - step; // Округляем до двух знаков после запятой
        } else {
          input.value = minValue; // Округляем до двух знаков после запятой
        }
      });

      // Запрет ввода всего кроме цифр через событие input
      input.addEventListener("input", () => {
        input.value = input.value.replace(/[^\d\.]/g, ""); // Оставляем только цифры и точку
      });

      // Сохранение предыдущего значения при фокусе
      input.addEventListener("focus", () => {
        previousValue = parseFloat(input.value);
        input.value = ""; // Очищаем поле ввода при фокусе
      });

      // Проверка значения после потери фокуса
      input.addEventListener("blur", () => {
        if (input.value === "") {
          input.value = previousValue; // Восстанавливаем предыдущее значение, если ничего не введено
        } else {
          let value = parseFloat(input.value);
          // минимальное значение
          if (value < minValue) {
            input.value = minValue;
          }
          // максималдьное значение
          if (value >= maxValue) {
            input.value = maxValue;
          }
        }
      });
    });
  } catch (e) {
    console.error("Ошибка инициализации счетчиков", e);
  }
}

/**
 * Функция инициализирует объект для калькулятора, вычисляющего квадратный метр товара.
 * @return объект с именем «calculatorObject». - содержит обьект
 * {
 *     inputCount: input поле количества листов
 *     inputLong: input поле длинны
 *     inputWidth: input скрытое поле ширины
 *     result: блок вывода результата
 *     productCart: карточка товара
 * }
 *
 */
function initObjectCalculculatorSquareMeter() {
  const parentCalcNode = document.querySelector(".product-info__actions");
  if (parentCalcNode) {
    const calculatorObject = {
      inputCount: parentCalcNode.querySelector("[name='count']"),
      inputLong: parentCalcNode.querySelector("[name='long']"),
      inputWidth: parentCalcNode.querySelector("[name='width']"),
      result: parentCalcNode.querySelector(".resultSum"),
      productCart: parentCalcNode.closest(".js-product"),
    };

    return calculatorObject;
  }
}

/**
 * Функция вычисляет квадратный метр и цену на основе входных ширины и длины и обновляет результат.
 * соответственно.
 * @param calculatorObject - КалькуляторОбъект — это объект
 */
function calculculatorSquareMeter(calculatorObject) {
  const price =
    calculatorObject.productCart.querySelector(".js-product__price").dataset
      .default || 0;
  const result = {
    count: 0,
    count_m2: 0,
    count_rub: 0,
  };
  // проверка на наличие ширины, если есть то расчет идет в квадтраных метрах, если нет то расчет идет в кол
  if (calculatorObject.inputWidth.value == "") {
    // скрываем блок подсчета метра квадратных
    calculatorObject.result.querySelector(".resultSum-m2").style.display =
      "none";
    // скрываем блок выбора длинны листа
    calculatorObject.inputLong.closest(".counter").style.display = "none";
    result.count_rub = price * calculatorObject.inputCount.value;
    // вывод расчета в рублях
    calculatorObject.result.querySelector(".resultSum-rub .value").innerText =
      prettify(result.count_rub);
    result.count = calculatorObject.inputCount.value;
  } else {
    const longMeter = calculatorObject.inputLong.value / 1000;
    const widthMeter = calculatorObject.inputWidth.value / 1000;
    const meter = longMeter * widthMeter;
    const sum = meter * calculatorObject.inputCount.value;
    result.count_m2 = sum.toFixed(2);
    result.count_rub = sum.toFixed(2) * price;
    calculatorObject.result.querySelector(".resultSum-m2 .value").innerText =
      result.count_m2;
  }
  calculatorObject.result.querySelector(".resultSum-rub .value").innerText =
    prettify(result.count_rub.toFixed(0));

  return result;
}

/**
 * Функция рассчитывает квадратный метр товара и обновляет количество в корзине товаров.
 * @param CalculatorObject — объект, содержащий информацию о калькуляторе, например ProductCart (массив
 *товары в корзине) и другие свойства, необходимые для расчета.
 */
function calculculatorSquareMeterHandler(calculatorObject) {
  let resultObject = calculculatorSquareMeter(calculatorObject);
  let count = resultObject.count_m2 || resultObject.count || 1;

  updateCountCart(calculatorObject.productCart, count);
}

/**
 * Функция обновляет количество товаров в корзине и отправляет форму, если товар уже находится в корзине.
 * @param {HTMLElement} productCart — параметр ProductCart — это ССЫЛКА НА ЭЛЕМЕНТ - убейте в себе jquery, представляющий карточку товара.
 * @param count — параметр count представляет новое количество товаров в корзине.
 */
function updateCountCart(productCart, count) {
  const forms = getActiveForm(productCart); 
  const systemForm = forms["system"]; // get HTML Element 
  systemForm.querySelector('[name="count"]').setAttribute('value',`${count}`);
  // console.log(`Found  product card, update count ${$systemForm.querySelector('[name="count"]').value} to ${count}`);
  if (productCart.classList.contains("js-product-in-cart")) {
    systemForm.querySelector('[type="submit"]').click();
  }
}

/**
 * Функция handlerFormCalculatorSquareMeter обрабатывает события ввода и события щелчка для объекта калькулятора и вызывает
 * функцию «calculculatorSquareMeterHandler» при выполнении определенных условий.
 * @param CalculatorObject — объект
 */
function handlerFormCalculatorSquareMeter(calculatorObject) {
  // событие ввода в длинны
  calculatorObject.inputLong.addEventListener("input", function ({ target }) {
    if (
      target.value > target.dataset.min &&
      target.value < target.dataset.max
    ) {
      calculculatorSquareMeterHandler(calculatorObject);
    }
  });

  calculatorObject.inputLong.addEventListener("blur", function ({ target }) {
    if (
      target.value > target.dataset.min &&
      target.value < target.dataset.max
    ) {
      calculculatorSquareMeterHandler(calculatorObject);
    }
  });

  //событие ввода количества
  calculatorObject.inputCount.addEventListener("input", function ({ target }) {
    if (target.value > target.dataset.min) {
      calculculatorSquareMeterHandler(calculatorObject);
    }
  });

  // событие увеличение, уменьшении
  document.querySelectorAll(".increase, .decrease").forEach((button) => {
    button.addEventListener("click", () => {
      setTimeout(() => {
        calculculatorSquareMeterHandler(calculatorObject);
      }, 0);
    });
  });
}
