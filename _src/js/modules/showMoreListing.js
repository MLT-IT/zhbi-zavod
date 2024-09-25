import logger from "../../../core/elements/_modules/debug/Logger";
import collapseLongTexts from "./collapseLontTexts";

// по приколу сделал на прототипах: методы и свойства накидываются прямо на DOM элементы списков
// всё, что нужно, это добавить класс из config.listClass к врапперу, остальное само будет работать

const config = {
  listClass: "show-more-listing",
  buttonClassBase: "show-more-button", // найдется или добавится с этим классом после враппера
  buttonClassName: "", // если добавляется, мало ли понадобится, можно на все кнопки накинуть строку целиком, например "btn btn_style_base"
  buttonTextOn: "Показать еще",
  buttonTextOff: "Скрыть",
  groupSize: 6,
};

export default function showMoreListing() {
  const lists = document.querySelectorAll(`.${config.listClass}`);
  lists.length &&
    lists.forEach((list) => {
      logger.log("Creating show-more wrap");
      list.groupSize = +(list.dataset.groupSize || config.groupSize); 
      list.count = list.groupSize;
      list.children.length &&
        [...list.children].forEach((element, i) => {
          if (i >= list.count) {
            element.classList.add("hidden");
          }
        });
      list.showMore = showMore;
      makeMoreButton(list);
    });
}

function showMore() {
  if (!this.children.length) {
    logger.log(`Can't show more on empty`);
    return;
  }
  [...this.children].forEach((element, i) => {
    if (i >= this.count) {
      element.classList.add("hidden");
    } else {
      element.classList.remove("hidden");
    }
  });
  collapseLongTexts(); // .hidden display:none, чтобы отрабатывало на открытых item
}

function makeMoreButton(list) {
  if (
    !list instanceof HTMLElement ||
    list.children.length < list.groupSize
  ) {
    logger.log(`Skip adding more button`);
    return;
  }
  let button = list.parentElement.querySelector(`.${config.buttonClassBase}`);
  if (!button) {
    button = document.createElement("div");
    button.className = `${config.buttonClassBase} ${config.buttonClassName}`;
    button.innerText = config.buttonTextOn;
    button.addEventListener("click", () => {
      list.count += list.groupSize;
      list.showMore();
      if (list.count >= list.children.length) {
        button.innerText = config.buttonTextOff;
        list.count = 0;
      } else {
        button.innerText = config.buttonTextOn;
      }
    });
    list.parentElement.append(button);
  }
}
