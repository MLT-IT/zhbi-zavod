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

class myCustomFilter extends mse2FiltersHandler
{

    private $debug = false;
    private function debugArray(array $array, String $header)
    {
        if ($this->debug) {
            echo "<div>";
            echo "<strong>" . $header . "</strong><br>";
            print_r($array);
            echo "<br>";
            echo "<br>";
            echo "</div>";
        }
    }

    /**
     * Функция позволяет отсортировать массив элементов $unsortedElems в порядке значений, находящихся в массиве $orderValues.
     *
     * Зачем сюда передавать элементы $sortedElems, если передаются элементы $unsortedElems? И наоборот?
     * Затем, что в $sortedElems могут быть не все элементы. Но они отсортированы по определенному алгоритму. А в $unsortedElems точно все, но они не отсортированы вообще. В конце функции все это объединяется, чтобы ни один элемент не потерялся.
     *
     * @param $sortedElems - уже отсортированные по какому-либо алгоритму элементы.
     * @param $unsortedElems - еще неотсортированные элементы.
     * @param $orderValues - массив с ключами - в каком порядке сортировать элементы $unsortedElems.
     * @param $alfavit_sort - Сортировать по алфавиту?
     * @return array - массив с отсортированными элементами.
     */
    private function sortByCustomOrder($sortedElems, $unsortedElems, $orderValues, $alfavit_sort = false)
    {

        // Сортируем элементы $unsortedElems в порядке $orderValues
        $resultElems = [];

        $lowercaseUnsortedElems = array_change_key_case($unsortedElems, CASE_LOWER);

        foreach ($orderValues as $key) {
            $searchLowerCase = false;
            foreach ($unsortedElems as  $keyUnsorted => $valueUnsorted) {
                if (mb_strtolower($key) == mb_strtolower($keyUnsorted)) {
                    $searchLowerCase = true;
                    $resultElems[mb_strtolower($key)] = $valueUnsorted;
                }
            }
            if (!empty($unsortedElems[$key]) and !$searchLowerCase) {
                $resultElems[$key] = $unsortedElems[$key];
            }
        }
        //echo "<div> ";
        $this->debugArray($lowercaseUnsortedElems, "В нижнем регистре");
        $this->debugArray($sortedElems, "Сортированные");

        if ($alfavit_sort) {
            asort($unsortedElems);
        }
        // Добавляем остальные элементы, на всякий случай - вдруг программист при вызове этой функции в $orderValues передал не все ключи
        $diff = array_diff(array_keys($unsortedElems), array_keys($sortedElems));
        foreach ($diff as $key) {
            if (!empty($unsortedElems[$key])) {
                $sortedElems[$key] = $unsortedElems[$key];
            }
        }

        $mergeElems = [];

        foreach ($sortedElems as $sortedElem) {
            $search = false;
            foreach ($resultElems as $resultElem) {
                if ($sortedElem['value'] == $resultElem['value']) {
                    $search = true;
                    break;
                }
            }
            if (!$search) {
                $mergeElems[] = $sortedElem;
            }
        }

        $this->debugArray($mergeElems, "Merge");

        // Объединяем
        $sortedElems = array_merge($resultElems, $mergeElems);

        //$this->debugArray($diff, "Ключи");
        $this->debugArray($sortedElems, "Отсортированные");

        $uniqueSort = [];

        foreach ($sortedElems as $sortedElem) {
            $search = false;
            foreach ($uniqueSort as $uniqueElem) {
                if ($sortedElem['title'] == $uniqueElem['title']) {
                    $search = true;
                }
            }
            if (!$search) {
                $uniqueSort[] = $sortedElem;
            }
        }

        return $uniqueSort;
    }

    public function sortFilters(array $results, $type = 'default', $options = [])
    {
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

            if ($GLOBALS['modx']->resource->context_key == 'krovelnyjstroymarket') {
                // Металлочерепица и потомки
                if (in_array($GLOBALS['modx']->resource->id, [125530, 126226, 126221, 126220, 126222, 126223, 126224, 126225, 125631, 125632, 125633, 125627, 125628, 125629, 125630, 125626, 166018, 166019, 166020, 166021, 166022, 166023, 166024, 166025, 166026, 166027, 166028, 166029, 166030, 166031, 166032, 166033, 166034, 166035, 166036, 166037, 166038, 166936, 166937, 166938, 166939, 166940, 166941, 166942, 166943, 166944, 166945, 166946, 166947, 166948, 166949, 166950, 166951, 166952, 166953, 166954, 166955, 166997, 166998, 166999, 167000, 167001, 167002, 167003, 167004, 167005, 167006, 167007, 167008, 167009, 167010, 167011, 167012, 167013, 167014])) {
                    switch ($options['name']) {
                        case 'cvet':
                            $sorted = $this->sortByCustomOrder($sorted, $results, ['RAL 7024', 'RAL 8017', 'RAL 3009', 'RAL 3005', 'RAL 6020', 'RAL 7004', 'RAL 5002', 'RAL 6005', 'RR 32', 'RAL 1014', 'RAL 1018', 'RAL 5015', 'RAL 7005', 'RAL 8019', 'RAL 5005', 'RAL 7016', 'RAL 9002', 'RAL 9006', 'RAL 8004', 'RAL 1015', 'RAL 3011', 'RAL 9005', 'NL805', 'RAL 1035', 'RAL 2004', 'RAL 3003', 'RAL 3013', 'RAL 3020', 'RAL 5018', 'RAL 5021', 'RAL 6002', 'RAL 6007', 'RAL 6018', 'RAL 6019', 'RAL 9003', 'RAL 9010', 'RR 11', 'RR 21', 'RR 22', 'RR 23', 'RR 29', 'RR 33', 'RR 35', 'RR 750', 'RR 887']);
                            break;
                    }
                }

                // Штакетник и потомки
                if (in_array($GLOBALS['modx']->resource->id, [125541, 126157, 126155, 126156, 126150, 126151, 126152, 126148, 126149, 126146, 126147, 126144, 126145, 126142, 126143, 126140, 126141, 126138, 166988, 166989, 166990, 166991, 166992, 166993, 166994, 166995, 166996, 167019, 167020, 167021, 167022, 167023, 167024,])) {
                    switch ($options['name']) {
                        case 'cvet':
                            $sorted = $this->sortByCustomOrder($sorted, $results, ['RAL 7024', 'RAL 8017', 'RAL 6005', 'RAL 3005', 'RAL 8019', 'RAL 7004', 'RAL 6019', 'RAL 7016', 'RAL 1014', 'RAL 5005']);
                            break;
                    }
                }

                // Профнастил и потомки
                if (in_array($GLOBALS['modx']->resource->id, [125537, 126567, 126566, 126568, 126563, 126565, 126564, 126562, 126561, 126560, 126558, 126559, 126557, 126556, 126555, 126553, 126554, 126552, 126551, 126550, 126310, 126309, 126308, 126307, 126306, 126305, 126304, 126303, 126302, 126301, 126300, 126299, 126297, 126298, 126293, 126296, 126295, 126294, 126292, 126291, 126290, 126154, 126153, 166004, 166005, 166006, 166007, 166008, 166009, 166010, 166011, 166012, 166013, 166014, 166015, 166016, 166017, 166043, 166044, 166045, 166046, 166047, 166048, 166049, 166050, 166051, 166052, 166053, 166054, 166055, 166056, 166969, 166970, 166971, 166972, 166973, 166974, 166975, 166976, 166977, 166978, 166979, 166980, 166981, 166982, 166983, 166984, 166985, 166986, 166987,])) {
                    switch ($options['name']) {
                        case 'cvet':
                            $sorted = $this->sortByCustomOrder($sorted, $results, ['RAL 3005', 'RAL 6005', 'RAL 8004', 'RAL 8017', 'RR 32', 'RAL 7024', 'RAL 3009', 'RAL 5002']);
                            break;
                    }
                }
            }
        }

        // файл со значениямии фильтров sortFilterValue
        require_once MODX_CORE_PATH . 'components/msearch2/custom/filters/JsonFiltersSort.php';
        $category = sortFilterValueCategory($GLOBALS['modx']->resource->id, $GLOBALS['modx']->resource->context_key);
        if (!empty($category)) {
            foreach ($category['options']  as $option) {
                if ($options['name'] == $option['option_key']) {
                    $sorted = $this->sortByCustomOrder(
                        $sorted,
                        $results,
                        $option['option_value']
                    );
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
