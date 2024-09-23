# Модуль для обеспечения работы динамического калькулятора количества товара

На данный момент не протестировано полностью, в проекте надеюсь организовать JS по схожим принципам.

Базовый класс создан из принципа - обеспечить функционал чисто для одного инпута "Количество", с планом вдальнейшем пересадить на него все карточки товаров и листингов.
Сейчас его наследует и расширяет CalculatorWidth - для профлиста, где задана ширина листа.

Добавил возможность сохранять значения инпутов в localStorage-подобный объект (по умолчанию localStorage), для листингов уникализировать хэши полей.

Инпуты отрабатывает класс CalculatorInput, возможно его тоже вынести в полноценный модуль, сделать базовый класс, наследовать и реализовать селекты, чекбоксы разные инпуты.

С именами селекторов большая беда, т.к. уже готовый сайт и часть функционала уже привязаны к каким-то классам.
Смотреть ./example.tpl

Для работы с MS корзиной отдельный класс, также для работы с unit

Используется для демонстрации новый Logger на замену console.log

## TODO
- допилить для карточек, где есть переключалка единиц изменения
- допилить для листингов, 
- протестировать
- оптимизировать архитектуру

## Пример инициализации
```js
export default function initSquareMetersHandler() {
  try {
    const calculators = document.querySelectorAll(".calcProduct");
    logger.log(`FOUND ${calculators.length} PRODUCTS`);

    calculators.forEach((calculator) => {
      const product = calculator.closest(".js-product");
      let currentSize; // closure
      function togglePriceFontSize(size = 22) {
        // this контекст будет заменен на контекст объекта CalculatorWidth
        const isBig = this.priceBase * this.volume > 9999;
        const haveResult = "result" in this.nodes;
        if (haveResult) {
          currentSize = currentSize || parseFloat(getComputedStyle(this.nodes.result.price).fontSize);
          logger.log(`Result price font set to ${isBig ? size : currentSize}`);
          this.nodes.result.price.style.fontSize = `${
            isBig ? size : currentSize
          }px`;
        }
      }
      if (product) {
        new CalculatorWidth(product, () =>
          logger.log("Product calc created")
        ).addListener(togglePriceFontSize);
      }
    });
  } catch (e) {
    logger.error("Ошибка инициализации счетчиков", e);
  }
}
```

**@tedgregory**
