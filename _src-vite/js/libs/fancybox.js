import "@fancyapps/fancybox"

export function initFancybox() {
    $('[data-fancybox]').fancybox({
        touch: false,
    })
}