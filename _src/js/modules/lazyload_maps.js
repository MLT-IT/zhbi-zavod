export default function mapsLazyload() {
    const observerParams = {
        rootMargin: '0px 0px 25% 0px'
    }

    const observerCallback = (entries, observer) => {
        entries.forEach((entry) => {
            if (entry.isIntersecting) {
                const mapScript = document.querySelector('[data-map-id="' + entry.target.getAttribute('data-map-script') + '"]')
                mapScript.setAttribute('src', mapScript.getAttribute('data-src'))
                observer.unobserve(entry.target)
            }
        })
    }

    const pageUpBtnObserver = new IntersectionObserver(observerCallback, observerParams)

    document.querySelectorAll('[data-map-script]').forEach((mapContainer) => {
        pageUpBtnObserver.observe(mapContainer)
    })
}
