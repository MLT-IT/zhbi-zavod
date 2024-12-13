<?php

if (!class_exists('shippedToday')) {
    class shippedToday {
        public function getText() {
            global $modx;
            $pdo = $modx->getService('pdoTools');

            $date = $this->getDate();
            switch ($modx->resource->context_key) {
                case 'web':
                    $max = 316;
                    $vol = $this->getVol($max);
                    $unit = $pdo->runSnippet('@FILE snippets/formOfWord.php', [
                        'n' => $vol,
                        'f1' => 'упаковка',
                        'f2' => 'упаковки',
                        'f5' => 'упаковок'
                    ]);
                    break;
                case 'kirpich-m5':
                    $min = 900;
                    $max = 2000;
                    $vol = $this->getVol($max, $min);
                    $unit = 'шт.';
                    break;
                case 'gazosilikatstroy':
                    $max = 154;
                    $vol = $this->getVol($max);
                    $unit = 'м3';
                    break;
            }
            return "Сегодня $date мы уже отгрузили $vol $unit";
        }

        protected function getDate() {
            $patterns = ['/January/', '/February/', '/March/', '/April/', '/May/', '/June/', '/July/', '/August/', '/September/', '/October/', '/November/', '/December/'];

            $replacements = ['января', 'февраля', 'марта', 'апреля', 'мая', 'июня', 'июля', 'августа', 'сентября', 'октября', 'ноября', 'декабря'];

            return preg_replace($patterns, $replacements, date('d F Y'));
        }

        protected function getVol($max, $min = 0) {
            $hour = (int) date('H');
            $step = $max / 17;
            if ($hour < 7) {
                return $min;
            } elseif ($hour >= 7 && $hour <= 23) {
                return max($min, round($step * ($hour - 6)));
            } else {
                return max($min, $step * 17);
            }
        }
    }
}

$shippedToday = new shippedToday();
return $shippedToday->getText();

