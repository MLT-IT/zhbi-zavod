export default function initComparison() {
  const items = Array.from(document.querySelectorAll("[data-comparison-key]"));

  if (items.length === 0) return;

  // Функция для подсветки элементов с одинаковым data-comparison-key
  function highlightSameKeyElements(key, highlight = true) {
    items.forEach((item) => {
      if (item.dataset.comparisonKey === key) {
        item.style.backgroundColor = highlight ? "#c9c9c9" : "";
      }
    });
  }

  // Наведение на элемент
  items.forEach((item) => {
    item.addEventListener("mouseenter", () =>
      highlightSameKeyElements(item.dataset.comparisonKey, true)
    );
    item.addEventListener("mouseleave", () =>
      highlightSameKeyElements(item.dataset.comparisonKey, false)
    );
  });

  // Функция для поиска различий
  function hideEqual(e) {
    const grouped = {};

    // Группируем элементы по ключу
    items.forEach((item) => {
      const key = item.dataset.comparisonKey;
      const value = item.dataset.comparisonValue;

      if (!grouped[key]) {
        grouped[key] = new Set();
      }
      grouped[key].add(value);
    });

    items.forEach((item) => {
      const key = item.dataset.comparisonKey;
      if (grouped[key].size > 1) {
        item.style.display = "";
        // item.style.backgroundColor = "";
      } else {
        item.style.display = "none"; // Скрываем одинаковые
        // item.style.backgroundColor = "#c9c9c9";
      }
    });

    btnActivated(e);
  }

  function btnActivated(e) {
    let btn = document.querySelector("[data-comparison-btn].active");
    if (btn) {
      btn.classList.remove("active");
    }
    if (e) {
      e.classList.add("active");
    }
  }

  // Добавляем кнопку для сравнения
  window.comparisonHideEqual = hideEqual;
  window.comparisonShowEqual = (e) => {
    items.forEach((item) => {
      item.style.display = "";
    });

    btnActivated(e);
  };
}
