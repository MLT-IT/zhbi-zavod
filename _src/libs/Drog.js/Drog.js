// TODO: На телефонах можно чуть-чуть по расстоянию свайпнуть. Но очень быстро. И шторка закроется. В данном же плагине такое сделать нельзя. Хорошо бы доделать плагин.

/**
 * Плагин сделан на основе Drog.js v1.2.1. Ссылка:
 * https://github.com/erovas/Drog.js
 */
(function (window, document) {
    // Проверка на повторную инициализацию
    if (window.Drog) {
        return console.error('Drog.js has already been defined');
    }

    // Основные переменные
    let Xi = '-Xi', // Xi - предыдущая позиция курсора по x
        Yi = '-Yi', // Yi - предыдущая позиция курсора по y
        Xf = '-Xf', // Xf - текущая позиция курсора по X
        Yf = '-Yf', // Yf - текущая позиция курсора по y
        Xt = '-x',  // Xt - новая позиция элемента по x
        Yt = '-y',  // Yt - новая позиция элемента по y
        mousedown = 'mousedown', touchstart = 'touchstart',
        mousemove = 'mousemove', touchmove = 'touchmove',
        mouseup = 'mouseup', touchend = 'touchend',
        father = '-f', passive = {passive: false},
        isDrog = '-d', elmnt, that,
        optionsDefault = {
            swapMinX: false,
            swapMaxX: false,
            swapMinY: false,
            swapMaxY: false,
        };

    // Инициализация
    window.Drog = {
        on: on,
        off: off,
        move: move
    };


    // -------------------------------------
    // Определение функций
    // -------------------------------------
    /**
     * Функция-помощник для добавления события.
     * @param element
     * @param event
     * @param callback
     * @param opt
     */
    function addEvent(element, event, callback, opt) {
        element.addEventListener(event, callback, opt || false);
    }


    /**
     * Функция-помощник для удаления события.
     * @param element
     * @param event
     * @param callback
     * @param opt
     */
    function removeEvent(element, event, callback, opt) {
        element.removeEventListener(event, callback, opt || false);
    }


    /**
     * Применить плагин к элементу.
     * @param element
     * @param options
     */
    function on(element, options) {
        if (element[isDrog]) {
            return;
        }

        // Объединение опций с опциями по умолчанию в 1 объект
        options = extend(optionsDefault, options);

        // Установка опций для элемента
        for (let opt in options) {
            element[opt] = options[opt];
        }

        let target = element;
        if (typeof options.elem !== 'undefined') {
            target = options.elem;
        }

        // Save reference original element into target
        target[father] = element;

        // Save element position
        element[Xt] = 0;
        element[Yt] = 0;

        element.style.zIndex = 10;
        target.style.touchAction = "none";

        // signing element
        element[isDrog] = true;

        addEvent(target, mousedown, drogInit);
        addEvent(target, touchstart, drogInit, passive);
    }


    /**
     * Отменить плагин у элемента.
     * @param element
     */
    function off(element) {
        if (!element[isDrog]) {
            return;
        }

        let target = element;
        if (typeof options.elem !== 'undefined') {
            target = options.elem;
        }

        element.style.zIndex = '';
        element.style.transform = '';
        target.style.touchAction = '';

        // deleting references
        target[father] = null;

        // unsigning element
        element[isDrog] = null;

        removeEvent(target, mousedown, drogInit);
        removeEvent(target, touchstart, drogInit);
    }


    /**
     * Мгновенное перемещение элемента к определенной позиции. Либо сброс позиции.
     * @param element
     * @param x
     * @param y
     */
    function move(element, x, y) {
        if (!element[isDrog]) {
            return;
        }

        x = parseFloat(x) || 0;
        y = parseFloat(y) || 0;

        element[Xt] = x;
        element[Yt] = y;
        element.style.transform = 'translate(' + x + 'px,' + y + 'px)';
    }


    /**
     * Обработчик начала движения (вешается на зажатие ЛКМ или тапа на элементе)
     * @param e
     */
    function drogInit(e) {
        // Если это ПКМ (3) или колесо (2) то выходим из функции
        if (e.which === 2 || e.which === 3) {
            return;
        }

        that = this;
        elmnt = that[father];

        // get the mouse cursor position at startup:
        elmnt[Xi] = e.clientX || e.targetTouches[0].clientX;
        elmnt[Yi] = e.clientY || e.targetTouches[0].clientY;

        // call a function whenever the cursor moves:
        if (e.type === touchstart) {
            addEvent(that, touchmove, drogMove, passive);
            addEvent(that, touchend, drogEnd, passive);
        } else {
            addEvent(document, mousemove, drogMove);
            addEvent(document, mouseup, drogEnd);
        }
    }


    /**
     * Обработчик процесса движения (вешается на движение при зажатой мышью / тапе)
     * @param e
     */
    function drogMove(e) {
        // На мобилках не надо, т.к. не будет работать скроллинг панели с фильтрами. На компах надо, т.к. в противном случае будет срабатывать выделение или перетаскивание (если зажали по тегу a)
        if (e.type === mousemove) {
            e.preventDefault();
        }

        if (e.type === touchmove) {
            elmnt = this[father];
        }

        elmnt[Xf] = e.clientX || e.targetTouches[0].clientX;
        elmnt[Yf] = e.clientY || e.targetTouches[0].clientY;

        // Xt - разница между предыдущей позицией (Xi) и текущей позицией (Xf) курсора по x (новая позиция элемента по x)
        // Yt - разница между предыдущей позицией (Yi) и текущей позицией (Yf) курсора по y (новая позиция элемента по y)
        elmnt[Xt] -= elmnt[Xi] - elmnt[Xf];
        elmnt[Yt] -= elmnt[Yi] - elmnt[Yf];

        // Валидация Xt
        if (elmnt.swapMinX !== false && elmnt[Xt] < elmnt.swapMinX) {
            elmnt[Xt] = elmnt.swapMinX;
        }
        if (elmnt.swapMaxX !== false && elmnt[Xt] > elmnt.swapMaxX) {
            elmnt[Xt] = elmnt.swapMaxX;
        }
        // Валидация Yt
        if (elmnt.swapMinY !== false && elmnt[Yt] < elmnt.swapMinY) {
            elmnt[Yt] = elmnt.swapMinY;
        }
        if (elmnt.swapMaxY !== false && elmnt[Yt] > elmnt.swapMaxY) {
            elmnt[Yt] = elmnt.swapMaxY;
        }

        elmnt[Xi] = elmnt[Xf];
        elmnt[Yi] = elmnt[Yf];

        elmnt.style.transform = 'translate(' + elmnt[Xt] + 'px,' + elmnt[Yt] + 'px)';
    }


    /**
     * Обработчик конца процесса движения (вешается на конец движения при зажатой мышью / тапе)
     */
    function drogEnd() {
        that = this;

        removeEvent(document, mousemove, drogMove);
        removeEvent(document, mouseup, drogEnd);

        removeEvent(that, touchmove, drogMove, passive);
        removeEvent(that, touchend, drogEnd, passive);

        let event = document.createEvent('HTMLEvents');
        event.initEvent('drogEnd', true, false);
        elmnt.dispatchEvent(event);
    }


    /**
     * Объединение массивов
     * @param out
     * @returns {{}}
     */
    function extend(out) {
        out = out || {};

        for (let i = 1; i < arguments.length; i++) {
            if (!arguments[i]) {
                continue;
            }

            for (let key in arguments[i]) {
                if (arguments[i].hasOwnProperty(key)) {
                    out[key] = arguments[i][key];
                }
            }
        }

        return out;
    }

})(window, document);
