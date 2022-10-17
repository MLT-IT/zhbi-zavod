import '../sass/preloader.sass';

window.addEventListener("load", function (event) {
    // Сначала убираем анимацию посередине прелоадера
    document.querySelector('#preloader-status').classList.add('hide');

    setTimeout(function() {
        // Затем убираем фон у анимации
        document.querySelector('#preloader').classList.add('hide');
        // И добавляем для body скроллбар, если он нужен
        document.querySelector('body').classList.remove('have-preloader');
    }, 350);
});
