export default function mailChange(toMail = "stroym") {
  const TIMEOUT = 0;
  const links = document.querySelectorAll('a[href*="mailto"]');
  const fixEmail = (email) => {
    const pattern = /(mailto:)?\s?(info|mail)(@.+)/;
    return email.replace(pattern, toMail + "$3");
  };

  links.forEach((n) => {
    const oldMail = n.href;
    const newMail = fixEmail(oldMail);
    n.innerHTML = newMail;
    n.href = `mailto:${newMail}`;
  });

  // На странице "Контакты" особая верстка, для нее нужен особый код
  const contact = document.querySelector(".contact_type_mail");
  let contactValue;
  if (contact) {
    contactValue = contact.querySelector(".contact__value");
    if (contactValue) {
      contactValue.innerHTML = fixEmail(contactValue.innerHTML);
    }
  }
}
