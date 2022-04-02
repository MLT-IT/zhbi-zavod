<?php

class FirstCest
{

    public function frontpageWorks(AcceptanceTester $I)
    {
        $I->wantTo('Проверка отображения товаров на странице каталога');
        $I->amOnPage('/');
        $I->see('Home');
    }

}
