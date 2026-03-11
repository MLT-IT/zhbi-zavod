import IMask from "imask";

export default function initInputMask() {
  let phones = document.querySelectorAll('[name="phone"]');

  phones.forEach((phone) => {
    phone.placeholder = "+7 (___) ___-__-__";

    IMask(phone, {
      mask: "+{7} (000) 000-00-00",
      lazy: true
    });
  });
}