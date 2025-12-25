import Modals from "./Modals";

export default function init() {
  try {
    window.modals = new Modals();
  } catch (e) {
    console.error(`Ошибка модуля Modals: ${e}`);
  }
}
