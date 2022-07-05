export default function addShadowMap(selector) {
    let elems = document.querySelectorAll(selector);

    if (!elems) {
        return;
    }

    elems.forEach(elemNode => {
        // Описание shadow
        let shadow = document.createElement('div');
        shadow.textContent = 'Нажмите для прокрутки';
        shadow.classList.add('map-scroll-cover')

        // Обработчик для shadow
        shadow.addEventListener('click', _ => {
            shadow.classList.add("hidden");
        });

        // Обработчик для elemNode
        elemNode.addEventListener('mouseleave', e => {
            shadow.classList.remove("hidden");
        });

        elemNode.append(shadow);
    });
}
