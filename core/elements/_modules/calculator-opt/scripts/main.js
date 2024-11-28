// Инициализация
function init() {
    const searchInput = document.querySelector(".calculator-opt .calculator-opt__input");
    const searchResultBlock = document.querySelector(".calculator-opt .search-result");
    const searchResultContainer = searchResultBlock.querySelector(".calculator-opt .search-result__container");
    const closeButton = document.querySelector(".calculator-opt .search-input__close");
    const actionContainer = document.querySelector(".calculator-opt .calculator-opt__quantity-input");

    setupSearchHandlers({ searchInput, searchResultBlock, searchResultContainer, closeButton });
    setupCounterHandlers(searchInput);
}

// Установка обработчиков для поля поиска
function setupSearchHandlers({ searchInput, searchResultBlock, searchResultContainer, closeButton }) {
    addFocusHandler(searchInput, searchResultBlock);
    addBlurHandler(searchInput, searchResultBlock);
    addInputHandler(searchInput, searchResultBlock, searchResultContainer, closeButton);
    addCloseHandler(closeButton, searchInput);
}

// Добавляем обработчик фокуса на поле поиска
function addFocusHandler(searchInput, searchResultBlock) {
    searchInput.addEventListener("focus", () => toggleSearchResult(searchResultBlock, true));
}
function addBlurHandler(searchInput, searchResultBlock) {
    searchInput.addEventListener("blur", () => {
        setTimeout(()=> {
            toggleSearchResult(searchResultBlock, false)
        }, 400);
    });
}

// Добавляем обработчик ввода текста в поле поиска
function addInputHandler(searchInput, searchResultBlock, searchResultContainer, closeButton) {
    let searchTimer;

    searchInput.addEventListener("input", (event) => {
        clearTimeout(searchTimer);
        const query = event.target.value.trim();

        toggleCloseButton(closeButton, query);

        if (!query) {
            searchResultContainer.innerHTML = "";
            return;
        }

        searchTimer = setTimeout(() => {
            performSearch(query, searchResultContainer, searchResultBlock, searchInput);
        }, 500);
    });
}

// Обработчик для кнопки закрытия поиска
function addCloseHandler(closeButton, searchInput) {
    closeButton.addEventListener("click", () => {
        searchInput.value = "";
        searchInput.removeAttribute("data-product-id");
    });
}

// Выполняем поиск
function performSearch(query, container, resultBlock, searchInput) {
    fetchSearchResults(query)
        .then((response) => {
            container.innerHTML = renderSearchResults(response.data);
            setupSearchItemClickHandlers(container, resultBlock, searchInput);
        })
        .catch((error) => console.error("Ошибка:", error));
}

// Переключение видимости кнопки закрытия
function toggleCloseButton(closeButton, query) {
    closeButton.classList.toggle("active", !!query);
}

// Управление отображением результатов поиска
function toggleSearchResult(searchResultBlock, isActive) {
    searchResultBlock.classList.toggle("active", isActive);
}

// Запрос данных с сервера для поиска
function fetchSearchResults(query) {
    return $.ajax({
        url: "/assets/components/calculator-opt/api.php",
        type: "POST",
        headers: getDefaultHeaders(),
        contentType: "application/json",
        data: JSON.stringify({ query }),
    });
}

// Рендеринг результатов поиска
function renderSearchResults(data) {
    return data.map(renderSearchItem).join("");
}

// Рендеринг одного элемента поиска
function renderSearchItem(data) {
    return `
        <div class="search-item">
            <span data-product-id="${data.id}">${data.pagetitle}</span>
        </div>
    `;
}

// Установка обработчиков кликов на элементы результата
function setupSearchItemClickHandlers(container, resultBlock, searchInput) {
    container.querySelectorAll(".search-item").forEach((item) => {
        item.addEventListener("click", () => handleSearchItemClick(item, searchInput, resultBlock));
    });
}

// Обработка клика по элементу поиска
function handleSearchItemClick(item, searchInput, resultBlock) {
    const span = item.querySelector("span");
    searchInput.value = span.textContent;
    searchInput.setAttribute("data-product-id", span.getAttribute("data-product-id"));
    toggleSearchResult(resultBlock, false);
    calculatePrice(searchInput);
}

// Настройка обработчиков для счетчика
function setupCounterHandlers(searchInput) {
    const buttonPlus = document.querySelector(".calculator-opt .counter__btn_plus");
    const buttonMinus = document.querySelector(".calculator-opt .counter__btn_minus");
    const countInput = document.querySelector(".calculator-opt .counter__input");

    addCounterHandler(countInput, buttonPlus, buttonMinus, searchInput);
}

// Добавление обработчиков для кнопок счетчика
function addCounterHandler(countInput, buttonPlus, buttonMinus, searchInput) {
    countInput.addEventListener("blur", () => handleCounterBlur(countInput, searchInput));
    buttonPlus.addEventListener("click", () => updateCounter(countInput, 1, searchInput));
    buttonMinus.addEventListener("click", () => updateCounter(countInput, -1, searchInput));
}

// Обработка изменения значения в поле счетчика
function handleCounterBlur(countInput, searchInput) {
    if (!isNumericString(countInput.value) || countInput.value < 1) {
        countInput.value = 1;
    }
    calculatePrice(searchInput);
}

// Обновление значения счетчика
function updateCounter(countInput, delta, searchInput) {
    const currentValue = parseInt(countInput.value, 10) || 1;
    countInput.value = Math.max(1, currentValue + delta);
    calculatePrice(searchInput);
}

// Проверка на числовую строку
function isNumericString(value) {
    return typeof value === "string" && /^\d+$/.test(value);
}

// Расчет цены
function calculatePrice(searchInput) {
    const productId = searchInput.getAttribute("data-product-id");
    const countInput = document.querySelector(".calculator-opt .counter__input");
    const priceBlock = document.querySelector(".calculator-opt .price__value");
    const priceSaleBlock = document.querySelector(".calculator-opt .price-sale__value");

    if (!productId || !countInput) return;

    fetchCalculate(productId, countInput.value)
        .then((response) => updatePriceBlocks(response, priceBlock, priceSaleBlock))
        .catch((error) => console.error("Ошибка:", error));
}

// Запрос расчета цены
function fetchCalculate(productId, count) {
    return $.ajax({
        url: "/assets/components/calculator-opt/calculate.php",
        type: "POST",
        headers: getDefaultHeaders(),
        contentType: "application/json",
        data: JSON.stringify({ productId, count }),
    });
}

// Обновление блоков с ценой
function updatePriceBlocks(response, priceBlock, priceSaleBlock) {
    priceBlock.textContent = `${response.sum.toLocaleString("ru")} р`;
    priceSaleBlock.textContent = `${response.sale_sum.toLocaleString("ru")} р`;
}

// Общие заголовки для запросов
function getDefaultHeaders() {
    return {
        "Authorization": "Bearer your-token",
        "Custom-Header": "HeaderValue",
        "X-Requested-With": "fetch",
    };
}

// Инициализация приложения
init();
