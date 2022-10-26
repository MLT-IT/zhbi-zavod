import '../sass/preloader.sass';

window.addEventListener("load", function (event) {
    // Прелоадер
    let preloader = document.querySelector('#preloader');

    // Если прелоадера нет, то выходим из функции
    if (!preloader) {
        return;
    }

    // Картинка-анимация в прелоадере
    let preloaderStatus = document.querySelector('#preloader-status');

    // Страница загрузилась - скрываем прелоадер (сделано через transition)
    preloader.classList.add('hide');

    // Ждем немного (сначала исчезнет картинка прелоадера)
    setTimeout(function () {
        // Открываем для body скроллбар
        document.querySelector('body').classList.remove('have-preloader');

        // Езе ждем немного и убираем z-index у прелоадера
        setTimeout(function () {
            preloader.classList.add('disable-zindex');
        }, 350);
    }, 350);
});
