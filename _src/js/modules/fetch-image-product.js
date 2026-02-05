/**
 * Скрипт при наведении на элемент получает его image
 * Работает с minishop2
 *
 * data-fetch-image-product="<PRODUCT_ID>" — элемент-триггер
 * data-fetch-image-insert="true" — <img>, куда вставлять картинку
 */

export default function initFetchImageProduct() {
  const triggers = document.querySelectorAll('[data-fetch-image-product]');
  const img = document.querySelector('[data-fetch-image-insert="true"]');
  const imageCache = {};

  if (!triggers.length || !img) return;

  // сохраняем исходную картинку
  const originalSrc = img.src;

  triggers.forEach(trigger => {
    trigger.addEventListener('mouseenter', () => {
      const productId = trigger.dataset.fetchImageProduct;
      if (!productId) return;

      // если есть в кеше
      if (imageCache[productId]) {
        img.src = imageCache[productId];
        return;
      }

      fetch('/api/index.php', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          action: 'get-product-image',
          id: productId,
        }),
      })
        .then(res => res.json())
        .then(data => {
          if (data?.image) {
            imageCache[productId] = data.image;
            img.src = data.image;
          }
        })
        .catch(err => {
          console.error('Ошибка загрузки изображения товара:', err);
        });
    });
  });

  triggers[0]?.parentNode.addEventListener('mouseleave', () => {
    // если курсор не над другим триггером — вернуть исходное изображение
    const isHoverAnyTrigger = Array.from(triggers).some(el =>
      el.matches(':hover')
    );

    if (!isHoverAnyTrigger) {
      img.src = originalSrc;
    }
  });
}
