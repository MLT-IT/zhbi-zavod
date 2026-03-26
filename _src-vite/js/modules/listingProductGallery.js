/**
 * При наведении на карточку отобразит второую картинку товара еесли ест ьнеобходимые аттрибуты
 * data-product-card - на карточку товара
 * data-product-image - на картинку товара
 * data-product-images - на картинку товара [через запятую его картинки]
 */
function listingProductGallery() {
  const product_cards = document.querySelectorAll(
    "[data-product-card]:not(.init-gallery)"
  );

  if (product_cards.length) {
    product_cards.forEach((product_card) => {
      product_card.classList.add("init-gallery");
      const product_image = product_card.querySelector("[data-product-image]");

      if (product_image) {
        const product_images_dataset = product_image.dataset.productImages;

        if (product_images_dataset) {
          const product_images = product_images_dataset.split(",");
          if (product_images.length == 1) return;

          let original_image;
          product_card.addEventListener("mouseenter", (e) => {
            original_image = product_image.src;
            product_image.src = product_images[1];
          });

          product_card.addEventListener("mouseleave", (e) => {
            product_image.src = original_image;
            console.log("leave");
          });
        }
      }
    });
  }
}
listingProductGallery();

$(document).on("mse2_load", function (e, data) {
  listingProductGallery();
});
