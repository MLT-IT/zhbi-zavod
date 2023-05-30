export default class Tabs {
    tabsSections = document.querySelectorAll("[data-tabs]");

    constructor() {
        if (this.tabsSections.length) {
            this.#init();
        }
    }

    #init() {
        this.tabsSections.forEach((section) => {
            const event = section.hasAttribute('data-tabs-hover') ? 'mouseenter' : 'click';
            const tabs = section.querySelectorAll('[data-tab]');
            const views = section.querySelectorAll('[data-tab-page]');
            const hiddable = section.dataset.tabsHiddable;

            tabs.forEach((tab) => {
                const tabValue = tab.dataset.tab;

                if (!tabValue) {
                    return;
                }

                tab.addEventListener(event, (e) => {
                    e.preventDefault();
                    tabs.forEach((item) => {
                        if (item.dataset.tab !== tabValue) {
                            item.classList.remove('active');
                        } else {
                            if (hiddable && window.innerWidth <= hiddable && item.classList.contains('active')) {
                                item.classList.remove('active');
                            } else {
                                item.classList.add('active');
                            }
                        }
                    });

                    views.forEach((item) => {
                        if (item.dataset.tabPage !== tabValue) {
                            item.classList.remove("active");
                        } else {
                            if (hiddable && window.innerWidth <= hiddable && item.classList.contains('active')) {
                                item.classList.remove('active');
                            } else {
                                item.classList.add('active');
                            }
                        }
                    });

                    $("html, body").animate({
                        scrollTop: $('.infoblocks__content').offset().top - 30
                    }, 400);
                });
            });
        });
    }
}
