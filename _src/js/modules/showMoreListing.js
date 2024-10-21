import collapseLongTexts from "./collapseLontTexts";

// по приколу сделал на прототипах: методы и свойства накидываются прямо на DOM элементы списков
// всё, что нужно, это добавить класс из config.listClass к врапперу, остальное само будет работать

const config = {
  listClass: "show-more-listing",
  buttonClassBase: "show-more-button", // найдется или добавится с этим классом после враппера
  buttonClassName: "", // если добавляется, мало ли понадобится, можно на все кнопки накинуть строку целиком, например "btn btn_style_base"
  buttonTextOn: "Показать еще",
  buttonTextOff: "Скрыть",
  groupSize: 3,
  startCount: 6,
};

export default function showMoreListing() {
  const lists = document.querySelectorAll(`.${config.listClass}`);
  lists.length &&
    lists.forEach((list) => {
      listingLog("Creating show-more wrap");
      listingLog(
        `Got dataset startCount = ${list.dataset.startCount}, groupSize = ${list.dataset.groupSize}`
      );
      list.groupSize = +(list.dataset.groupSize || config.groupSize);
      list.startCount = +list.dataset.startCount || config.startCount;
      list.count = list.startCount;
      if (!list.children.length || list.children.length < list.count) {
        listingLog("Group is less than initial size, skip show-more");
        return;
      }
      // list.children.length &&
      //   [...list.children].forEach((element, i) => {
      //     if (i >= list.count) {
      //       element.classList.add("hidden");
      //     }
      //   });
      list.showMore = showMore;
      list.showMore();
      makeMoreButton(list);
    });
}

function showMore() {
  if (!this.children.length) {
    console.log(`Can't show more on empty`);
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
  if (!list instanceof HTMLElement || list.children.length < list.groupSize) {
    listingLog(`Skip adding more button`);
    return;
  }
  let button = list.parentElement.querySelector(`.${config.buttonClassBase}`);
  if (!button) {
    button = document.createElement("div");
    button.className = `${config.buttonClassBase} ${config.buttonClassName}`;
    button.innerText = config.buttonTextOn;
    button.addEventListener("click", () => {
      listingLog(`CURRENT COUNT: ${list.count}, ADDING: ${list.groupSize}, CHILDREN: ${list.children.length}`);
      list.count += list.count ? list.groupSize : list.startCount;
      listingLog(`ROUGH RESULT: ${list.count}`);
      list.showMore();
      if (list.count >= list.children.length) {
        list.count = 0;
        listingLog(`END OF LIST, COUNT IS: ${list.count}`);
        button.innerText = config.buttonTextOff;
      } else {
        button.innerText = config.buttonTextOn;
      }
    });
    list.parentElement.append(button);
  }
}

function listingLog(...args){
  return console.log('%c%s', 'background-color: #111',` showMore: `, ...args);
}
