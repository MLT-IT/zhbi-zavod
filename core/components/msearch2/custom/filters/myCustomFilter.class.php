<?php
/*
Чуток изменил сортировку.
Проблема в начальной сортировке чисел с плавающей точкой. (строка 46)
По логике данного скрипта сначала идет сортировка по числу.
Но проблема в том что числа попадаются в тех опциях по которым мы хотим произвести дальнейшую сортирку ($options['name'] === 'tip') и тд.
Пример: https://pro-minvata.ru/catalog/ в фильтре "продуктовая линейка" появилась опция "35 250 Стандарт" которая выявила проблему.
И вот туда в if ($options['name'] === 'tip') подпадает уже МАССИВ С ДАННЫМИ отфильтроваными по числу.
Что ломает результат фильтра.
Пожтому внес правки (строки 21,24,36)

Второй вариант решения в условие с сортировкой по числу не пускать $options['name'] === 'produktovaya-lineyka' и $options['name'] === 'tip'.
Но тогда если в этих опциях попадутся поля с точкой они не будут правильно сортироваться.
*/

class myCustomFilter extends mse2FiltersHandler {

    /**
     * Функция позволяет отсортировать массив элементов $unsortedElems в порядке значений, находящихся в массиве $orderValues.
     *
     * Зачем сюда передавать элементы $sortedElems, если передаются элементы $unsortedElems? И наоборот?
     * Затем, что в $sortedElems могут быть не все элементы. Но они отсортированы по определенному алгоритму. А в $unsortedElems точно все, но они не отсортированы вообще. В конце функции все это объединяется, чтобы ни один элемент не потерялся.
     *
     * @param $sortedElems - уже отсортированные по какому-либо алгоритму элементы.
     * @param $unsortedElems - еще неотсортированные элементы.
     * @param $orderValues - массив с ключами - в каком порядке сортировать элементы $unsortedElems.
     * @return array - массив с отсортированными элементами.
     */
    private function sortByCustomOrder($sortedElems, $unsortedElems, $orderValues) {
        // Сортируем элементы $unsortedElems в порядке $orderValues
        $resultElems = [];
        foreach ($orderValues as $key) {
            if (!empty($unsortedElems[$key])) {
                $resultElems[$key] = $unsortedElems[$key];
            }
        }

        // Добавляем остальные элементы, на всякий случай - вдруг программист при вызове этой функции в $orderValues передал не все ключи
        $diff = array_diff(array_keys($unsortedElems), array_keys($sortedElems));
        foreach ($diff as $key) {
            if (!empty($unsortedElems[$key])) {
                $sortedElems[$key] = $unsortedElems[$key];
            }
        }

        // Объединяем
        $sortedElems = $resultElems + $sortedElems;

        return $sortedElems;
    }

    public function sortFilters(array $results, $type = 'default', $options = []) {
        $sorted = [];

        if ($type == 'options') {
            // -------------------------------------------------------
            // Сортировка float значений по возрастанию (из-за точки они сортируются неправильно)
            // -------------------------------------------------------
            if (!empty($options) && !empty($options['name'])) {
                // Если есть хоть одно значение типа float
                $hasFloat = false;

                foreach ($results as $val) {
                    if (!$hasFloat && floatval($val['value']) > 0) {
                        $hasFloat = true;
                        break;
                    }
                }

                if ($hasFloat) {
                    // Новый алгоритм сортировки. Я думаю, что его нужно применить ко всему сайту, а не только к опции "Формат" в кирпичах. Но я переживаю, что что-то отсортируется не так / вообще сломается. Пока что пусть будет только на кирпичах и для опции "Формат"
                    if ($options['name'] === 'format' && $GLOBALS['modx']->resource->context_key === 'kirpich-m') {
                        $floatValsSort = [];
                        foreach ($results as $key => $val) {
                            $fval = floatval($val['value']);
                            if ($fval > 0) {
                                $floatValsSort[$key] = $fval;
                            }
                        }

                        asort($floatValsSort);
                        foreach ($floatValsSort as $key => $val) {
                            $sorted[$key] = $results[$key];
                        }
                        $diff = array_diff(array_keys($results), array_keys($sorted));
                        natcasesort($diff);
                        foreach ($diff as $key) {
                            $sorted[$key] = $results[$key];
                        }
                    } else {
                        $keys = array_keys($results);
                        sort($keys);

                        foreach ($keys as $k) {
                            $sorted[$k] = $results[$k];
                        }
                    }
                }
            }


            if ($GLOBALS['modx']->resource->context_key == 'gazosilikatstroy') {
                if ($options['name'] == 'proizvoditel') {
                    $sorted = $this->sortByCustomOrder($sorted, $results, [
                        'ЛСР',
                        'СК (СтройКомплект)',
                        'ЕАБ (ЕвроАэроБетон)',
                        'Белорусский SLS',
                        'Могилевский Газосиликат',
                        'AEROC',
                        'Могилевский КСИ',
                        'Белорусский БЦК',
                        'Н+Н',
                        'Bonolit',
                        'Забудова',
                        'YTONG',
                    ]);
                }

                if ($options['name'] == 'item_thickness') {
                    arsort($sorted);
                }
            }


            if ($GLOBALS['modx']->resource->context_key == 'web') {
                if ($options['name'] == 'proizvoditel') {
                    $sorted = $this->sortByCustomOrder($sorted, $results, ['Rockwool', 'Технониколь', 'Penoplex', 'Knauf', 'Paroc', 'Ursa', 'Isover', 'Isoroc']);
                }

                if ($options['name'] == 'produktovaya-lineyka') {
                    $sorted = $this->sortByCustomOrder($sorted, $results, [
                        // Rockwool
                        'Лайт Баттс',
                        'Скандик Лайт Баттс',
                        'Лайт Баттс Оптима',
                        'Акустик Баттс',
                        'Каркас Баттс',
                        'Фасад Баттс',
                        'Флор Баттс',
                        'Арктик',
                        'Руф Баттс',
                        'Венти Баттс',
                        'Стандарт',
                        'Эконом',
                        'ТЕХ МАТ',
                        'Рокфасад',
                        'Тех Баттс',
                        'Сопутствующие товары',
                        'WIRED MAT',
                        'Цилиндры навивные',
                        'LAMELLA MAT L',
                        'CONLIT',
                        'Кавити Баттс',
                        'Сауна Баттс',
                        'SeaRox',
                        'FT Barrier',
                        'FIRE BATTS',
                        'Камин Баттс',
                        'Пластер Баттс',
                        'Klimafix',
                        'Акустик Стандарт',
                        'Сэндвич Баттс',
                        'ProRox',
                        'INDUSTRIAL BATTS',
                        'Бетон Элемент Баттс',

                        // Технониколь
                        'Carbon',
                        'Роклайт',
                        'Техноруф',
                        'Техноплекс',
                        'LOGICPIR',
                        'Технофас',
                        'Техновент',
                        'Техноблок',
                        'Технолайт',
                        'Изобокс',
                        'Master Звукозащита',
                        'Плиты PIR',
                        'Техно ОЗМ',
                        'Техноакустик',
                        'Штукатурный фасад',
                        'Сэндвич Ц-XPS',
                        'Технофлор',
                        'Полимерные гидроизоляционные мембраны',
                        'Базалит',
                        'Техно ОЗБ',
                        'Техно Т',
                        'GreenGuard',
                        'Техносэндвич',
                        'Техно ОЗД',
                        'Цилиндр Техно',
                        'Мат Техно',
                        'Теплоролл',

                        // Penoplex
                        'Фундамент',
                        'Комфорт',
                        'Основа',
                        'Гео',
                        '45',
                        'Стена',
                        'Уклон',
                        'Экстрим',
                        'Кровля',
                        'Сегменты',
                        'Фасад',

                        // Knauf
                        'АкустиКНАУФ',
                        'Инсулейшн',
                        'Терм',
                        'ТеплоКНАУФ',
                        'GreenTERM',

                        // Paroc
                        // Фильтр "Продуктовая линейка" полностью отличаются от тегов

                        // Ursa
                        'Geo',
                        'Pureone',
                        'XPS',
                        'Terra',

                        // Isover
                        // Очень много разных элементов, пока пропустил. Лучше поставить задачу написать фильтры в нужном порядке кому-нибудь другому. А я потом внесу это в код.

                        // Isoroc
                        // Нет фильтра по продуктовым линейкам
                    ]);
                }
            }

        }

        if (!empty($sorted)) {
            return $sorted;
        }

        return parent::sortFilters($results, $type, $options);
    }


    /*
    public function sortFilters(array $results, $type = 'default', $options = array()) {
        $sorted = array();
        switch ($type) {
            case 'boolean':
                ksort($results);
                $sorted = $results;
                break;
            case 'parents':
                ksort($results);
                foreach ($results as $v) {
                    foreach ($v as $k2 => $v2) {
                        $sorted[$k2] = $v2;
                    }
                }
                break;
            case 'date':
                if ($options['sort'] == 'asc') {
                    ksort($results);
                }
                else {
                    krsort($results);
                }
                $sorted = $results;
                break;
            default:
                $keys = array_keys($results);
                sort($keys);

                $sorted = array();
                foreach ($keys as $k) {
                    $sorted[$k] = $results[$k];
                }
        }

        return $sorted;
    }
    */
}
