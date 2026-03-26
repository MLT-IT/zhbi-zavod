/**
 Описание работы скрипта.

 Внизу страницы пишутся теги script с Яндекс картами.
 Чтобы карты не грузились сразу, вместо src указывается data-src.

 На странице пишутся теги div, куда будут помещены карты из тегов script. Чтобы скрипт понял, какая карта в каком div должна быть, есть атрибуты data-map-script (у div) и data-map-id (у script). Их значения должны быть одинаковыми. Перемещение script в div происходит за счет скрипта Яндекс карт. А этот скрипт отвечает за то, чтобы при просмотре страницы была проверка, видно ли тег div, где должна быть карта. Если да, то у соответствующего тега script происходит замена data-src на src.

 Можно вместо тега script использовать тег iframe. Вот только iframe не будет перемещаться в соотвутствующий div, поэтому его заранее нужно поместить туда.
 */

export default function mapsLazyload() {
    const observerParams = {
        rootMargin: '0px 0px 25% 0px'
    }

    const observerCallback = (entries, observer) => {
        entries.forEach((entry) => {
            if (entry.isIntersecting) {
                const mapScript = document.querySelector('[data-map-id="' + entry.target.getAttribute('data-map-script') + '"]')
                if(mapScript){
                    mapScript.setAttribute('src', mapScript.getAttribute('data-src'))
                }
                observer.unobserve(entry.target)
            }
        })
    }

    const pageUpBtnObserver = new IntersectionObserver(observerCallback, observerParams)

    document.querySelectorAll('[data-map-script]').forEach((mapContainer) => {
        pageUpBtnObserver.observe(mapContainer)
    })
}
