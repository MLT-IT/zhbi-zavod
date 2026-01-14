{set $remains = '@FILE snippets/random.php' | snippet : [
    'id' => $_modx->resource.id,
    'begin' => 100
    'end'=> 200
]}

<div class="product-page__inform">
  <div class="product-page__inform-section">
    {*include "file:modules/warehouses/sections/warehouse-remains.tpl"*}

    <div class="d-flex gap-8 mb-8">
      {include "file:chunks/rating-stars.tpl" active_stars=4}
      <a class="link-dashed" href="{$_modx->makeUrl('reviews_id'|config)}">5 отзывов</a>
    </div>

    {*
        <a class="yandex-rating" href="{$_modx->makeUrl('reviews_id'|config)}" target="_blank">
          <img src="/assets/template/images/other/yandex-badge.png" alt="Yandex.Market" />
        </a>
    *}
    
    <ul class="product-page__inform-list">
      <li class="tooltip-wrapper">
        <svg xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg" width="3.96875mm" height="3.96875mm" viewBox="0 0 3.96875 3.96875" version="1.1" id="svg5"> <defs id="defs1497"> <clipPath id="clip0_139_110"> <rect width="15" height="15" fill="#ffffff" id="rect1458" x="0" y="0"/> </clipPath> </defs> <g id="g1476"> <path d="M 2.9753454,1.3320024 C 2.9142531,1.267587 2.8123885,1.2647507 2.7478831,1.3259938 L 1.7207256,2.3001129 1.230802,1.7970976 c -0.06205,-0.063664 -0.1637877,-0.065058 -0.2275047,-0.003 -0.063661,0.061997 -0.065003,0.1638432 -0.00301,0.2275072 l 0.6006783,0.616712 c 0.031477,0.032335 0.073313,0.048633 0.1152551,0.048633 0.039796,0 0.079592,-0.014684 0.1107546,-0.044127 l 1.142364,-1.0833607 c 0.064453,-0.061145 0.067178,-0.1629913 0.00601,-0.2274597 z" fill="#3c3c3b" id="path1452" style="stroke-width:0.264583"/> <path d="M 1.984375,0 C 0.8901774,0 0,0.89017738 0,1.984375 0,3.0785594 0.8901774,3.96875 1.984375,3.96875 3.0785593,3.96875 3.9687499,3.0785594 3.9687499,1.984375 3.9687499,0.89017738 3.0785593,0 1.984375,0 Z m 0,3.6469637 c -0.9167283,0 -1.6625888,-0.7458075 -1.6625888,-1.6625887 0,-0.9167283 0.7458552,-1.66258875 1.6625888,-1.66258875 0.9167812,0 1.6625887,0.74585515 1.6625887,1.66258875 0,0.9167812 -0.7458075,1.6625887 -1.6625887,1.6625887 z" fill="#3c3c3b" id="path1454" style="stroke-width:0.264583"/> </g> </svg>
        <span>В наличии {$remains} шт</span>

        {include "file:chunks/tooltip.tpl" text="В среднем на нашем предприятии производится от 100 до 500 ЖБИ изделий в день."}
      </li>
      <li class="tooltip-wrapper">
        <svg xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg" width="3.748265mm" height="3.9687486mm" viewBox="0 0 3.7482651 3.9687486" version="1.1" id="svg5"> <defs id="defs1939"> <clipPath id="clip0_139_110"> <rect width="15" height="15" fill="#ffffff" id="rect1458" x="0" y="0"/> </clipPath> <clipPath id="clip0_139_96"> <rect width="18" height="18" fill="#ffffff" id="rect1593" x="0" y="0"/> </clipPath> </defs> <path d="M 3.6412223,0.30973845 C 3.6193677,0.29712047 3.0929527,0 1.8741258,0 0.65534381,0 0.12885711,0.29713105 0.1070655,0.30974903 0.0376113,0.34999213 -0.00325559,0.42285577 2.0338647e-4,0.49996857 0.00124139,0.52268257 0.02795669,1.0651344 0.25204764,1.7563478 0.38410885,2.1637003 0.55786337,2.5389668 0.76853521,2.8720507 1.0345923,3.292606 1.3603975,3.646592 1.7369975,3.9241135 c 0.040317,0.029739 0.088683,0.044635 0.1371389,0.044635 0.048498,0 0.096843,-0.01487 0.1371388,-0.044635 C 2.3878566,3.646592 2.7136725,3.292606 2.979711,2.8720507 3.1903458,2.5389668 3.3641506,2.1637003 3.4962042,1.7563478 3.7203062,1.0651344 3.7470292,0.52268307 3.748061,0.49996857 3.7515271,0.42285577 3.7106225,0.34998417 3.6412223,0.30973845 Z M 2.7045444,1.3390602 1.7159076,2.2769843 c -0.028556,0.027329 -0.066596,0.042233 -0.1069314,0.042233 -0.04046,0 -0.078478,-0.014904 -0.1072303,-0.042233 L 1.0437574,1.841578 c -0.0589544,-0.05601 -0.0589544,-0.147013 0,-0.20302 l 0.088194,-0.083706 c 0.028699,-0.026932 0.066739,-0.041838 0.1071271,-0.041838 0.040378,0 0.078224,0.01478 0.1067409,0.041838 L 1.6089048,1.803658 2.401488,1.0515719 c 0.028628,-0.027249 0.066574,-0.042233 0.1070557,-0.042233 0.04046,0 0.078428,0.014983 0.1069128,0.042233 l 0.089035,0.084429 c 0.058976,0.055981 0.058976,0.1470502 5.29e-5,0.2030593 z" fill="#3c3c3b" id="path1899" style="stroke-width:0.264583"/> </svg>
        <span>Контроль качества на каждом этапе</span>

        {include "file:chunks/tooltip.tpl" text="Строгое соблюдение пропорций ЖБИ изделий на предприятии является для нас очень важным аспектом."}
      </li>
      <li>
        <svg xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg" width="4.7624998mm" height="3.6789334mm" viewBox="0 0 4.7624998 3.6789334" version="1.1" id="svg5"> <defs id="defs1634"> <clipPath id="clip0_139_110"> <rect width="15" height="15" fill="#ffffff" id="rect1458" x="0" y="0"/> </clipPath> <clipPath id="clip0_139_96"> <rect width="18" height="18" fill="#ffffff" id="rect1593" x="0" y="0"/> </clipPath> </defs> <path d="M 0.8045027,1.1418385 H 0.2575586 v 0.2790534 h 0.5469441 z" fill="#3c3c3b" id="path1583" style="stroke-width:0.264583"/> <path d="M 0.8045027,2.2580415 H 0.2575586 v 0.279056 h 0.5469441 z" fill="#3c3c3b" id="path1585" style="stroke-width:0.264583"/> <path d="M 0.8045079,1.6999453 H 0 V 1.978996 h 0.8045079 z" fill="#3c3c3b" id="path1587" style="stroke-width:0.264583"/> <path d="M 2.9230373,0 C 1.9071166,0 1.0835587,0.823558 1.0835587,1.839468 c 0,1.0159233 0.8235579,1.8394654 1.8394786,1.8394654 1.0158941,0 1.8394626,-0.8235421 1.8394626,-1.8394654 C 4.7624999,0.823558 3.9389314,0 2.9230373,0 Z M 3.5031097,2.594909 2.7299973,2.0680601 V 0.9391968 h 0.279056 v 0.9813369 l 0.6512189,0.4437645 z" fill="#3c3c3b" id="path1589" style="stroke-width:0.264583"/> </svg>
        <span>Производство от <a href="{$_modx->getPlaceholder('makeurls.dostavka')}" class="highlight">1 дня</a></span>
      </li>
    </ul>
  </div>

  {*include "file:modules/similar-products/chunks/similar-grid.tpl"*}

  <div class="product-page__inform-section">
    <div class="product-page__inform-price">
      {include "file:templates/product/inform/price.tpl"}
    </div>
  </div>

  {include "file:modules/cart/frontend/chunks/cart-controls-big.tpl"}

  <button
    class="product-page__inform-btn-buy btn btn-bordered"
    onclick="modals.events.open('modal-callback')"
  >
    Купить в 1 клик
  </button>
</div>
