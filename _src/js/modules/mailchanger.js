export default function mailChange() {
    const TIMEOUT = 0;
    let links = document.querySelectorAll('a[href*="mailto"]');

    links.forEach(n => {
        n.innerHTML = n.innerHTML.replace('mail@' + document.location.host, 'stroym@' + document.location.host);
        n.href = n.href.replace('mail@' + document.location.host, 'stroym@' + document.location.host);
    });

    // На странице "Контакты" особая верстка, для нее нужен особый код
    let contact = document.querySelector('.contact_type_mail');
    let contactValue;
    if (contact) {
        contactValue = contact.querySelector('.contact__value');
    }
    if (contactValue && contact) {
        contactValue.innerHTML = contactValue.innerHTML.replace('mail@' + document.location.host, 'stroym@' + document.location.host);
    }
}
