<?php

class myCustomFilter extends mse2FiltersHandler {

    private function sortByCustomOrder($sorted, $results, $orderKeys) {
        foreach ($orderKeys as $key) {
            if (!empty($results[$key])) {
                $sorted[$key] = $results[$key];
            }
        }

        // Добавляем остальные элементы - на всякий случай, вдруг пользователь в $orderKeys передал не все ключи
        $diff = array_diff(array_keys($results), array_keys($sorted));
        foreach ($diff as $key) {
            if (!empty($results[$key])) {
                $sorted[$key] = $results[$key];
            }
        }

        return $sorted;
    }

    public function sortFilters(array $results, $type = 'default', $options = []) {
        $sorted = [];

        if ($type === 'options') {
            // Сортировка float значений по возрастанию (из-за точки они сортируются неправильно)
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

            // Сортировка опции "Тип" на некоторых ресурсах
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


            if ($options['name'] === 'produktovaya-lineyka') {
                switch ($GLOBALS['modx']->resource->context_key) {
                    case 'rockwool':
                        $sorted = $this->sortByCustomOrder($sorted, $results, ['Лайт Баттс', 'Руф Баттс', 'Фасад Баттс', 'Флор Баттс', 'Венти Баттс', 'Каркас Баттс', 'Эконом', 'Акустик Баттс', 'Кавити Баттс', 'Арктик', 'Рокфасад']);
                        break;
                    case 'tn':
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
