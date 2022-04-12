/*
 * jQuery плагин для фильтрация ввода.
 * Взял отсюда и немного улучшил:
 * https://stackoverflow.com/questions/995183/how-to-allow-only-numeric-0-9-in-html-inputbox-using-jquery
 */
let methods = {
    // Отмена плагина
    destroy: function () {
        return this.each(function () {
            let $this = $(this);

            // Убираем обработчики
            $this.off($this.data(pluginName).events);

            // Удаляем data-значения
            $this.removeData(pluginName);
        });
    },

    // Инициализация
    init: function (func, settings) {
        return this.each(function () {
            settings = $.extend({
                event: 'change'
            }, settings);

            let $this = $(this);

            // -----------------------------------------
            // Установка переменных и data-значений
            // -----------------------------------------
            let events
            switch (settings.event) {
                case 'change':
                    events = 'change select contextmenu drop refreshInput';
                    break;
                case 'input':
                    events = 'change input keydown keyup mousedown mouseup select contextmenu drop refreshInput';
                    break;
            }

            let events_array = events.split(' ')
            for (let i = 0; i < events_array.length; i++) {
                events_array[i] += '.' + pluginName;
            }
            events = events_array.join(' ');

            $this.data(pluginName, {});
            $this.data(pluginName).init = true;
            $this.data(pluginName).events = events;

            // -----------------------------------------
            // Функционал плагина
            // -----------------------------------------
            $this[0]["oldValue-" + settings.event] = $this[0].value;
            $this[0].oldSelectionStart = $this[0].selectionStart;
            $this[0].oldSelectionEnd = $this[0].selectionEnd;
            $this[0]["lastValue"] = $this[0].value;

            $this.on(events, function (e) {
                if (func(this.value)) {
                    if (settings.event === 'change' && e.type === 'change') {
                        this["lastValue"] = this["oldValue-" + settings.event];
                    }
                    this["oldValue-" + settings.event] = this.value;
                    this.oldSelectionStart = this.selectionStart;
                    this.oldSelectionEnd = this.selectionEnd;
                } else if (this.hasOwnProperty("oldValue-" + settings.event)) {
                    this.value = this["oldValue-" + settings.event];
                    this.setSelectionRange(this.oldSelectionStart, this.oldSelectionEnd);
                    this["lastValue"] = this["oldValue-" + settings.event];
                }
            });
        });
    }
}

// Логика вызова функций
let pluginName = 'inputFilter';

$.fn.inputFilter = function (method) {
    if (methods[method]) {
        // ----------------------------------
        // Проверка на вызов функции у неициниализированного элемента
        // ----------------------------------
        this.each(function () {
            let $this = $(this);
            if (!$this.data(pluginName) || $this.data(pluginName).init !== true) {
                $.error('Не удалось произвести действие, поскольку для одного из элементов в выборке не инициализирован jQuery.' + pluginName + '.');
            }
        });

        return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
    } else if (typeof method === 'function') {
        // ----------------------------------
        // Проверка на повторную инициализацию
        // ----------------------------------
        /*
        this.each(function () {
            let $this = $(this);
            if ($this.data(pluginName) && $this.data(pluginName).init === true) {
                $this[pluginName]('destroy');
            }
        });
        */

        return methods.init.apply(this, arguments);
    } else {
        $.error('Функция с именем ' + method + ' не существует для jQuery.' + pluginName + '.');
    }
}
