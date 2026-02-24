<?php

const STOCK_TYPE_LIMIT = "limit"; // тип с лимитом
const STOCK_TYPE_NOT = "not"; // тип без остатков
const STOCK_TYPE_STOCK = "stock"; // тип в наличии

const STOCK_KEY_LIMIT = "limitStocks"; // ключ с лимитом
const STOCK_KEY_NOT = "notStocks"; // ключ без остатков
const STOCK_KEY_STOCK = "stocks"; // ключ в наличии

const STOCK_KEY_STOCKS = "stocks"; // ключ складов
const STOCK_KEY_HEADER = "header"; // ключ заголовка

const STOCK_HEADER_STOCK = "В наличии"; // заголовок складов в наличии
const STOCK_HEADER_LIMIT = "Заканчивается"; // заголовок складов с лимитом
const STOCK_HEADER_NOT = "Под запрос"; // заголовок складов без остатков

const STOCK_HEADER_DELIVERY_NOT = "Доставим в течение 1-2 дней"; // текст доставки складов без остатков

class StockTemplate
{
    private $minStocks = 0;
    private $maxStocks = 0;

    private $minLimitStocks = 0;
    public $maxLimitStocks = 0;

    public $minNotStocks = 0;
    public $maxNotStocks = 0;

    public array $stocks = [];
    public array $indexLimitStocks = [];
    public array $indexNotStocks = [];
    public array $indexStocks = [];

    public $id = 0;
    public array $resultStocks = [];


    public function __construct(array $stocks, int $limitStocks = 0, int $notStocks = 0, $id = 0, ?int $minLimitStocks = null, ?int $maxLimitStocks = null)
    {
        $this->minStocks = $minLimitStocks !== null ? $minLimitStocks : MIN_STOCKS;
        $this->maxStocks = $maxLimitStocks !== null ? $maxLimitStocks : MAX_STOCKS;
        $this->minLimitStocks = MIN_LIMIT_STOCKS;
        $this->maxLimitStocks = MAX_LIMIT_STOCKS;
        $this->minNotStocks = MIN_NOT_STOCKS;
        $this->maxNotStocks = MAX_NOT_STOCKS;

        $this->stocks = $stocks;
        $this->indexLimitStocks = $this->generateIndexLimitStocks($stocks, $limitStocks);
        // генерация случайных, но не использующихся индексов складов без остатков
        $this->indexNotStocks = $this->generateIndexNotStocks($stocks, $this->indexLimitStocks, $notStocks);
        //обычные склады индексы
        $this->indexStocks = $this->generateIndexStocks($stocks, $this->indexLimitStocks, $this->indexNotStocks);
        $this->id = $id;
    }

    /**
     * @param array $stocks массив складов
     * @param int $limitStocks количество складов с ограничением
     * @param int $notStocks количество складов без наличия
     * @return void
     */
    public function make()
    {
        // генерация случайных индексов складов с лимитом
        $this->getArrayStocks();
        $this->getArrayHeaderStocks();
        return $this->resultStocks;
    }

    /**
     * Генерация случайных индексов складов с лимитом
     * @param array $stocks массив складов
     * @param int $limitStocks количество складов с лимитом
     * @return array
     */
    protected function generateIndexLimitStocks($stocks, $limitStocks)
    {
        $totalStocks = count($stocks);
        if ($totalStocks <= 0 || $limitStocks <= 0) {
            return [];
        }

        $limitStocks = min((int)$limitStocks, $totalStocks);
        $indexLimitStocks = (array) array_rand($stocks, $limitStocks);
        return $indexLimitStocks;
    }

    /**
     * Генерация случайных индексов складов без остатков
     * @param array $stocks массив складов
     * @param array $indexLimitStocks индексы складов с лимитом
     * @param int $notStocks количество складов без остатков
     * @return array
     */
    protected function generateIndexStocks($stocks, $indexLimitStocks, $indexNotStocks)
    {
        $indexStocks = array_diff(array_keys($stocks), array_merge($indexLimitStocks, $indexNotStocks));
        return $indexStocks;
    }

    /**
     * Генерация случайных индексов складов без остатков
     * @param array $stocks массив складов
     * @param array $indexLimitStocks индексы складов с лимитом
     * @param int $notStocks количество складов без остатков
     * @return array
     */
    protected function generateIndexNotStocks($stocks, $indexLimitStocks, $notStocks)
    {
        $indexNotStocks = array_diff(array_keys($stocks), $indexLimitStocks);
        $availableStocks = count($indexNotStocks);
        if ($availableStocks <= 0 || $notStocks <= 0) {
            return [];
        }

        $notStocks = min((int)$notStocks, $availableStocks);
        return (array) array_rand($indexNotStocks, $notStocks);
    }

    /**
     * Генерация массива складов
     * @param array $stocks массив складов
     * @param array $indexStocks индексы складов
     * @param array $indexLimitStocks индексы складов с лимитом
     * @param array $indexNotStocks индексы складов без остатков
     * @param int $id id ресурса
     * @return array
     */
    public function getArrayStocks()
    {
        foreach ($this->stocks as $key => $stock) {

            if (in_array($key, $this->indexStocks)) {
                $resultStocks[STOCK_KEY_STOCK][] = [
                    "title" => $stock['title'],
                    "url" => $stock['url'],
                    "count" => $this->getRandomNumber($this->minStocks, $this->maxStocks, $this->id, $key),
                    "type" => STOCK_TYPE_STOCK,
                ];
            }

            if (in_array($key, $this->indexLimitStocks)) {
                $resultStocks[STOCK_KEY_LIMIT][] = [
                    "title" => $stock['title'],
                    "url" => $stock['url'],
                    "count" => $this->getRandomNumber($this->minLimitStocks, $this->maxLimitStocks, $this->id, $key),
                    "type" => STOCK_TYPE_LIMIT,
                ];
            }

            if (in_array($key, $this->indexNotStocks)) {
                $resultStocks[STOCK_KEY_NOT][] = [
                    "title" => $stock['title'],
                    "url" => $stock['url'],
                    "count" => $this->getRandomNumber($this->minNotStocks, $this->maxNotStocks, $this->id, $key),
                    "type" => STOCK_TYPE_NOT
                ];
            }
        }

        $this->resultStocks[STOCK_KEY_STOCKS] = $resultStocks;
        return $this->resultStocks;
    }

    /**
     * Генерация массива заголовка складов
     * @return void
     */
    public function getArrayHeaderStocks()
    {
        if (count($this->indexStocks) + count($this->indexLimitStocks) == count($this->stocks)) {
            $this->resultStocks[STOCK_KEY_HEADER]['title'] = STOCK_HEADER_STOCK;
            $this->resultStocks[STOCK_KEY_HEADER]['type'] = STOCK_TYPE_STOCK;
            $this->resultStocks[STOCK_KEY_HEADER]['delivery'] = "";
        }

        if (count($this->indexLimitStocks) + count($this->indexNotStocks) == count($this->stocks)) {
            $this->resultStocks[STOCK_KEY_HEADER]['title'] = STOCK_HEADER_LIMIT;
            $this->resultStocks[STOCK_KEY_HEADER]['type'] = STOCK_TYPE_LIMIT;
            $this->resultStocks[STOCK_KEY_HEADER]['delivery'] = "";
        }

        if (count($this->indexNotStocks) == count($this->stocks)) {
            $this->resultStocks[STOCK_KEY_HEADER]['title'] = STOCK_HEADER_NOT;
            $this->resultStocks[STOCK_KEY_HEADER]['type'] = STOCK_TYPE_NOT;
            $this->resultStocks[STOCK_KEY_HEADER]['delivery'] = STOCK_HEADER_DELIVERY_NOT;
        }

        $this->resultStocks[STOCK_KEY_HEADER]['count'] = $this->getCountStocks();
    }

    /**
     * Установка минимального и максимального количества складов
     * @param int $min минимальное количество складов
     * @param int $max максимальное количество складов
     * @return void
     */
    public function setMinMaxStocks($min, $max)
    {
        $this->minStocks = $min;
        $this->maxStocks = $max;
    }

    /**
     * Установка минимального и максимального количества складов с лимитом
     * @param int $min минимальное количество складов с лимитом
     * @param int $max максимальное количество складов с лимитом
     * @return void
     */
    public function setMinMaxLimitStocks($min, $max)
    {
        $this->minLimitStocks = $min;
        $this->maxLimitStocks = $max;
    }

    /**
     * Установка минимального и максимального количества складов без остатков
     * @param int $min минимальное количество складов без остатков
     * @param int $max максимальное количество складов без остатков
     * @return void
     */
    public function setMinMaxNotStocks($min, $max)
    {
        $this->minNotStocks = $min;
        $this->maxNotStocks = $max;
    }

    /**
     * Установка индексов складов с лимитом
     * @param array $indexLimitStocks индексы складов с лимитом
     * @return void
     */
    public function setIndexLimitStocks($indexLimitStocks)
    {
        $this->indexLimitStocks = $indexLimitStocks;
    }

    /**
     * Установка индексов складов без остатков
     * @param array $indexNotStocks индексы складов без остатков
     * @return void
     */
    public function setIndexNotStocks($indexNotStocks)
    {
        $this->indexNotStocks = $indexNotStocks;
    }

    // на скольких складах в наличии
    public function getCountStocks()
    {
        $count = 0;
        foreach($this->resultStocks[STOCK_KEY_STOCKS] as $type => $stocks){
            foreach($stocks as $stock){
                $stock['count'] > 0 ? $count++ : null;
            }
        }
        return $count;
    }

    /**
     * Генерация случайного числа от - до
     * @param int $min минимальное число
     * @param int $max максимальное число
     * @param int $id id ресурса
     * @param int $unique уникальный идентификатор
     * @return int
     */
    public function getRandomNumber($min, $max, $id, $unique = 1)
    {
        $currentDate = date('Ymd');
        $seed = hexdec(substr(md5($currentDate . $id . $unique), 0, 8));
        mt_srand($seed);
        return mt_rand($min, $max);
    }
}
