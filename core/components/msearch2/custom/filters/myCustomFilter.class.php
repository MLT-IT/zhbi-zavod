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
        $sortedElems = array_merge($resultElems, $sortedElems);
        return $sortedElems;
    }

    public function sortFilters(array $results, $type = 'default', $options = []) {
        $sorted = [];

        if ($type === 'options') {
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

            // -------------------------------------------------------
            // Сортировка опции "Тип" на некоторых ресурсах
            // -------------------------------------------------------
            if ($options['name'] === 'tip') {
                switch ($GLOBALS['modx']->resource->id) {
                    case 37609:
                        $sorted = $this->sortByCustomOrder($sorted, $results, ['Керамический кирпич', 'Клинкерный кирпич', 'Кирпич ручной формовки', 'Печной кирпич']);
                        break;
                    case 19859:
                        $sorted = $this->sortByCustomOrder($sorted, $results, []);
                        break;
                }
            }

            // -------------------------------------------------------
            // Сортировка опции "Продуктовая линейка"
            // -------------------------------------------------------
            if ($options['name'] === 'produktovaya-lineyka') {
                switch ($GLOBALS['modx']->resource->context_key) {
                    case 'rockwool':
                        $sorted = $this->sortByCustomOrder($sorted, $results, ['Лайт Баттс', 'Руф Баттс', 'Фасад Баттс', 'Флор Баттс', 'Венти Баттс', 'Каркас Баттс', 'Эконом', 'Акустик Баттс', 'Кавити Баттс', 'Арктик', 'Рокфасад']);
                        break;
                    case 'tn':
                        //	$sorted = $this->sortByCustomOrder($sorted, $results, ['Роклайт', 'Carbon', 'Теплоролл', '35 250 Стандарт', 'Технофас', 'Технолайт', 'Технофлор', 'Техноруф', 'Техновент', 'Техноблок', 'Изобокс', 'GreenGuard', 'Базалит', 'Техносэндвич', 'Сэндвич Ц-XPS', 'Техноплекс', 'LOGICPIR', 'Плиты PIR', 'Техноакустик', 'Техно ОЗБ', 'Техно ОЗД', 'Техно ОЗМ', 'Техно Т', 'Мат Техно', 'Цилиндр Техно', 'LOGICROOF', 'Штукатурный фасад', 'Master Звукозащита', 'Техноэласт', 'ECOBASE', 'ECOPLAST', 'LOGICBASE', 'LOGICPOOL',  'Sintofoil']);
                        $sorted = $this->sortByCustomOrder($sorted, $results, ['Роклайт', 'Carbon', 'Техноплекс', 'Техноруф', 'Техноблок', 'Техновент', 'LOGICPIR', 'Технолайт', 'Технофлор', 'Техноакустик', 'Технофас', 'Техно ОЗМ']);
                        break;
                    case 'ursa':
                        $sorted = $this->sortByCustomOrder($sorted, $results, ['Terra', 'Geo', 'XPS', 'Pureone', 'Seco']);
                        break;
                    case 'web':
                        $sorted = $this->sortByCustomOrder($sorted, $results, ['Терм', 'ТеплоКНАУФ', 'АкустиКНАУФ', 'Инсулейшн', 'GreenTERM']);
                        break;
                    case 'isover':
                        $sorted = $this->sortByCustomOrder($sorted, $results, ['Теплый Дом', 'Фасад', 'Руф', 'Звукозащита', 'Скатная Кровля', 'Плавающий пол', 'Профи', 'Тёплые Стены']);
                        break;
                }
            }

            // -------------------------------------------------------
            // Сортировка опции "Производитель" на кирпичах
            // -------------------------------------------------------
            if ($GLOBALS['modx']->resource->context_key == 'kirpich-m') {
                if ($options['name'] == 'proizvoditel') {
                    switch ($GLOBALS['modx']->resource->id) {
                        // Облицовочные
                        case 37609:
                            $sorted = $this->sortByCustomOrder($sorted, $results, ['ЛСР', 'Faber Jar', 'Feldhaus Klinker', 'Wienerberger', 'Roben', 'Эталон ЗСМ']);
                            break;
                        // Клинкерные
                        case 19852:
                            $sorted = $this->sortByCustomOrder($sorted, $results, ['ЛСР', 'Faber Jar', 'Feldhaus Klinker', 'Wienerberger', 'Roben']);
                            break;
                        // Фасадная плитка
                        case 37478:
                            $sorted = $this->sortByCustomOrder($sorted, $results, ['Feldhaus Klinker', 'Roben', 'Terca', 'Wienerberger', 'ESTIMA', 'Nelissen']);
                            break;
                        // Строительные
                        case 37608:
                            $sorted = $this->sortByCustomOrder($sorted, $results, ['ЛСР', 'Радошковичи (Ceglar)', 'БКСМ', 'ВКЗ', 'Витебск цех-1', 'ЗСМ Эталон', 'Псковский КЗ']);
                            break;
                        // Керамоблоки
                        case 19847:
                            $sorted = $this->sortByCustomOrder($sorted, $results, ['ЛСР', 'Радошковичи (Ceglar)', 'BRAER', 'Гжельский кирпичный завод', 'ВКЗ', 'Forati', 'Porotherm (Wienerberger)']);
                            break;
                        // Остальные кирпичи
                        default:
                            $sorted = $this->sortByCustomOrder($sorted, $results, ['ЛСР', 'Faber Jar', 'Feldhaus Klinker', 'Roben', 'Эталон ЗСМ']);
                            break;
                    }
                }
            }

            // -------------------------------------------------------
            // Сортировка некоторых опций на кровле
            // -------------------------------------------------------
            if ($GLOBALS['modx']->resource->context_key == 'krovlya') {
                switch (true) {
                    case $options['name'] == 'collection' && $GLOBALS['modx']->resource->id == 16788:
                        $sorted = $this->sortByCustomOrder($sorted, $results, ['Монтеррей', 'Супермонтеррей', 'Classic', 'Ламонтерра', 'Ламонтерра X', 'Kvinta Uno', 'Ламонтерра XL', 'Kvinta plus']);
                        break;

                    case $options['name'] == 'cvet':
                        switch (true) {
                            case in_array($GLOBALS['modx']->resource->id, [16788, 86214, 22594]):
                                $sorted = $this->sortByCustomOrder($sorted, $results, ['RAL 3005', 'RAL 6005', 'RAL 8004', 'RAL 8017', 'RR 32', 'RAL 7024', 'RAL 3009', 'RAL 5002']);
                                break;

                            case in_array($GLOBALS['modx']->resource->id, [12069, 16789, 11760, 37621, 76923]):
                                $sorted = $this->sortByCustomOrder($sorted, $results, [
                                    'RAL 3005',
                                    'RAL 6005',
                                    'RAL 8004',
                                    'RAL 8017',
                                    'RR 32',
                                    'RAL 7024',
                                    'RAL 3009',
                                    'RAL 5002',
                                    'NL805',
                                    'RAL 1014',
                                    'RAL 1015',
                                    'RAL 1018',
                                    'RAL 1035',
                                    'RAL 2004',
                                    'RAL 3003',
                                    'RAL 3011',
                                    'RAL 3013',
                                    'RAL 3020',
                                    'RAL 5005',
                                    'RAL 5015',
                                    'RAL 5018',
                                    'RAL 5021',
                                    'RAL 6002',
                                    'RAL 6007',
                                    'RAL 6018',
                                    'RAL 6019',
                                    'RAL 6020',
                                    'RAL 7004',
                                    'RAL 7005',
                                    'RAL 7016',
                                    'RAL 8019',
                                    'RAL 9002',
                                    'RAL 9003',
                                    'RAL 9005',
                                    'RAL 9006',
                                    'RAL 9010',
                                    'RR 11',
                                    'RR 21',
                                    'RR 22',
                                    'RR 23',
                                    'RR 29',
                                    'RR 33',
                                    'RR 35',
                                    'RR 750',
                                    'RR 887',
                                ]);
                                break;

                            case in_array($GLOBALS['modx']->resource->id, [26581, 81051]):
                                $sorted = $this->sortByCustomOrder($sorted, $results, [
                                    'RAL 3005',
                                    'RAL 6005',
                                    'RAL 8004',
                                    'RAL 8017',
                                    'RR 32',
                                    'RAL 7024',
                                    'RAL 3009',
                                    'RAL 5002',
                                    'NL805',
                                    'RAL 1014',
                                    'RAL 1015',
                                    'RAL 1018',
                                    'RAL 1019',
                                    'RAL 1035',
                                    'RAL 2004',
                                    'RAL 3003',
                                    'RAL 3011',
                                    'RAL 3020',
                                    'RAL 5005',
                                    'RAL 5015',
                                    'RAL 5021',
                                    'RAL 6002',
                                    'RAL 6007',
                                    'RAL 6011',
                                    'RAL 6018',
                                    'RAL 6019',
                                    'RAL 6020',
                                    'RAL 6033',
                                    'RAL 7004',
                                    'RAL 7005',
                                    'RAL 7016',
                                    'RAL 7035',
                                    'RAL 7040',
                                    'RAL 7044',
                                    'RAL 8019',
                                    'RAL 9002',
                                    'RAL 9003',
                                    'RAL 9005',
                                    'RAL 9006',
                                    'RAL 9010',
                                    'RAL 9011',
                                    'RR 11',
                                    'RR 21',
                                    'RR 23',
                                    'RR 29',
                                    'RR 33',
                                    'RR 35',
                                    'RR 750',
                                    'RR 887',
                                    'без покрытия',
                                ]);
                                break;
                        }

                        break;

                    case $options['name'] == 'pokrytie':
                        switch (true) {
                            case in_array($GLOBALS['modx']->resource->id, [16788, 86214, 22594]):
                                $sorted = $this->sortByCustomOrder($sorted, $results, ['Полиэстер', 'Satin', 'Drap', 'PurLite Мatt', 'PURMAN®', 'Rooftop Matte']);
                                break;

                            case in_array($GLOBALS['modx']->resource->id, [12069, 16789, 11760, 37621, 76923]):
                                $sorted = $this->sortByCustomOrder($sorted, $results, [
                                    'Полиэстер',
                                    'Satin',
                                    'Drap',
                                    'PurLite Мatt',
                                    'PURMAN®',
                                    'Rooftop Matte',
                                    'AGNETA®',
                                    'Atlas',
                                    'CLOUDY®',
                                    'Drap ST',
                                    'GreenCoat Pural BT, matt',
                                    'GreenСoat Pural BT',
                                    'NormanMP',
                                    'PURETAN®',
                                    'Quarzit',
                                    'Quarzit lite',
                                    'Quarzit PRO Matt',
                                    'Satin Мatt',
                                    'VALORI',
                                    'Velur',
                                    'VikingMP®',
                                    'VikingMP® E',
                                    'Полиэстер в пленке',
                                ]);
                                break;

                            case in_array($GLOBALS['modx']->resource->id, [26581, 81051]):
                                $sorted = $this->sortByCustomOrder($sorted, $results, [
                                    'Полиэстер',
                                    'Satin',
                                    'Drap',
                                    'PURMAN®',
                                    'Rooftop Matte',
                                    'AGNETA®',
                                    'Atlas',
                                    'CLOUDY®',
                                    'Drap ST',
                                    'Drap TwinColor',
                                    'ECOSTEEL®',
                                    'ECOSTEEL® матовый',
                                    'ECOSTEEL® текстурированный',
                                    'GreenCoat Pural BT',
                                    'GreenCoat Pural BT, matt',
                                    'NormanMP',
                                    'Print-double Elite',
                                    'Print-double Premium',
                                    'Print Elite',
                                    'Print Premium',
                                    'PURETAN®',
                                    'PurLite Matt',
                                    'PurPro Matt',
                                    'Quarzit',
                                    'Quarzit lite',
                                    'Quarzit PRO Matt',
                                    'Satin Matt',
                                    'VALORI',
                                    'Velur',
                                    'VikingMP®',
                                    'VikingMP® E',
                                    'Поликарбонат',
                                    'Полиэстер двусторонний',
                                    'Полиэстер матовый двусторонний',
                                    'Цинк',
                                ]);
                                break;
                        }
                        break;

                    case $options['name'] == 'profil' && $GLOBALS['modx']->resource->id == 86214:
                        $sorted = $this->sortByCustomOrder($sorted, $results, ['C20', 'C8', 'HC35', 'C10', 'C21', 'H75']);
                        break;
                }
            }

            // -------------------------------------------------------
            // Сортировка производителей на контекстах
            // -------------------------------------------------------
            if ($options['name'] == 'proizvoditel') {
                switch ($GLOBALS['modx']->resource->context_key) {
                    case 'krovlya':
                        $sorted = $this->sortByCustomOrder($sorted, $results, ['Docke', 'Технониколь', 'Katepal', 'Тегола', 'Icopal', 'Металл Профиль', 'Grand Line', 'Металл-Профиль']);
                        break;

                    case 'fasad':
                        switch ($GLOBALS['modx']->resource->id) {
                            case 36783:
                                $sorted = $this->sortByCustomOrder($sorted, $results, ['Grand Line', 'Docke', 'Альта-Профиль', 'Ю-Пласт', 'FineBer', 'VOX']);
                            break;

                            case 36793:
                                $sorted = $this->sortByCustomOrder($sorted, $results, ['Docke', 'Альта-Профиль', 'VOX', 'Ю-Пласт', 'Vilo', 'FineBer', 'Grand Line']);
                                break;

                            case 34819:
                                $sorted = $this->sortByCustomOrder($sorted, $results, ['Cedral', 'CM BORD', 'Decover', 'Фибратек', 'LATONIT', 'БЕТЭКО']);
                                break;

                            case 36784:
                                $sorted = $this->sortByCustomOrder($sorted, $results, ['Аквасистем', 'Grand Line', 'Металл-Профиль']);
                                break;
                        }

                        break;

                    case 'plitaosb':
                        $sorted = $this->sortByCustomOrder($sorted, $results, ['Knauf', 'Волма', 'Gyproc', 'Nordeco', 'Green Board', 'Калевала ЭкоДом', 'Кроношпан', 'Муром', 'Талион (Ультралам)']);
                        break;

                    case 'plity-mdvp':
                        $sorted = $this->sortByCustomOrder($sorted, $results, ['ISOPLAAT', 'STEICO', 'Белтермо']);
                        break;
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
