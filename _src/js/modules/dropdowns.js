export default class Dropdowns {

    // TODO: я заметил в скрипте баг. Если сделать console.log и щелкнуть по data-dropdown, то вывод будет столько раз, сколько data-dropdown на странице. А должен быть всего 1 раз. Это баг верстальщика.

    /**
     * item - обертка споилера с title и content, при клике добаляется класс active.
     * title - то место, куда надо кликнуть, чтобы тело споилера открылось, при клике добаляется класс active.
     * content - тело споилера, при клике устанавливается height.
     */

    dropdowns = document.querySelectorAll('[data-dropdown]')

    constructor() {
        this.#init()
    }

    #init() {
        this.dropdowns.forEach(item => {
            let [title, content] = item.children

            if (item.dataset.dropdownTitle) {
                title = item.querySelector(item.dataset.dropdownTitle)
            }

            if (item.dataset.dropdownBody) {
                content = item.querySelector(item.dataset.dropdownBody)
            } else if (item.dataset.dropdownBodyDoc) {
                content = document.querySelector(item.dataset.dropdownBodyDoc)
                title = item
            }

            if (!content || !title) {
                return
            }

            title.addEventListener('click', (e) => {
                e.stopPropagation()
                e.preventDefault()
                this.#toggle(item, content, title)
            })

            if (!item.hasAttribute('data-disable-close')) {
                document.body.addEventListener('click', (e) => {
                    if (e.target === item || item.contains(e.target)) {
                        return
                    }

                    this.#close(item, content, title)
                })
            }
        })
    }

    #close(item, content, title) {
        item.classList.remove("active")
        title.classList.remove('active')
        if (item.dataset.dropdown === 'responsive') {
            content.style.height = '0px'
        }
    }

    #toggle(item, content, title) {
        if (item.classList.contains("active") || item.dataset.dropdownOnlyClose) {
            item.classList.remove("active")
            title.classList.remove('active')

            if (item.dataset.dropdownOnlyClose) {
                content.classList.remove('active')
            }

            if (item.dataset.dropdown === 'responsive') {
                content.style.height = '0px'
            }
        } else {
            item.classList.add("active")
            title.classList.add('active')
            if (item.dataset.dropdown === 'responsive') {
                content.style.height = `${content.scrollHeight}px`
            }
        }

        const event = new CustomEvent('dropdowns-toggle')
        item.dispatchEvent(event)
    }
}
