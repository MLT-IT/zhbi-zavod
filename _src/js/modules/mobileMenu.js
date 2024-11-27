/**
 * @param {querySelector} burger - burger selector
 * @param {querySelector} menu - menu selector
 */

import calcProperties from "../utils/calcProperties";

function Mobilemenu(burgerClass, menuClass) {

    const burger = document.querySelector(burgerClass);
    const menu = document.querySelector(menuClass);
    this.burger = burger;
    this.menu = menu;

    if (!burger || !menu) return;

    burger.addEventListener("click", toggleBurger); 

    const host = this;
    function toggleBurger(e) {
        host.toggleBurger(e);
    }
}

Mobilemenu.prototype.toggleBurger = function(e){
    calcProperties.calcHeaderHeight();
    e.preventDefault();
    this.burger.classList.toggle("active");
    this.menu.classList.toggle("active");
    document.body.classList.toggle("mobilemenu-opened");
}

class Mobilemenu_kirpichM5 extends Mobilemenu{
    constructor(burgerClass, menuClass){
        super(burgerClass, menuClass);
        this.makeDropDown();
    }

    //Это всплывающее подменю
    makeDropDown(){
        //console.log("Making dropdown...");
        //const scrollMargin = 20;
        const menu_link_class = ".burger-menu__nav-link";
        const submenu_visible = "burger-menu__submenu--visible";
        //const qMenuFilterBtn = ".burger-menu__filter-btn";
        //const qBtnFilter = ".catalog__filter > .filter__btn"; //Прячем кнопку с фильтрами, если на странице нет этих элементов
        
        //const html = document.querySelector("html");
        
        
        const menu_links = this.menu.querySelectorAll(menu_link_class);
        //console.log(menu_links);
        const links_with_dropdowns = []; //Пункты с субменю
        for(let menu_link of menu_links){
            //console.log(menu_link);
            const dropDown = menu_link.nextElementSibling;
            //console.log(dropDown);
            if(dropDown)links_with_dropdowns.push({
                    link: menu_link,
                    dropDown: dropDown
                });
            
        }
        //console.log(links_with_dropdowns.length);

        if(links_with_dropdowns.length < 1)return; //Нет пунктов со всплывающим меню, поэтому выход

        const touchContext = {
            touchStartAttached: false,
            touchStartStamp: 0,
            touchStart: false,
            touchDurationEdge: 800
        }
        if(typeof window.touchContext == "undefined"){
            window.touchContext = touchContext;
        }

        if(!window.touchContext.touchStartAttached){
            for(let item of links_with_dropdowns){
                item.link.addEventListener("touchstart", onTouchStart);
                item.link.addEventListener("mousedown", onTouchStart);
                item.link.addEventListener("touchend", onTouchEnd);
                item.link.addEventListener("mouseup", onTouchEnd);
            }
            document.addEventListener("touchstart", onHide);
            document.addEventListener("mousedown", onHide);
            window.touchContext.touchStartAttached = true;
        }


        //TODO: Кандидат на отдельный метод
        //Кнопка фильтров в мобильном меню, по которой открываются фильтры в каталоге
        //const menuFilterBtn = this.menu.querySelector(qMenuFilterBtn);
        //const btnFilter = document.querySelector(qBtnFilter);
        //console.log(btnFilter);
        /*
        if(!btnFilter){
            if(menuFilterBtn)menuFilterBtn.style.display = "none";
        }else{
            if(menuFilterBtn){
                menuFilterBtn.addEventListener("click", (e) => {
                    e.stopPropagation();
                    this.burger.click(); //Закрыть меню
                    btnFilter.click(); //Открыть фильтры в каталоге
                    const header = document.querySelector(".header-fixed .header__bottom");
                    let hHeight = 0;
                    if(header)hHeight = header.getBoundingClientRect().height;
                    html.scrollTop = (btnFilter.getBoundingClientRect().top + window.scrollY - hHeight - scrollMargin);
                });
            }
        }
        */

        function onTouchStart(e){
            e.preventDefault();
            e.stopPropagation();
            window.touchContext.touchStartStamp = e.timeStamp;
            window.touchContext.touchStart = true;
            //console.log(e.target);
            //console.log(e.target.nextElementSibling);
            const dropDown = e.target.nextElementSibling;
            if(dropDown)dropDown.classList.toggle(submenu_visible);
            checkLinkTransition(e.target);
        }
    
        function onTouchEnd(e){
            e.preventDefault();
            e.stopPropagation();
            window.touchContext.touchStart = false;
        }
    
        function onHide(e){
            /*for(let n in links_with_dropdowns){
                console.log(n," = ", links_with_dropdowns[n]);
            }*/
            for(const item of links_with_dropdowns){
                //console.log("item:");
                //console.log(item);
                const dropDown = item.dropDown;
                //console.log(item.dropDown);
                if(!dropDown || dropDown.contains(e.target))continue;
                dropDown.classList.remove(submenu_visible);
            }
        }
    
        function checkLinkTransition(menu_link){
            const m = performance.measure("q", {start: window.touchContext.touchStartStamp});
            if(m.duration > window.touchContext.touchDurationEdge){
                location.href = menu_link.getAttribute("href");
                window.touchContext.touchStart = false; 
            }
            if(window.touchContext.touchStart)setTimeout(() => {
                checkLinkTransition(menu_link);
            }, 200);
        }

    }
}

export {
    Mobilemenu,
    Mobilemenu_kirpichM5
}