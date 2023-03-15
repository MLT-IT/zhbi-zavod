export default class Tabs {
    tabsSections = document.querySelectorAll("[data-tabs]")

    constructor() {
        if (this.tabsSections.length) this.#init();
    }
    #init() {
        this.tabsSections.forEach((section) => {
            const event = section.hasAttribute('data-tabs-hover') ? 'mouseenter' : 'click';
            const tabs = section.querySelectorAll('[data-tab]');
            const views = section.querySelectorAll('[data-tab-page]');
            tabs.forEach((tab) => {
                const tabValue = tab.dataset.tab;
                if (!tabValue) return;

                tab.addEventListener(event, (e) => {
                    e.preventDefault();

                    tabs.forEach((item) => {
                        if (item.dataset.tab !== tabValue) {
                            item.classList.remove('active');
                        } else {
                            item.classList.add('active')
                        }
                    })

                    views.forEach((item) => {
                        if (item.dataset.tabPage !== tabValue) {
                            item.classList.remove("active")
                        } else {
                            item.classList.add('active')
                        }
                    })
                })
            })
        })
    }
}