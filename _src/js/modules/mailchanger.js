export default function mailChange () {
    const TIMEOUT = 0;
    let links = document.querySelectorAll('a[href*="mailto"]');
    setTimeout(() => {
        links.forEach(n => {
            n.innerText = n.innerText.replace('mail@minvata-78.ru', 'tsk@minvata-78.ru');
            n.innerText = n.innerText.replace('mail@www-minvata.ru', 'tsk@www-minvata.ru');
            n.innerText = n.innerText.replace('mail@pro-minvata.ru', 'tsk@pro-minvata.ru');
            n.innerText = n.innerText.replace('mail@plity-epps.ru', 'tsk@plity-epps.ru');
            n.innerText = n.innerText.replace('mail@minvata-178.ru', 'tsk@minvata-178.ru');
            n.innerText = n.innerText.replace('mail@minvata-pro.ru', 'tsk@minvata-pro.ru');
            n.innerText = n.innerText.replace('mail@minvata-spb.ru', 'tsk@minvata-spb.ru');
            n.innerText = n.innerText.replace('mail@krovlyasp.ru', 'tsk@krovlyasp.ru');
            n.innerText = n.innerText.replace('mail@kirpich-m.ru', 'tsk@kirpich-m.ru');
            n.innerText = n.innerText.replace('mail@fasady-pro.ru', 'tsk@fasady-pro.ru');
            n.innerText = n.innerText.replace('mail@www-fasad.ru', 'tsk@www-fasad.ru');
            n.innerText = n.innerText.replace('mail@armatura-178.ru', 'tsk@armatura-178.ru');
            n.innerText = n.innerText.replace('mail@asfalt-prof.ru', 'tsk@asfalt-prof.ru');
            n.innerText = n.innerText.replace('mail@pilomat-pro', 'tsk@pilomat-pro');
            n.innerText = n.innerText.replace('mail@plitaosb.ru', 'tsk@plitaosb.ru');
            n.innerText = n.innerText.replace('mail@pro-fanera.ru', 'tsk@pro-fanera.ru');
            n.innerText = n.innerText.replace('mail@plity-mdvp.ru', 'tsk@plity-mdvp.ru');

            n.href = n.href.replace('mail@minvata-78.ru', 'tsk@minvata-78.ru');
            n.href = n.href.replace('mail@www-minvata.ru', 'tsk@www-minvata.ru');
            n.href = n.href.replace('mail@pro-minvata.ru', 'tsk@pro-minvata.ru');
            n.href = n.href.replace('mail@plity-epps.ru', 'tsk@plity-epps.ru');
            n.href = n.href.replace('mail@minvata-178.ru', 'tsk@minvata-178.ru');
            n.href = n.href.replace('mail@minvata-pro.ru', 'tsk@minvata-pro.ru');
            n.href = n.href.replace('mail@minvata-spb.ru', 'tsk@minvata-spb.ru');
            n.href = n.href.replace('mail@krovlyasp.ru', 'tsk@krovlyasp.ru');
            n.href = n.href.replace('mail@kirpich-m.ru', 'tsk@kirpich-m.ru');
            n.href = n.href.replace('mail@fasady-pro.ru', 'tsk@fasady-pro.ru');
            n.href = n.href.replace('mail@www-fasad.ru', 'tsk@www-fasad.ru');
            n.href = n.href.replace('mail@armatura-178.ru', 'tsk@armatura-178.ru');
            n.href = n.href.replace('mail@asfalt-prof.ru', 'tsk@asfalt-prof.ru');
            n.href = n.href.replace('mail@pilomat-pro', 'tsk@pilomat-pro');
            n.href = n.href.replace('mail@plitaosb.ru', 'tsk@plitaosb.ru');
            n.href = n.href.replace('mail@pro-fanera.ru', 'tsk@pro-fanera.ru');
            n.href = n.href.replace('mail@plity-mdvp.ru', 'tsk@plity-mdvp.ru');
        })
    }, TIMEOUT)
}
