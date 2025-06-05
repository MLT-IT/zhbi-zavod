<section class="delivery-calculator">
  {* 4ec1b4a7-4a67-4165-88f3-589a9408ec91 - для оптстройшопа, для калькулятора *}
  {set $key = 'yandex_apikey' | config}
  <script src="https://api-maps.yandex.ru/2.1/?apikey={$key}&lang=ru_RU" type="text/javascript"></script>
  <div class="delivery-calculator__container">
    <div class="delivery-calculator__map-wrapper js-delivery-calculator__map-wrapper">
      <div id="delivery-calculator-map" class="delivery-calculator__map js-delivery-calculator__map"></div>
    </div>
    <div class="delivery-calculator__form-block">
      <h2 class="delivery-calculator__form-title">Калькулятор доставки</h2>
      <form action="" method="post">
        <label>
          <input type="text" placeholder="Адрес" class="js-delivery-calculator__form-address delivery-calculator__form-field">
          <span class="js-delivery-calculator__form-address-message delivery-calculator__form-address-message">Для расчета стоимости доставки введите адрес текстом или выберите на карте</span>
        </label>
        <div class="delivery-calculator__in-service js-delivery-calculator__in-service active">
          <div class="delivery-calculator__vehicle js-delivery-calculator__vehicle">
            <label><input checked type="radio" name="vehicle" data-value="car" value="Машиной">Машиной</label>
            <label><input type="radio" name="vehicle" data-value="handler" value="Манипулятором">Манипулятором</label>
          </div>
          <div class="delivery-calculator__weights-wrapper">
            <div class="delivery-calculator__weights js-delivery-calculator__weights active">
              {set $fv = $_modx->config.file_version}
              {set $items = [
                ["icon2" => 'assets/template/img/deliveryCalculatorServiceAreas/sprite.svg?v='~$fv~'#w0_5t',
                "weight" => '0,5'
                'w' => '44'
                'h' => '19' ],
                ["icon" => ''
                'icon2' => 'assets/template/img/deliveryCalculatorServiceAreas/sprite.svg?v='~$fv~'#w1_5t',
                "weight" => '1,5'
                'w' => '65'
                'h' => '26' ],
                ["icon2" => 'assets/template/img/deliveryCalculatorServiceAreas/sprite.svg?v='~$fv~'#w3_5t',
                "weight" => '3,5'
                'w' => '49'
                'h' => '25' ],
                ["icon2" => 'assets/template/img/deliveryCalculatorServiceAreas/sprite.svg?v='~$fv~'#w5t',
                "weight" => '5'
                'w' => '69'
                'h' => '23' ],
                ["icon2" => 'assets/template/img/deliveryCalculatorServiceAreas/sprite.svg?v='~$fv~'#w10t',
                "weight" => '10'
                'w' => '75'
                'h' => '24' ]
              ]}
              {foreach $items as $item index=$idx}
              <a href="#" data-value="{$item.weight}" class="{($idx == 0)?'active':''}">
                <div class="delivery-calculator__weights-img-wrap">
                  <svg width="{$item.w}" height="{$item.h}" class="delivery-calculator__weights-svg"><use href="{$item.icon2}"></svg>
                </div>
                <div class="delivery-calculator__weights-caption">{$item.weight}&nbsp;т</div>
              </a>
              {/foreach}
            </div>
          </div>
          <div class="delivery-calculator__price-wrapper js-delivery-calculator__price-wrapper">
            {set $items = [
              ['weight' => '0,5'
              'vehicle' => 'car'],
              ['weight' => '1,5'
              'vehicle' => 'car'],
              ['weight' => '3,5'
              'vehicle' => 'car'],
              ['weight' => '5'
              'vehicle' => 'car'],
              ['weight' => '10'
              'vehicle' => 'car']
              ['vehicle' => 'handler']
            ]}
            {foreach $items as $item index=$idx}
              <div class="delivery-calculator__price js-delivery-calculator__price {($idx == 0)?'active':''}" data-weight = "{$item.weight}" data-vehicle="{$item.vehicle}">
                <div class="delivery-calculator__price-dur js-delivery-calculator__price-dur">
                  <p class="delivery-calculator__price-title">Доставка в установленный день</p>
                  <p class="delivery-calculator__price-value js-delivery-calculator__price-value">1&nbsp;379&nbsp;₽</p>
                </div>
                <div class="delivery-calculator__price-exact js-delivery-calculator__price-exact">
                  <p class="delivery-calculator__price-title">Доставка в точное время</p>
                  <p class="delivery-calculator__price-value js-delivery-calculator__price-value">2&nbsp;889&nbsp;₽</p>
                </div>
              </div>
            {/foreach}
          </div>
        </div>
        <div class="delivery-calculator__out-of-service js-delivery-calculator__out-of-service">
          Адрес за пределами области обслуживания
        </div>
        <a href="#callback" data-fancybox="" class="delivery-calculator__btn">Задать вопрос по доставке</a>
      </form>
    </div>
  </div>
</section>