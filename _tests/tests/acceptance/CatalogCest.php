<?php

/**
 * Тесты для страницы Каталог.
 */
class CatalogCest {

    private $itemsCssSelector = '.listing__products-list .listing__products-item';

    public function _before(AcceptanceTester $I) {
        $I->comment('Проверка страницы Каталог');
        $I->amOnPage('/catalog/');
    }


    public function checkItems(AcceptanceTester $I) {
        $I->wantTo('Проверка вывода товаров и работы кнопки "Показать еще"');

        // Подсчитываем кол-во товаров
        $arrayProducts = $I->grabMultiple($this->itemsCssSelector);
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
            $arrayProducts = $I->grabMultiple($this->itemsCssSelector);
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


    public function checkFavAndCompBtns(AcceptanceTester $I) {
        $I->wantTo('Проверка кнопок "Добавить в избранное" и "Добавить в сравнение" в чанке');

        // Существует ли хотя бы один чанк?
        $fstItemSelector = '//div[contains(@class, "listing__products-list")]//div[contains(@class, "listing__products-item")][1]';
        $I->seeElement($fstItemSelector);

        // Получаем id товара. Этот id будет записываться в куки
        $id = $I->grabValueFrom($this->itemsCssSelector . ' .product-item__ms2-elems .product-item__form-add input[name="id"]');
        if (empty($id)) {
            $I->fail('Не удалось получить id первого товара');
        }
        $I->comment('Id товара равен: ' . $id);

        // Определяем переменные для цикла
        $keys = [
            'fav' => 'избранное',
            'comp' => 'сравнение'
        ];

        // Поскольку действия для проверки кнопок добавления в избранное и сравнение одинаковые, делаем их в цикле
        foreach ($keys as $k => $val) {
            $I->comment('Проверка кнопки "Добавить в '. $val.'"');

            // Пробуем добавить товар
            $I->click($fstItemSelector . '//span[contains(@class, "listing__products-item-btn-' . $k . '")]');

            // Смотрим, изменился ли класс
            $I->seeElement($fstItemSelector . '//span[contains(@class, "listing__products-item-btn-' . $k . '") and contains(@class, "active")]');

            // Проверяем куки
            $cookie = $I->grabCookie($k . 'Ids');
            if (empty($cookie)) {
                $I->fail('Не установилась куки при щелчке по кнопке для добавления товара в ' . $val);
            }
            $I->comment('Куки равна: ' . $cookie);

            // Сравниваем id и куки
            if ($id != $cookie) {
                $I->fail('id не равен cookie');
            }

            // Смотрим, изменилось ли количество товара на кнопке в шапке
            $val = $I->grabTextFrom('//span[contains(@class, "header__' . $k . '-value")]');
            if ($val == 0) {
                $I->fail('Не изменилось кол-во товара на кнопке в шапке');
            }

            // Попробуем удалить товар из избранного
            $I->click($fstItemSelector . '//*[contains(@class, "listing__products-item-btn-' . $k . '")]');

            // Смотрим, изменился ли класс
            $I->dontSeeElement($fstItemSelector . '//*[contains(@class, "listing__products-item-btn-' . $k . '") and contains(@class, "active")]');

            // Проверяем куки
            $cookie = $I->grabCookie($k . 'Ids');
            if (!empty($cookie)) {
                $I->fail('Не удалилась куки при щелчке по кнопке для удаления товара в ' . $val);
            }
        }
    }

}
