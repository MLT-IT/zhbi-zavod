<?php

/**
 * Тесты для страницы Каталог.
 */
class CatalogCest {

    private $itemsSelector = '.listing__products-list .listing__products-item';

    public function _before(AcceptanceTester $I) {
        $I->comment('Проверка страницы Каталог');
        $I->amOnPage('/catalog/');
    }


    public function checkItems(AcceptanceTester $I) {
        $I->wantTo('Проверка вывода товаров и работы кнопки "Показать еще"');

        // Подсчитываем кол-во товаров
        $arrayProducts = $I->grabMultiple($this->itemsSelector);
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
            $arrayProducts = $I->grabMultiple($this->itemsSelector);
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


    public function checkFavAndComp(AcceptanceTester $I) {
        $I->wantTo('Проверка кнопки "Добавить в избранное"');

        // Получаем id. Этот id будет записываться в куки
        $id = $I->grabValueFrom($this->itemsSelector . ' .product-item__ms2-elems .product-item__form-add input[name="id"]');
        if (empty($id)) {
            $I->fail('Не удалось получить id первого товара');
        }
        $I->comment('Id товара равен: ' . $id);

        // Кликаем в первой карточке по кнопке для добавления товара в избранное
        $I->click($this->itemsSelector . ' .listing__products-item-btn-compare');

        // Получаем куки
        $cookie = $I->grabCookie('compIds');
        if (empty($cookie)) {
            $I->fail('Не установилась куки при щелчке по кнопке для добавления товара в Избранное');
        }
        $I->comment('Куки равна: ' . $cookie);

        // Сравниваем id и куки
        if ($id != $cookie) {
            $I->fail('id не равен cookie');
        }
    }

}
