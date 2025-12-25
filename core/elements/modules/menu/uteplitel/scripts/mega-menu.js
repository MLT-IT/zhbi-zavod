const menu = document.querySelector(".menu-uteplitel");
const itemsCatalog = document.querySelectorAll(".menu-uteplitel__catalog-item");
const submenusCatalog = document.querySelectorAll(
  ".menu-uteplitel__catalog-submenu"
);
const submenuContainers = document.querySelectorAll(".menu-uteplitel__submenu");
const itemsMenu = document.querySelectorAll(".menu-uteplitel__item");

// const catalogsButton = document.querySelectorAll(
//   '[data-catalog-open="catalog-modal-desktop"]'
// );

// Инициализация обработчиков для кнопок "Смотреть все"
handlersButtonShowMore(submenuContainers);

// Обработка кликов для элементов каталога
setupClickHandlers(itemsCatalog);

// Обработка кликов для элементов меню
setupClickHandlers(itemsMenu);

document.body.addEventListener("click", () => {
  if (!menu) return;
  if (!menu.contains(event.target)) {
    menu.classList.remove("active");
  }
});

// catalogsButton.forEach((button) => {
//   button.addEventListener("click", () => {
//     if (menu.classList.contains("active")) {
//       menu.classList.remove("active");
//     } else {
//       menu.classList.add("active");
//     }
//   });
// });

/**
 * Универсальная функция для настройки обработчиков кликов
 */
function setupClickHandlers(items) {
  items.forEach((item) => {
    item.addEventListener("click", (e) => {
      disabledItems(items); // Деактивируем все элементы
      showItem(item); // Активируем текущий элемент
      const dataMenuItem = getDataMenuAtribute(item); // Получаем значение атрибута data-menu
      e.preventDefault(); // Отменяем переход по ссылке

      disabledSubmenus(submenusCatalog); // Скрываем все подменю
      showSubmenu(submenusCatalog, dataMenuItem); // Показываем нужное подменю

      // Обновляем обработчики для кнопок "Смотреть все"
      handlersButtonShowMore(submenuContainers);
    });
  });
}

/**
 * Обработчики для кнопок "Смотреть все"
 */
function handlersButtonShowMore(submenuContainers) {
  submenuContainers.forEach((submenuContainer) => {
    let moreButtonContainer = submenuContainer.querySelector(
      ".menu-uteplitel__submenu-more"
    );
    let moreButton = submenuContainer.querySelector(
      ".menu-uteplitel__submenu-more-button"
    );
    let options = submenuContainer.querySelector(
      ".menu-uteplitel__submenu-options"
    );

    // Проверяем, переходят ли элементы на вторую строку
    if (moreButtonContainer) {
      moreButtonContainer.style.display = "block";

      if (options.scrollHeight > options.clientHeight) {
        moreButtonContainer.style.display = "block"; // Показываем кнопку
      } else {
        moreButtonContainer.style.display = "none"; // Скрываем кнопку, если элементы не переходят на вторую строку
      }
    }

    // Удаляем предыдущий обработчик, если он был
    if (moreButton) {
      moreButton.replaceWith(moreButton.cloneNode(true)); // Клонируем кнопку, чтобы удалить все обработчики
      moreButton = submenuContainer.querySelector(
        ".menu-uteplitel__submenu-more-button"
      ); // Получаем новую ссылку на кнопку

      // Добавляем новый обработчик
      moreButton.addEventListener("click", () => {
        if (options.classList.contains("expanded")) {
          options.classList.remove("expanded");
          moreButton.classList.remove("expanded");
          moreButton.textContent = "Смотреть все";
        } else {
          options.classList.add("expanded");
          moreButton.classList.add("expanded");
          moreButton.textContent = "Скрыть";
        }
      });
    }
  });
}

/**
 * Получает значение атрибута data-menu
 */
function getDataMenuAtribute(item) {
  return item.getAttribute("data-menu");
}

/**
 * Деактивирует все элементы
 */
function disabledItems(items) {
  items.forEach((item) => {
    item.classList.remove("active");
  });
}

/**
 * Активирует текущий элемент
 */
function showItem(item) {
  item.classList.add("active");
}

/**
 * Скрывает все подменю
 */
function disabledSubmenus(submenusCatalog) {
  submenusCatalog.forEach((submenu) => {
    submenu.classList.remove("active");
  });
}

/**
 * Показывает подменю по значению атрибута data-menu
 */
function showSubmenu(submenusCatalog, dataMenuItem) {
  submenusCatalog.forEach((submenu) => {
    if (submenu.getAttribute("data-submenu") === dataMenuItem) {
      submenu.classList.add("active");
    }
  });
}
