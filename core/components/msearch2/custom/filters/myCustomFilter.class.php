<?php

class myCustomFilter extends mse2FiltersHandler {

    public function sortFilters(array $results, $type = 'default', $options = []) {
        if ($type === 'options' && !empty($options) && !empty($options['name'])) {
            // Если есть хоть одно значение типа float
            $hasFloat = false;

            foreach ($results as $val) {
                if (!$hasFloat && floatval($val['value']) > 0) {
                    $hasFloat = true;
                    break;
                }
            }

            if ($hasFloat) {
                $keys = array_keys($results);
                sort($keys);

                $sorted = array();
                foreach ($keys as $k) {
                    $sorted[$k] = $results[$k];
                }

                return $sorted;
            }

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
