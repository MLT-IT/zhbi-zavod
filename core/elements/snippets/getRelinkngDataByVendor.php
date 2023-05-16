<?php

if (!class_exists('Relinking')) {
    class Relinking {

        public function getData() {
            global $modx;
            $neededOptions = ['plotnost-ob'];
            $currentOptions = $modx->resource->loadData()->get('options');
            $context = $modx->resource->context_key;
            $id = $modx->resource->id;
            $optionsHash = [];

            // Производитель
            $proizvoditel = $currentOptions['proizvoditel'];
            if (empty($proizvoditel) || empty($proizvoditel[0])) {
                return [];
            }
            $proizvoditel = $proizvoditel[0];

            // Нужные опции
            foreach ($neededOptions as $key) {
                if (!empty($currentOptions[$key]) && !empty($currentOptions[$key][0])) {
                    $val = $currentOptions[$key];
                    asort($val);

                    foreach ($val as $k => $v) {
                        $val[$k] = "$key=$v";
                    }
                    $val = implode('|', $val);
                    $optionsHash[$key] = $val;
                }
            }

            if (!empty($optionsHash)) {
                // Составляем хеш для опций
                ksort($optionsHash);
                $optionsHash = implode('|', $optionsHash);
                $md5 = md5($optionsHash);
                // Получаем опции для SQL-запроса
                $optionsHash = [];
                foreach ($neededOptions as $key) {
                    $optionsHash[] = "'$key'";
                }
                $optionsHash = implode(', ', $optionsHash);
            }

            $razmer = explode('х', $currentOptions['razmer-mm'][0]);
            $razmer = implode('х', [$razmer[0], $razmer[1]]) . '%';

            $query = "SELECT 
            resources.`id`,
            resources.`uri`,
            proizvoditel.`value` AS proizvoditel,
            plotnost.`value`  AS plotnost,
            razmer.`value`    AS razmer
            
            FROM modx_ms2_product_options main
            
            LEFT JOIN modx_ms2_product_options proizvoditel ON proizvoditel.`key` = 'proizvoditel' AND proizvoditel.`product_id` = main.`product_id`
            LEFT JOIN modx_ms2_product_options plotnost ON plotnost.`key` = 'plotnost-ob' AND plotnost.`product_id` = main.`product_id`
            LEFT JOIN modx_ms2_product_options razmer ON razmer.`key` = 'razmer-mm' AND razmer.`product_id` = main.`product_id`
            LEFT JOIN modx_site_content resources ON resources.`id` = main.`product_id`
            
            WHERE resources.`context_key` = '$context'
            AND proizvoditel.`value` != '$proizvoditel'
            AND main.`product_id` != $id
            AND razmer.`value` LIKE '$razmer'
            AND main.`product_id` IN (
                -- Получаем все товары с таким же хешем
                SELECT `product_id`
                FROM modx_ms2_product_options
                WHERE `key` IN ($optionsHash)
                AND `value` != ''
                GROUP BY `product_id`
                HAVING MD5(GROUP_CONCAT(CONCAT(`key`, '=', `value`) ORDER BY `key` ASC, `value` ASC SEPARATOR '|')) = '$md5')
            
            GROUP BY main.`product_id`
            LIMIT 42";

            // Выполняем SQL-запрос
            $result = $modx->query($query);

            // Обрабатываем результат SQL-запроса
            if ($result === false) {
                return false;
            }

            // Получаем данные из результата SQL-запроса
            $result = $result->fetchAll(PDO::FETCH_ASSOC);

            // Сортируем данные
            $result = $this->sortData($result, ['ЛСР', 'СК (СтройКомплект)', 'Могилевский газосиликат', 'AEROC', 'Белорусский БЦК', 'YTONG', 'ЕАБ (ЕвроАэроБетон)', 'Н+Н', 'Bonolit', 'Забудова']);

            return $result;
        }

        protected function sortData($items, $order) {
            $result = [];
            $itemVendors = array_column($items, 'proizvoditel');

            // Сортируем
            foreach ($order as $key => $val) {
                // 100, чтобы избежать вечного цикла. А цикл нужен, потому что может быть больше 1-го значения с таким производителем
                for ($i = 0; $i < 100; $i++) {
                    $index = array_search($val, $itemVendors);
                    if ($index === false) {
                        break;
                    } else {
                        $result[] = $items[$index];
                        unset($itemVendors[$index]);
                        unset($items[$index]);
                    }
                }
            }

            // Добавляем в конец те item'ы, которых не было в $order
            foreach ($items as $val) {
                $result[] = $val;
            }

            return $result;
        }
    }
}

$relinking = new Relinking();
return $relinking->getData();
