export default function mailChange(toMail = "stroym") {
  const TIMEOUT = 0;
  const links = document.querySelectorAll('a[href*="mailto"]');
  const getNewEmail = (email) => {
    const pattern = /(mailto:)\s?(.+)(@.+)/;
    return email.replace(pattern, toMail + "$3");
  };

  const replaceEmailInHtml = (input) =>{
    const re = /<(.+)>(.+)(@.+)<\/(.+)>/;
    return input.replace(re, "<$1>"+toMail+"$3</$4>")
  }

  links.forEach((n) => {
    const oldMail = n.href;
    const newMail = getNewEmail(oldMail);
    if(n.innerHTML.length > 2) n.innerHTML = newMail;
    n.href = `mailto:${newMail}`;
  });

  // На странице "Контакты" особая верстка, для нее нужен особый код
  const contact = document.querySelector(".contact_type_mail");
  let contactValue;
  if (contact) {
    contactValue = contact.querySelector(".contact__value");
    if (contactValue) {
      contactValue.innerHTML = `${replaceEmailInHtml(contactValue.innerHTML)}`;
    }
  }
}
