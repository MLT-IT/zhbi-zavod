import IMask from "imask";

export default function initInputMask() {
  let phones = document.querySelectorAll('[name="phone"]');
  phones.forEach((phone) => {
    IMask(phone, {
      mask: "+{7} (000) 000-00-00{0}",
      lazy: false
    });
  });
}
