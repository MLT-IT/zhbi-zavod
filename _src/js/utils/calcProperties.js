import actionOnResize from "./actionOnResize";

export default function calcAppProperties() {

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
    const doc = document.documentElement,
        header = document.querySelector('header');

    doc.style.setProperty('--header-height', `${header.offsetHeight}px`);
}