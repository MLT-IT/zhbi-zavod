class actionOnResize {
    __instance = undefined;
    targets = {};

    constructor() {
        if (actionOnResize.__instance) {
            return actionOnResize.__instance;
        }

        actionOnResize.__instance = this;
        window.addEventListener('resize', this.#resizeHandler.bind(this))
    }

    /**
     * Добавляет элемент в слушатель события resize страницы
     * @async
     * @param {String | Number} key - любой ключ
     * @param {() => void} callback - функция, обработчик
     * @returns {void}
     */
    addTarget(key, callback = () => {}) {
        if (typeof key !== "string" && typeof key !== 'number') {
            throw new TypeError('key должен иметь тип string или number')
        }
        if (!this.targets[key]) {
            this.targets[key] = {
                callback
            };
        } else {
            throw Error('Слушатель с таким ключом уже зарегистрирован. Используй removeTarget(key)')
        }
    }

    /**
     * Удаляет элемент из слушателя события resize страницы
     * @async
     * @param {String | Number} key - ключ, по которому элемент был зарегистрирован
     * @returns {void}
     */
    removeTarget(key) {
        if (!this.targets[key]) {
            console.error('Слушателя с таким ключом не существует')
        } else {
            delete this.targets[key]
        }
    }

    #resizeHandler(e) {
        Object.keys(this.targets).forEach((target) => {
            this.targets[target].callback(e);
        })
    }
}

export default new actionOnResize()