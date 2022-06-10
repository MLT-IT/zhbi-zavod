<?php

/**
 * Тесты для страницы Каталог.
 */
class CatalogCest {

    private $btnMoreSelector = '//div[contains(@class, "listing__products")]//button[contains(@class, "btn_more")]';
    private $itemsCssSelector = '.listing__products-list .listing__products-item';

    private $btnPlusSelector = '//span[contains(@class, "custom-counter__btn_dir_more")]';
    private $btnMinusSelector = '//span[contains(@class, "custom-counter__btn_dir_less")]';
    private $amountSelector = '//input[contains(@class, "custom-counter__amount")]';
    private $addSelector = '//div[contains(@class, "js-product__controls_action_add")]';
    private $changeSelector = '//div[contains(@class, "js-product__controls_action_change")]';
    private $addBtnSelector = '//span[contains(@class, "js-product__to-cart")]';
    private $itemSelector = '//div[contains(@class, "listing__products-list")]//div[contains(@class, "listing__products-item")]';

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

        $this->clickToBtnMore($I);

        // Посчитаем, сколько теперь карточек
        $arrayProducts = $I->grabMultiple($this->itemsCssSelector);
        $sumProducts2 = count($arrayProducts);
        $I->comment('После нажатия на кнопку "Показать еще" в каталоге стало товаров: ' . $sumProducts2);

        // Если количество одинаковое, то кидаем ошибку
        if ($sumProducts1 == $sumProducts2) {
            $I->fail('После нажатия на кнопку "Показать еще" кол-во товаров такое же, как до нажатия на кнопку');
        }
    }


    public function checkFavAndCompBtns(AcceptanceTester $I) {
        $I->wantTo('Проверка кнопок "Добавить в избранное" и "Добавить в сравнение" в чанке');

        // Существует ли хотя бы один чанк?
        $itemSelector1 = $this->itemSelector . '[1]';
        $I->seeElement($itemSelector1);

        // Получаем id товара. Этот id будет записываться в куки
        $id = $I->grabValueFrom($itemSelector1 . '//input[@name="id"]');
        if (empty($id)) {
            $I->fail('Не удалось получить id первого товара');
        }

        // Определяем переменные для цикла
        $keys = [
            'fav' => 'избранное',
            'comp' => 'сравнение'
        ];

        // Поскольку действия для проверки кнопок добавления в избранное и сравнение одинаковые, делаем их в цикле
        foreach ($keys as $k => $val) {
            $I->comment('Проверка кнопки "Добавить в ' . $val . '"');

            // Пробуем добавить товар
            $I->click($itemSelector1 . '//span[contains(@class, "listing__products-item-btn-' . $k . '")]');

            // Смотрим, изменился ли класс
            $I->seeElement($itemSelector1 . '//span[contains(@class, "listing__products-item-btn-' . $k . '") and contains(@class, "active")]');

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
            if ($I->grabTextFrom('//span[contains(@class, "header__' . $k . '-value")]') == 0) {
                $I->fail('Не изменилось кол-во товара на кнопке в шапке');
            }

            // Попробуем удалить товар из избранного
            $I->click($itemSelector1 . '//*[contains(@class, "listing__products-item-btn-' . $k . '")]');

            // Смотрим, изменился ли класс
            $I->dontSeeElement($itemSelector1 . '//*[contains(@class, "listing__products-item-btn-' . $k . '") and contains(@class, "active")]');

            // Проверяем куки
            if (!empty($I->grabCookie($k . 'Ids'))) {
                $I->fail('Не удалилась куки при щелчке по кнопке для удаления товара в ' . $val);
            }
        }
    }


    private function clickToBtnMore(AcceptanceTester $I) {
        // Проверяем кнопку "Показать еще"
        $I->seeElement($this->btnMoreSelector);
        // Не знаю, почему, но без скролла не срабатывает клик
        $I->scrollTo($this->btnMoreSelector, 0, 0);
        $I->click($this->btnMoreSelector);
        // Подождем загрузку новых карточек. Сначала ждем, когда начнется AJAX-запрос. Потом ждем, когда он закончится. Подробности здесь: https://github.com/Codeception/Codeception/issues/5607#issuecomment-515060739
        $I->waitForJS("return $.active > 0;", 5);
        $I->waitForJS("return $.active == 0;", 10);
    }


    private function addAndChangeToBasketFunc(AcceptanceTester $I, $itemSelector, $val) {
        // Основные переменные
        $itemAddSelector = $itemSelector . $this->addSelector;
        $itemChangeSelector = $itemSelector . $this->changeSelector;
        $itemAddBtnSelector = $itemAddSelector . $this->addBtnSelector;

        // Попробуем увеличить кол-во товара для добавления в корзину
        for ($i = 0; $i < $val; $i++) {
            $I->click($itemAddSelector . $this->btnPlusSelector);
        }
        // Проверяем
        $I->seeInField($itemAddSelector . $this->amountSelector, strval($val + 1));

        // Попробуем уменьшить кол-во товара для добавления в корзину
        $I->click($itemAddSelector . $this->btnMinusSelector);
        // Проверяем
        $I->seeInField($itemAddSelector . $this->amountSelector, strval($val));

        // Добавляем
        $I->click($itemAddBtnSelector);
        // После добавления должна измениться кнопка. Проверяем это
        $I->dontSeeElement($itemAddBtnSelector);

        // Попробуем удалить товар из корзины за счет изменения количества до нуля
        for ($i = 0; $i < $val; $i++) {
            $I->click($itemChangeSelector . $this->btnMinusSelector);
        }
        // После удаления должна измениться кнопка. Проверяем это
        $I->seeElement($itemAddBtnSelector);

        // Снова добавляем товар в корзину. Потом будем проверять весь код на другом товаре. Не перебьют ли изменения другого товара первый товар?
        // Хотелось бы протестировать изменение $this->amountSelector. Но там JS, который мешает Codeception правильно заполнить это поле. Поэтому снова через плюсики
        for ($i = 0; $i < $val; $i++) {
            $I->click($itemAddSelector . $this->btnPlusSelector);
        }
        $I->click($itemAddBtnSelector);
    }


    public function checkAddAndChangeToBasket(AcceptanceTester $I) {
        $I->wantTo('Проверка добавления и изменения товара в корзину');

        // Установка основных переменных
        // Число товара, которое будет добавлено в корзину
        $rand1 = rand(4, 9);
        // Число второго товара, которое будет добавлено в корзину
        do {
            $rand2 = rand(4, 9);
        } while ($rand2 === $rand1);

        // Работа с товаром 1
        $item1 = $this->itemSelector . '[1]';
        $this->addAndChangeToBasketFunc($I, $item1, $rand1);

        // Посчитаем количество товаров. На момент написания кода их 42. Но, возможно, потом это значение изменится. Если так, то нужно будет поменять меньше кода
        $sumProductsPlusOne = count($I->grabMultiple($this->itemsCssSelector)) + 1;

        // Проверка товара, которого пока нет на странице. Для этого надо кликнуть по кнопке "Показать еще"
        $this->clickToBtnMore($I);

        // Работа с товаром 2
        $item2 = $this->itemSelector . '[' . $sumProductsPlusOne . ']';
        $this->addAndChangeToBasketFunc($I, $item2, $rand2);

        // Получаем id и кол-во наших товаров. Эта информация нужна, чтобы проверить товары на странице корзины
        $arrayForLoop = [
            '1' => [
                'id' => $I->grabValueFrom($item1 . '//input[@name="id"]'),
                'amount' => $rand1 + 1
            ],
            '2' => [
                'id' => $I->grabValueFrom($item2 . '//input[@name="id"]'),
                'amount' => $rand2 + 1
            ]
        ];

        // Удалось ли получить id?
        foreach ($arrayForLoop as $key => $val) {
            if (empty($val['id'])) {
                $I->fail('Не удалось получить id для товара ' . $key);
            }
        }

        // Проверка на странице корзины
        // Перед изменением страницы лучше чуть-чуть подождать
        $I->wait(2);
        $I->amOnPage('/cart/');

        foreach ($arrayForLoop as $val) {
            // Откроем страницу корзины и посмотрим, действительно ли товары добавились. И в нужном ли количестве
            $basketItemSelector = '//tr[contains(@class, "cart-table__table-row_type_product")][@data-product-id="' . $val['id'] . '"]';
            $I->seeElement($basketItemSelector);
            $I->seeInField($basketItemSelector . '//input[contains(@class, "custom-counter__amount")]', strval($val['amount']));
        }

        // Возвращаемся обратно на страницу каталога. Был баг, когда я вызвал msProducts кешированным. Сначала все работало, а после перезагрузки страницы - нет. Проверим его
        $I->wait(2);
        $I->amOnPage('/catalog/');
        $this->clickToBtnMore($I);

        // Меняем кол-во товаров в корзине
        $I->click($item1 . $this->changeSelector . $this->btnMinusSelector);
        // Опытным путем я подобрал, что здесь нужен скролл, иначе иногда не устанавливается количество
        $I->scrollTo($item2);
        $I->click($item2 . $this->changeSelector . $this->btnMinusSelector);

        // Перезагружаем страницу
        $I->wait(2);
        $I->reloadPage();
        $this->clickToBtnMore($I);

        // Смотрим кол-во добавленных товаров
        $I->seeInField($item1 . $this->changeSelector . $this->amountSelector, strval($rand1));
        $I->seeInField($item2 . $this->changeSelector . $this->amountSelector, strval($rand2));
    }

}
