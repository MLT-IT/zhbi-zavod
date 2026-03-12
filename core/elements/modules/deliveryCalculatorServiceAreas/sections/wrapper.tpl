<a name="delivery-calculator"></a>
<section class="delivery-calculator">
  {*
  {set $key = 'yandex_apikey' | config}
  <script src="https://api-maps.yandex.ru/2.1/?apikey={$key}&lang=ru_RU" type="text/javascript"></script>
  *}
  <div class="wrapper container">
    <div class="delivery-calculator__map-wrapper js-delivery-calculator__map-wrapper">
      <div id="delivery-calculator-map" class="delivery-calculator__map js-delivery-calculator__map"></div>
    </div>
    <div class="delivery-calculator__form-block">
      <h2 class="delivery-calculator__form-title">Калькулятор доставки</h2>
      <form action="" method="post">
        <label class="delivery-calculator__form-address-wrap">
          <input name="address" type="text" placeholder="Адрес" class="js-delivery-calculator__form-address delivery-calculator__form-field">
          <span class="js-delivery-calculator__form-address-message delivery-calculator__form-address-message">Для расчета стоимости доставки введите адрес текстом или выберите на карте</span>
          <div class="js-delivery-calculator__form-address-dropdown delivery-calculator__form-address-dropdown">
          </div>
          <div class="delivery-calculator__form-indicator js-delivery-calculator__form-indicator"></div>
        </label>
        <div class="delivery-calculator__in-service js-delivery-calculator__in-service active">
          <div class="delivery-calculator__vehicle js-delivery-calculator__vehicle">
            <label><input checked type="radio" name="vehicle" data-value="car" value="Машиной">Машиной</label>
            <label><input type="radio" name="vehicle" data-value="handler" value="Манипулятором">Манипулятором</label>
          </div>
          <div class="delivery-calculator__weights-wrapper">
            <div class="delivery-calculator__weights cars js-delivery-calculator__weights active" data-vehicle="car">
              {set $fv = $_modx->config.file_version}
              {set $carItems = [
                ["icon2" => 'assets/template/img/deliveryCalculatorServiceAreas/sprite.svg?v='~$fv~'#w0_5t',
                "weight" => '0,5 - 1,5',
                'w' => '44',
                'h' => '19' ],
                ["icon2" => 'assets/template/img/deliveryCalculatorServiceAreas/sprite.svg?v='~$fv~'#w1_5t',
                "weight" => '2,5',
                'w' => '65',
                'h' => '26' ],
                ["icon2" => 'assets/template/img/deliveryCalculatorServiceAreas/sprite.svg?v='~$fv~'#w3_5t',
                "weight" => '3,5 - 5',
                'w' => '49',
                'h' => '25' ],
                ["icon2" => 'assets/template/img/deliveryCalculatorServiceAreas/sprite.svg?v='~$fv~'#w5t',
                "weight" => '10',
                'w' => '69',
                'h' => '23' ],
                ["icon2" => 'assets/template/img/deliveryCalculatorServiceAreas/sprite.svg?v='~$fv~'#w10t',
                "weight" => '20',
                'w' => '75',
                'h' => '24' ]
              ]}
              {foreach $carItems as $item index=$idx}
              <a href="#" data-value="{$item.weight}" class="{($idx == 0)?'active':''}">
                <div class="delivery-calculator__weights-img-wrap">
                  <svg width="{$item.w}" height="{$item.h}" class="delivery-calculator__weights-svg"><use href="{$item.icon2}"></svg>
                </div>
                <div class="delivery-calculator__weights-caption">{$item.weight}&nbsp;т</div>
              </a>
              {/foreach}
            </div>
            <div class="delivery-calculator__weights handlers js-delivery-calculator__weights delivery-calculator__weights--radio" data-vehicle="handler">
              {set $fv = $_modx->config.file_version}
              {set $items = [
                ["icon2" => 'assets/template/img/deliveryCalculatorServiceAreas/manip1.png',
                "weight" => '5'
                'w' => '44'
                'h' => '44' ],
                ["icon" => ''
                'icon2' => 'assets/template/img/deliveryCalculatorServiceAreas/manip1.png',
                "weight" => '10'
                'w' => '44'
                'h' => '44' ],
                ['icon2' => 'assets/template/img/deliveryCalculatorServiceAreas/manip1.png',
                "weight" => '20'
                'w' => '44'
                'h' => '44' ],
              ]}
              {foreach $items as $item index=$idx}
              <a href="#" data-value="{$item.weight}" class="{($idx == 0)?'active':''}">
                <div class="delivery-calculator__weights-img-wrap">
                  {*<img class="delivery-calculator__weights-img" src="{$item.icon2}">*}
                  <div class="delivery-calculator__weights-mask" style="mask-image: url('{$item.icon2}')"></div>
                  {*<svg width="{$item.w}" height="{$item.h}" class="delivery-calculator__weights-svg"><use href="{$item.icon2}"></svg>*}
                </div>
                <div class="delivery-calculator__weights-caption">{$item.weight}&nbsp;т</div>
              </a>
              {/foreach}
            </div>
          </div>
          <div class="delivery-calculator__price-wrapper js-delivery-calculator__price-wrapper">
            {set $items = [
              ['weight' => '0,5 - 1,5','vehicle' => 'car'],
              ['weight' => '2,5', 'vehicle' => 'car'],
              ['weight' => '3,5 - 5', 'vehicle' => 'car'],
              ['weight' => '10', 'vehicle' => 'car'],
              ['weight' => '20', 'vehicle' => 'car'],
              ['vehicle' => 'handler', 'weight' => '5'],
              ['vehicle' => 'handler', 'weight' => '10'],
              ['vehicle' => 'handler', 'weight' => '20']
            ]}
            {foreach $items as $item index=$idx}
              <div class="delivery-calculator__price js-delivery-calculator__price {($idx == 0)?'active':''}" data-weight = "{$item.weight}" data-vehicle="{$item.vehicle}">
                <div class="delivery-calculator__price-dur js-delivery-calculator__price-dur">
                  <p class="delivery-calculator__price-title">Доставка в установленный день</p>
                  <p class="delivery-calculator__price-value js-delivery-calculator__price-value">1&nbsp;379&nbsp;₽</p>
                </div>
                {*<div class="delivery-calculator__price-exact js-delivery-calculator__price-exact">
                  <p class="delivery-calculator__price-title">Доставка в точное время</p>
                  <p class="delivery-calculator__price-value js-delivery-calculator__price-value">2&nbsp;889&nbsp;₽</p>
                </div>*}
              </div>
            {/foreach}
          </div>
        </div>
        <div class="delivery-calculator__out-of-service js-delivery-calculator__out-of-service">
          Адрес за пределами области обслуживания
        </div>
        <a href="#" class="delivery-calculator__btn" onclick="modals.events.open('modal-callback');return false" >Задать вопрос по доставке</a>
      </form>
    </div>
  </div>
</section>