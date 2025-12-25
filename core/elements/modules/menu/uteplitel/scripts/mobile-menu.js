document.addEventListener("DOMContentLoaded", function () {
  const mobileMenu = document.querySelector(".mobile-menu");
  if (!mobileMenu) return;
  const backButton = mobileMenu.querySelector(".mobile-menu__back");
  const menuTitle = mobileMenu.querySelector(".mobile-menu__title");
  // const buttonBurger = document.querySelector(".js-burger-2");

  let menuHistory = [];

  // if (buttonBurger) {
  //   buttonBurger.addEventListener("click", function () {
  //     if (mobileMenu.classList.contains("active")) {
  //       mobileMenu.classList.remove("active");
  //     } else {
  //       mobileMenu.classList.add("active");
  //     }
  //   });
  // }

  if (mobileMenu) {
    // Обработчик клика по пунктам меню
    mobileMenu.addEventListener("click", function (e) {
      const link = e.target.closest(".mobile-menu__link");
      if (!link) return;

      const submenuId = link.dataset.submenu;
      if (submenuId) {
        e.preventDefault();
        const submenu = mobileMenu.querySelector(`[data-menu="${submenuId}"]`);
        if (submenu) {
          // Сохраняем историю навигации
          menuHistory.push({
            menu: mobileMenu.querySelector(".mobile-menu__list.active"),
            title: menuTitle.textContent,
          });

          // Активируем подменю
          mobileMenu
            .querySelectorAll(".mobile-menu__list.active")
            .forEach((menu) => menu.classList.remove("active"));
          submenu.classList.add("active");

          // Обновляем заголовок и показываем кнопку "Назад"
          menuTitle.textContent = link.querySelector("span").textContent;
          backButton.classList.add("visible");
        }
      }
    });
  }

  if (backButton) {
    // Обработчик клика по кнопке "Назад"
    backButton.addEventListener("click", function () {
      if (menuHistory.length) {
        const prevMenu = menuHistory.pop();

        // Возвращаем предыдущее меню
        mobileMenu
          .querySelectorAll(".mobile-menu__list.active")
          .forEach((menu) => menu.classList.remove("active"));
        prevMenu.menu.classList.add("active");

        // Обновляем заголовок
        menuTitle.textContent = prevMenu.title;

        // Скрываем кнопку "Назад" если вернулись в корневое меню
        if (!menuHistory.length) {
          backButton.classList.remove("visible");
        }
      }
    });
  }
});
