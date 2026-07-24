import "../scss/main.scss";
console.log('here!');
// Библиотеки
import GLightbox from "glightbox";
import "glightbox/dist/css/glightbox.min.css";

import "./modules/header-scroll.js"
import "./modules/hoveredHandle.js";
import iniSwipers from "./modules/swipers.js";
import initNotifications from "./modules/notifications.js";
import initOpened from "./modules/opened.js";
import initDistrictsMap from "./modules/district-map/init.js";
import SearchByWords from "./modules/search-by-words.js";
import fetchItObserve from "./modules/fetchit-observe.js";
import initPolicySoftCheck from "./modules/policy-soft-check.js";
import initInputMask from "./modules/input-mask.js";
import initComparison from "./modules/comparison.js";
import initOpenedOptions from "./modules/opened-options.js";
import initCopyToClipboard from "./modules/copy-to-clipboard.js";

import initCatalog from "../../core/elements/modules/catalog-menu/js/main.js";
import initModals from "../../core/elements/modules/modals/js/main.js";

import initCart from "../../core/elements/modules/cart/frontend/js/main.js";
import "../../core/elements/modules/cart/frontend/js/cart-calc.js";
import "../../core/elements/modules/similarsamples/js/main.js"

import initProductSelections from "../../core/elements/modules/store-product-selection/js/main.js";
import initProductCart from "../../core/elements/modules/product-cards/js/main.js";
import initSplitUnit from "../../core/elements/modules/split-unit/js/main.js";
import initCustomSelect from "../../core/elements/modules/custom-select/main.js";
import "../../core/elements/modules/menu/uteplitel/scripts/main.js";
import FastSearch from "../../core/elements/modules/fast-search/js/FastSearch.js";
import AdditionalFieldsCallbackForm from "../../core/elements/modules/additional-fields-callback-form/scripts/main.js"
import testAutodeploy from "./modules/test-autodeploy.js";
import initFetchImageProduct from "./modules/fetch-image-product.js";
import { DeliveryCalculatorServiceAreas } from '../../core/elements/modules/deliveryCalculatorServiceAreas/js/index';

document.addEventListener("DOMContentLoaded", function () {
  try {
    let search_by_words = new SearchByWords();
    search_by_words.init();
  } catch { }

  try {
    new AdditionalFieldsCallbackForm();
  } catch (error) {
    console.error(`Ошибка модуля AdditionalFieldsCallbackForm`, error);
  }
  
  try{
    const dc = new DeliveryCalculatorServiceAreas();
    dc.run();
  }catch(t){
      console.error(t);
  }

  initCatalog();
  initModals();
  iniSwipers();
  initNotifications();
  initCart();
  initProductSelections();
  initProductCart();
  initOpened();
  initSplitUnit();
  initCustomSelect();
  initDistrictsMap();
  initPolicySoftCheck();
  fetchItObserve();
  initInputMask();
  initComparison();
  initOpenedOptions();
  initCopyToClipboard();
  testAutodeploy();
  initFetchImageProduct()

  let fast_search = new FastSearch();
  fast_search.init();

  // Библиотеки
  GLightbox({
    touchNavigation: true,
    loop: true,
  });
});
