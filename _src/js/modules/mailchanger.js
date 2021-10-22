export default function mailChange () {
    const TIMEOUT = 0;
    let links = document.querySelectorAll('a[href*="mailto"]');
    setTimeout(() => {
        links.forEach(n => {
            n.innerText = n.innerText.replace('mail@www-knauf.ru', 'info@www-knauf.ru');
            n.innerText = n.innerText.replace('mail@www-rockwool.ru', 'info@www-rockwool.ru');
            n.innerText = n.innerText.replace('mail@www-tn.ru', 'info@www-tn.ru');
            n.innerText = n.innerText.replace('mail@www-penoplex.ru', 'info@www-penoplex.ru');
            n.innerText = n.innerText.replace('mail@www-isover.ru', 'info@www-isover.ru');
            n.innerText = n.innerText.replace('mail@www-paroc.ru', 'info@www-paroc.ru');
            n.innerText = n.innerText.replace('mail@www-ursa.ru', 'info@www-ursa.ru');

            n.href = n.href.replace('mail@www-knauf.ru', 'info@www-knauf.ru');
            n.href = n.href.replace('mail@www-rockwool.ru', 'info@www-rockwool.ru');
            n.href = n.href.replace('mail@www-tn.ru', 'info@www-tn.ru');
            n.href = n.href.replace('mail@www-penoplex.ru', 'info@www-penoplex.ru');
            n.href = n.href.replace('mail@www-isover.ru', 'info@www-isover.ru');
            n.href = n.href.replace('mail@www-paroc.ru', 'info@www-paroc.ru');
            n.href = n.href.replace('mail@www-ursa.ru', 'info@www-ursa.ru');
        })
    }, TIMEOUT)
}
