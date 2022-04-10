/*
 * euv_custom_select
 * https://github.com/ulin-evgeny/
 * Плагин для вызова кроссбраузерного стилизованного списка. За счет своей простоты плагин можно легко подстроить под свои нужды.
 */

(function ($) {
    // ===================================
    // Приватные функции
    // ===================================
    // -----------------------
    // Получение data-атрибутов
    // -----------------------
    function get_data_attributes(node) {
        let d = {},
            regex_data_attr = /^data\-(.+)$/;

        $.each(node.get(0).attributes, function (index, attr) {
            if (regex_data_attr.test(attr.nodeName)) {
                let key = attr.nodeName.match(regex_data_attr)[1];
                d[key] = attr.nodeValue;
            }
        });

        return d;
    }

    // -----------------------
    // Обработчик клика по документу - чтобы скрывать список с опциями
    // -----------------------
    function close_select(e) {
        let $target = $(e.target);
        let $target_select = $target.closest('.' + custom_select_class);

        $('.' + custom_select_visible_class).each(function () {
            let $this = $(this);
            // Важно, чтобы клик был не по списку, т.к. тогда список с опциями нельзя будет увидеть - он появляется и в этом коде сразу же закрывается. Но в то же время если кликнуть по опции данного списка, то список должен закрываться.
            if ($this[0] != $target_select[0] || $target.hasClass(custom_select_option_class)) {

                if ($('.' + custom_select_visible_class).length < 2) {
                    $(document).off('click.' + plugin_name, close_select);
                }

                $this.removeClass(custom_select_visible_class);
            }
        });
    }

    // ===================================
    // Публичные функции
    // ===================================
    let methods = {
        // -----------------------
        // Отмена плагина
        // -----------------------
        destroy: function () {
            return this.each(function () {
                let $this = $(this);

                // Убираем обработчик с документа
                $(document).off('click.' + plugin_name);

                // Убираем обработчик с элемента
                $this.off('click.' + plugin_name);

                // Убираем ненужный класс
                $this.removeClass('euv-custom-select__original-select');

                // Удаляем data-значения
                $this.removeData(plugin_name);

                // Удаляем созданные плагином элементы
                let $custom_select = $this.closest('.' + custom_select_class);
                $custom_select.find('.' + custom_select_input_class).remove();
                $custom_select.find('.euv-custom-select__options-wrap').remove();
                $custom_select.find('.euv-custom-select__btn').remove();

                // Удаляем ненужную обертку
                $this.unwrap();
            });
        },

        // -----------------------
        // Инициализация
        // -----------------------
        init: function (settings) {
            return this.each(function () {
                let $this = $(this);
                // -----------------------------------------------
                // Проверка на тег
                // -----------------------------------------------
                if (!$this.is('select')) {
                    $.error('jQuery.' + plugin_name + ' можно применить только к тегам select.');
                }

                // -----------------------------------------------
                // Установка переменных и data-значений
                // -----------------------------------------------
                let label = $this.attr('data-label');
                if (typeof label === 'undefined') {
                    label = '';
                }

                let disabled = ($this.is(':disabled'));

                settings = $.extend({
                    render_option: function (text) {
                        return ('<div>' + text + '</div>');
                    },
                    with_input: false
                }, settings);

                $this.data(plugin_name, {});
                $this.data(plugin_name).init = true;
                $this.data(plugin_name).settings = settings;

                // -----------------------------------------------
                // Создание input'а или div'а (в зависимости от настроек) и кнопки
                // -----------------------------------------------
                // Сам input или div
                $this.wrap('<div class="' + custom_select_class + '"></div>');
                let $custom_select = $this.parent();
                let $custom_select_input;
                let $custom_select_label;
                let selected_option_html = $this.find('option:selected').html();
                if (!settings.with_input) {
                    $custom_select_input = $('<div class="' + custom_select_input_class + '"><span class="' + custom_select_input_value_class + '"></span></div>');
                    $custom_select_input.find('.' + custom_select_input_value_class).html(selected_option_html);
                    if (label !== '') {
                        $custom_select_label = $('<span class="' + custom_select_label_class + '">' + label + '</span>');
                        $custom_select_input.prepend($custom_select_label);
                    }
                } else {
                    $custom_select_input = $('<input class="' + custom_select_input_class + '">');
                    $custom_select_input.val(selected_option_html);
                }

                if (disabled) {
                    $custom_select.addClass('disabled')
                }

                $custom_select.append($custom_select_input);

                // Кнопка
                let $custom_select_btn = $('<a href="#" class="euv-custom-select__btn"></a>');
                $custom_select_btn.on('click.' + plugin_name, function (e) {
                    e.preventDefault();
                })
                $custom_select.append($custom_select_btn);

                // -----------------------------------------------
                // Копируем data-атрибуты и классы
                // -----------------------------------------------
                let classes = $this.attr('class');
                if (classes !== undefined && classes.length) {
                    $custom_select.attr('class', $custom_select.attr('class') + ' ' + classes);
                }
                let data_attrs = get_data_attributes($this);
                for (let key in data_attrs) {
                    $custom_select.attr('data-' + key, data_attrs[key]);
                }

                $this.addClass('euv-custom-select__original-select');

                // -----------------------------------------------
                // Вешаем на кнопку обработчик
                // -----------------------------------------------
                if (!disabled) {
                    // Если выбранное значение просто отображается в виде текста, а не является полем для ввода, то обработчик будет вешаться еще и на него
                    if (!settings.with_input) {
                        $custom_select_btn = $custom_select_btn.add($custom_select_input);
                    }

                    $custom_select_btn.on('click.' + plugin_name, function () {
                        $custom_select.toggleClass(custom_select_visible_class);
                        if ($custom_select.hasClass(custom_select_visible_class)) {
                            $(document).off('click.' + plugin_name, close_select);
                            $(document).on('click.' + plugin_name, close_select);
                        } else {
                            $(document).off('click.' + plugin_name, close_select);
                        }
                    });
                }

                // -----------------------------------------------
                // Создаем wrap для опций
                // -----------------------------------------------
                let $custom_select_options_wrap = $('<div class="euv-custom-select__options-wrap"></div>');
                $custom_select.append($custom_select_options_wrap);

                // -----------------------------------------------
                // Для каждой существующей опции создаем кастомную опцию, вешаем на нее обработчик и добавляем ее во wrap для опций
                // -----------------------------------------------
                $this.find('option').each(function () {
                    // -----------------------
                    // Создаем
                    // -----------------------
                    let $option = $(this);

                    let $custom_option = $(settings.render_option($option.html()));
                    $custom_option.addClass(custom_select_option_class);
                    $custom_option.attr('data-' + plugin_name + '_value', $option.val());

                    if ($option.val() == $this.val()) {
                        $custom_option.addClass(custom_select_selected_option_class)
                    }

                    $custom_option.html($option.html());
                    $custom_select_options_wrap.append($custom_option);

                    // -----------------------
                    // Копируем data-атрибуты и классы
                    // -----------------------
                    let classes = $option.attr('class');
                    if (classes !== undefined && classes.length) {
                        $custom_option.attr('class', $custom_option.attr('class') + ' ' + classes);
                    }
                    let data_attrs = get_data_attributes($option);
                    for (let key in data_attrs) {
                        if (key !== plugin_name + '_value') {
                            $custom_option.attr('data-' + key, data_attrs[key]);
                        }
                    }

                    let disabled = false;
                    if ($option.is(':disabled')) {
                        $custom_option.attr('data-disabled', true);
                        disabled = true;
                    }

                    // -----------------------
                    // Вешаем обработчик на каждую опцию
                    // -----------------------
                    if (!disabled) {
                        $custom_option.on('click.' + plugin_name, function () {
                            let $opt = $(this);

                            // Класс с выбранной опцией. Пригодится для дизайна. Но с точки зрения JS никакого функционала не несет
                            $custom_select.find('.' + custom_select_selected_option_class).removeClass(custom_select_selected_option_class);
                            $opt.addClass(custom_select_selected_option_class);
                            $this.trigger('beforeChange.' + plugin_name);

                            // Значение option
                            $this.val($opt.attr('data-' + plugin_name + '_value'));
                            $this.trigger('change.' + plugin_name);
                        });
                    }

                });

                // -----------------------
                // Вешаем обработчик на сам список
                // -----------------------
                $this.on('change.' + plugin_name, function (e) {
                    if (e.namespace === plugin_name) {
                        let selected_option_html = $this.find('option:selected').html();
                        if (!settings.with_input) {
                            $custom_select_input.find('.' + custom_select_input_value_class).html(selected_option_html);
                        } else {
                            $custom_select_input.val(selected_option_html);
                        }
                        $this.trigger('change');
                    }
                });

                // -----------------------
                // Вызываем событие, что select проинициализировался
                // -----------------------
                $this.trigger(plugin_name + '_init');
            });
        }
    }

    // ===================================
    // Логика вызова функций
    // ===================================
    let plugin_name = 'euv_custom_select';

    // Вынес повторяющиеся классы в переменные, чтобы избежать опечаток
    let custom_select_class = 'euv-custom-select';
    let custom_select_input_class = 'euv-custom-select__input';
    let custom_select_visible_class = 'euv-custom-select_visible';
    let custom_select_selected_option_class = 'euv-custom-select__selected-option';
    let custom_select_option_class = 'euv-custom-select__option';
    let custom_select_label_class = 'euv-custom-select__label';
    let custom_select_input_value_class = 'euv-custom-select__input-value'

    $.fn.euv_custom_select = function (method) {
        if (methods[method]) {
            // -----------------------------------------------
            // Проверка на вызов функции у неициниализированного элемента
            // -----------------------------------------------
            this.each(function () {
                let $this = $(this);
                if (!$this.data(plugin_name) || $this.data(plugin_name).init !== true) {
                    $.error('Не удалось произвести действие, поскольку для одного из элементов в выборке не инициализирован jQuery.' + plugin_name + '.');
                }
            });

            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || !method) {
            // -----------------------------------------------
            // Проверка на повторную инициализацию
            // -----------------------------------------------
            this.each(function () {
                let $this = $(this);
                if ($this.data(plugin_name) && $this.data(plugin_name).init === true) {
                    $this[plugin_name]('destroy');
                }
            });

            return methods.init.apply(this, arguments);
        } else {
            $.error('Функция с именем ' + method + ' не существует для jQuery.' + plugin_name + '.');
        }
    }

})(jQuery);
