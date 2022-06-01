export default function mailChange () {
    const TIMEOUT = 0;
    let links = document.querySelectorAll('a[href*="mailto"]');
    setTimeout(() => {
        links.forEach(n => {
            n.innerText = n.innerText.replace('mail@minvata-78.ru', 'info@minvata-78.ru');
            n.innerText = n.innerText.replace('mail@www-minvata.ru', 'info@www-minvata.ru');
            n.innerText = n.innerText.replace('mail@pro-minvata.ru', 'info@pro-minvata.ru');
            n.innerText = n.innerText.replace('mail@plity-epps.ru', 'info@plity-epps.ru');
            n.innerText = n.innerText.replace('mail@minvata-178.ru', 'info@minvata-178.ru');
            n.innerText = n.innerText.replace('mail@minvata-pro.ru', 'info@minvata-pro.ru');
            n.innerText = n.innerText.replace('mail@minvata-spb.ru', 'info@minvata-spb.ru');
            n.innerText = n.innerText.replace('mail@krovlyasp.ru', 'info@krovlyasp.ru');
            n.innerText = n.innerText.replace('mail@kirpich-m.ru', 'info@kirpich-m.ru');
            n.innerText = n.innerText.replace('mail@fasady-pro.ru', 'info@fasady-pro.ru');
            n.innerText = n.innerText.replace('mail@www-fasad.ru', 'info@www-fasad.ru');
            n.innerText = n.innerText.replace('mail@armatura-178.ru', 'info@armatura-178.ru');
            n.innerText = n.innerText.replace('mail@asfalt-prof.ru', 'info@asfalt-prof.ru');
            n.innerText = n.innerText.replace('mail@pilomat-pro', 'info@pilomat-pro');
            n.innerText = n.innerText.replace('mail@plitaosb.ru', 'info@plitaosb.ru');
            n.innerText = n.innerText.replace('mail@pro-fanera.ru', 'info@pro-fanera.ru');
            n.innerText = n.innerText.replace('mail@plity-mdvp.ru', 'info@plity-mdvp.ru');

            n.href = n.href.replace('mail@minvata-78.ru', 'info@minvata-78.ru');
            n.href = n.href.replace('mail@www-minvata.ru', 'info@www-minvata.ru');
            n.href = n.href.replace('mail@pro-minvata.ru', 'info@pro-minvata.ru');
            n.href = n.href.replace('mail@plity-epps.ru', 'info@plity-epps.ru');
            n.href = n.href.replace('mail@minvata-178.ru', 'info@minvata-178.ru');
            n.href = n.href.replace('mail@minvata-pro.ru', 'info@minvata-pro.ru');
            n.href = n.href.replace('mail@minvata-spb.ru', 'info@minvata-spb.ru');
            n.href = n.href.replace('mail@krovlyasp.ru', 'info@krovlyasp.ru');
            n.href = n.href.replace('mail@kirpich-m.ru', 'info@kirpich-m.ru');
            n.href = n.href.replace('mail@fasady-pro.ru', 'info@fasady-pro.ru');
            n.href = n.href.replace('mail@www-fasad.ru', 'info@www-fasad.ru');
            n.href = n.href.replace('mail@armatura-178.ru', 'info@armatura-178.ru');
            n.href = n.href.replace('mail@asfalt-prof.ru', 'info@asfalt-prof.ru');
            n.href = n.href.replace('mail@pilomat-pro', 'info@pilomat-pro');
            n.href = n.href.replace('mail@plitaosb.ru', 'info@plitaosb.ru');
            n.href = n.href.replace('mail@pro-fanera.ru', 'info@pro-fanera.ru');
            n.href = n.href.replace('mail@plity-mdvp.ru', 'info@plity-mdvp.ru');
        })
    }, TIMEOUT)
}
