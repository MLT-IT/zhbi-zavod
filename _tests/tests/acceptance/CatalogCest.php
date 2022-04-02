<?php

class CatalogCest {

    public function checkCatalogItems(AcceptanceTester $I) {
        $I->wantTo('Проверка вывода товаров на странице каталога');
        $I->amOnPage('/catalog/');

        // Подсчитываем кол-во товаров
        $arrayProducts = $I->grabMultiple('.listing__products-item');
        $sumProducts1 = count($arrayProducts);
        $I->comment('В каталоге найдено товаров: ' . $sumProducts1);

        // Если товаров не найдено, то кидаем ошибку
        if ($sumProducts1 == 0) {
            $I->fail('В каталоге не отображаются товары');
        }

        // Проверяем кнопку "Показать еще"
        $btnMoreSelector = '.btn.btn-default.btn_more';
        $btnMore = $I->grabMultiple($btnMoreSelector);
        if (count($btnMore) > 0) {
            // Не знаю, почему, но без скролла не срабатывает клик
            $I->scrollTo(['css' => $btnMoreSelector], 0, 0);
            $I->click($btnMoreSelector);

            // Подождем загрузку новых карточек - не более 10 секунд
            $I->waitForJS("return $.active == 0;", 10);

            // Посчитаем, сколько теперь карточек
            $arrayProducts = $I->grabMultiple('.listing__products-item');
            $sumProducts2 = count($arrayProducts);
            $I->comment('После нажатия на кнопку "Показать еще" в каталоге стало товаров: ' . $sumProducts2);

            // Если количество одинаковое, то кидаем ошибку
            if ($sumProducts1 == $sumProducts2) {
                $I->fail('После нажатия на кнопку "Показать еще" кол-во товаров такое же, как до нажатия на кнопку');
            }
        } else {
            //$I->comment('В каталоге нет кнопки "Показать еще", может, это какая-то ошибка?');
            $I->fail('В каталоге нет кнопки "Показать еще"');
        }
    }

}
