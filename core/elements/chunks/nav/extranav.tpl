<nav class="header__extranav extranav">
  {if $_modx->context.key == 'krovelnyjstroymarket'}
  <li class="extranav__item"><span class="extranav__link">Сервисы расчета</a>
    <ul class="extranav__subnav">
          {'pdoResources' | snippet : [
            'parents' => '230724',
            'tpl' => '@INLINE <li class="extranav__item"><a class="extranav__link" href="{$uri}">{$menutitle}</a></li>'
          ]}
    </ul>
  <li class="extranav__item"><a class="extranav__link" href="/dostavka-i-oplata/">Доставка</a>
  <li class="extranav__item"><a class="extranav__link" href="/contacts/">Контакты</a>
  {elseif $_modx->context.key == 'plitnye'}
    <li class="extranav__item"><a class="extranav__link" href="/contacts/">Контакты</a>
    <li class="extranav__item"><a class="extranav__link" href="/o-kompanii/">О компании</a>
    <li class="extranav__item"><a class="extranav__link" href="/dostavka-i-oplata/">Доставка</a>
    <li class="extranav__item"><a class="extranav__link" href="/otzyvy/">Отзывы</a>
  {/if}
</nav>
