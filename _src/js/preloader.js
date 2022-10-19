import '../sass/preloader.sass';

window.addEventListener("load", function (event) {
    let preloaderStatus = document.querySelector('#preloader-status');
    if (!preloaderStatus) {
        return;
    }

    // Сначала убираем анимацию посередине прелоадера
    document.querySelector('#preloader-status').classList.add('hide');

    setTimeout(function () {
        let preloader = document.querySelector('#preloader');

        // Затем убираем фон у анимации
        preloader.classList.add('hide');
        // И добавляем для body скроллбар, если он нужен
        document.querySelector('body').classList.remove('have-preloader');

        // Убираем z-index у прелоадера
        setTimeout(function () {
            preloader.classList.add('disable-zindex');
        }, 350);
    }, 350);
});
