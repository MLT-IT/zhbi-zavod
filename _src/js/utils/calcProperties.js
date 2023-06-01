import actionOnResize from "./actionOnResize";

export default {
    calcAppProperties,
    calcHeaderHeight
};

function calcAppProperties() {
    calcProperties();

    actionOnResize.addTarget('appProperties', calcProperties);

    function calcProperties() {
        calcAppHeight();
        calcHeaderHeight();
    }
}

function calcAppHeight() {
    const doc = document.documentElement;

    doc.style.setProperty('--app-height', `${window.innerHeight}px`);
}

function calcHeaderHeight() {
    const doc = document.documentElement;
    let offset;

    if ($('.header-fixed').length) {
        offset = document.querySelector('.header__bottom').offsetHeight;
    } else {
        offset = document.querySelector('header').offsetHeight;
    }

    doc.style.setProperty('--header-height', `${offset}px`);
}
