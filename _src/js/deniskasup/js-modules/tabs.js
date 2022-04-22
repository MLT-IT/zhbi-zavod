export default function initTabs() {
    const allTabs = document.querySelectorAll('[data-tabs]');
    // const tabsSelects = document.querySelectorAll('[data-select-tabs]');
    if (allTabs || tabsSelects) {
        allTabs.forEach((tabs) => {
            const arr = Array.from(tabs.children)
            const tabPages = document.querySelectorAll(`.${tabs.getAttribute('data-tabs')} > *`);
            arr.forEach((elem) => {
                elem.addEventListener('click', () => {
                    // remove кнопки
                    arr.forEach(e => e.classList.remove('active'));

                    // remove Вкладки
                    tabPages.forEach(item => item.classList.remove('active'));

                    // add Кнопка
                    elem.classList.add('active');
                    // add вкладка
                    tabPages[elem.getAttribute('data-tab-page')].classList.add('active');
                });
            });
        });
        // tabsSelects.forEach((select) => {
        //     const tabPages = document.querySelectorAll(`.${select.getAttribute('data-select-tabs')} > *`);
        //     select.addEventListener('change', () => {
        //         // remove Вкладки
        //         tabPages.forEach(item => item.classList.remove('active'));
        //         // add вкладка
        //         tabPages[select.options[select.selectedIndex].getAttribute('data-tab-page')].classList.add('active');
        //     })
        // })
    }
}