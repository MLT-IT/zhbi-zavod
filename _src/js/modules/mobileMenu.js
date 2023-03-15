/**
 * @param {querySelector} burger - burger selector
 * @param {querySelector} menu - menu selector
 */
export default function initMobilemenu(burgerClass, menuClass) {
    const burger = document.querySelector(burgerClass);
    const menu = document.querySelector(menuClass);

    if (!burger || !menu) return


    burger.addEventListener("click", toggleBurger)

    function toggleBurger(e) {
        e.preventDefault();

        burger.classList.toggle("active");
        menu.classList.toggle("active");
        document.body.classList.toggle("mobilemenu-opened");
    }
}