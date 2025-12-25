export default function initOpenedOptions() {
  const store = {};

  window.showOptions = (product_idx) => {
    if (!store[product_idx])
      store[product_idx] = {
        product_card: null,
        next_product_card: null,
      };

    const product_card =
      store[product_idx].product_card ??
      document.querySelector(`[data-product_idx="${product_idx}"]`);

    const next_product_card =
      store[product_idx].next_product_card ??
      (product_idx % 2 === 0
        ? product_card.previousElementSibling
        : product_card.nextElementSibling);

    if (
      !store[product_idx].product_card ||
      !store[product_idx].next_product_card
    ) {
      store[product_idx].product_card = product_card;
      store[product_idx].next_product_card = next_product_card;
    }

    product_card.classList.toggle("opened");
    next_product_card.classList.toggle("opened");
  };
}
