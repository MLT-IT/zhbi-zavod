import Catalog from "./Catalog.js";

export default function init() {
  try {
    new Catalog().init();
  } catch (e) {
    console.error(`Ошибка модуля Catalog: ${e}`);
  }
}
