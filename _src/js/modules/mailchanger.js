export default function mailChange () {
    const TIMEOUT = 0;
    let links = document.querySelectorAll('a[href*="mailto"]');

    links.forEach(n => {
        n.innerHTML = n.innerHTML.replace('mail@' + document.location.host, 'stroym@' + document.location.host);
        n.href = n.href.replace('mail@' + document.location.host, 'stroym@' + document.location.host);
    });
}
