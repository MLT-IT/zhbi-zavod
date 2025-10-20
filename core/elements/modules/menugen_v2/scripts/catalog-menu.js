
function catalogMenu() {
  document.addEventListener("DOMContentLoaded", () => {
      const menuItems = document.querySelectorAll(".menu__item");
      const submenus = document.querySelectorAll(".submenu__list");
      const children2 = document.querySelectorAll(".submenu[data-level='2'] a");

      try {
          menuItems.forEach((item, index) => {
              item.dataset.index = index;
              submenus[index]?.setAttribute("data-index", index);

              item.addEventListener("mouseover", function () {
                  const index = this.dataset.index;

                  menuItems.forEach(el => el.classList.remove("active"));
                  submenus.forEach(sub => sub.classList.remove("active"));

                  this.classList.add("active");
                  document.querySelector(`.submenu__list[data-index="${index}"]`)?.classList.add("active");
              });
          });
      } catch (e) {
          console.error("Ошибка обработчика меню:", e);
      }

      try {
          children2.forEach(item => {
              item.addEventListener("mouseover", event => {
                  const index = event.target.dataset.index;
                  const children3 = document.querySelectorAll(".submenu[data-level='3'] .submenu__list");

                  children3.forEach(child3 => child3.classList.remove("active"));

                  document.querySelector(`.submenu[data-level='3'] #submenu-${index}`)?.classList.add("active");
              });
          });
      } catch (e) {
          console.error("Ошибка переключения меню 3 уровня:", e);
      }

      //Споилер в каталоге
      (function(){
          try{
              const btn = document.querySelector('.menu_v4 .submenu__spoiler-btn');
              if(!btn)return;
              btn.addEventListener('click', function(e) {
                  e.preventDefault();
                  const btn = this;
                  const ul = this.closest('ul');
                  if(!ul)throw 'Can\'t find ul';
                  const elems = ul.querySelectorAll('.submenu__spoiler-li');
                  if(elems[0].classList.contains('shown')){ //hiding
                      elems.forEach((elem) => {
                          elem.classList.remove('shown');
                      });
                      btn.innerHTML = 'Показать еще';
                  }else{ //showing
                      elems.forEach((elem) => {
                          elem.classList.add('shown');
                      });
                      btn.innerHTML = 'Скрыть';
                  }
              });
          }catch(e) {
              console.error(e);
          }
      })();

      //Споилер в мобильном меню
      (function(){
          try{
              const btn = document.querySelector('.js-mobile_menu_v4 .js-header__nav-spoiler');
              if(!btn)return;
              //console.log('found!');
              btn.addEventListener('click', function(e) {
                  e.preventDefault();
                  const btn = this;
                  const ul = this.closest('.js-header__nav-content');
                  if(!ul)throw 'Can\'t find ul';
                  const elems = ul.querySelectorAll('.js-header__nav-spoiler-item');
                  if(elems[0].classList.contains('shown')){ //hiding
                      elems.forEach((elem) => {
                          elem.classList.remove('shown');
                      });
                      btn.innerHTML = 'Показать еще';
                  }else{ //showing
                      elems.forEach((elem) => {
                          elem.classList.add('shown');
                      });
                      btn.innerHTML = 'Скрыть';
                  }
              });
          }catch(e) {
              console.error(e);
          }
      })();
  });
}


export {
    catalogMenu
}