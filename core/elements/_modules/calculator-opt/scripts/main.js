// Конфигурация селекторов
const selectors = {
    searchInput: ".calculator-opt .calculator-opt__input",
    searchResultBlock: ".calculator-opt .search-result",
    searchResultContainer: ".calculator-opt .search-result__container",
    closeButton: ".calculator-opt .search-input__close",
    actionContainer: ".calculator-opt .calculator-opt__quantity-input",
    buttonPlus: ".calculator-opt .counter__btn_plus",
    buttonMinus: ".calculator-opt .counter__btn_minus",
    countInput: ".calculator-opt .counter__input",
    priceBlock: ".calculator-opt .price__value",
    priceSaleBlock: ".calculator-opt .price-sale__value",
    formProductId: ".form-product-id",
    searchItem: ".search-item",
    searchItemSpan: "span",
};

// Основная инициализация
function init() {
    const elements = getElements(selectors);

    calculatePrice(elements.searchInput);
    setupSearchHandlers(elements);
    setupCounterHandlers(elements);
}

// Получение всех необходимых элементов
function getElements(selectors) {
    return {
        searchInput: document.querySelector(selectors.searchInput),
        searchResultBlock: document.querySelector(selectors.searchResultBlock),
        searchResultContainer: document.querySelector(selectors.searchResultContainer),
        closeButton: document.querySelector(selectors.closeButton),
        countInput: document.querySelector(selectors.countInput),
        buttonPlus: document.querySelector(selectors.buttonPlus),
        buttonMinus: document.querySelector(selectors.buttonMinus),
        priceBlock: document.querySelector(selectors.priceBlock),
        priceSaleBlock: document.querySelector(selectors.priceSaleBlock),
        formProductId: document.querySelector(selectors.formProductId),
    };
}

// Установка обработчиков для поля поиска
function setupSearchHandlers({ searchInput, searchResultBlock, searchResultContainer, closeButton }) {
    addFocusHandler(searchInput, searchResultBlock);
    addBlurHandler(searchInput, searchResultBlock);
    addInputHandler(searchInput, searchResultBlock, searchResultContainer, closeButton);
    addCloseHandler(closeButton, searchInput);
}

// Добавление обработчиков для счетчика
function setupCounterHandlers({ countInput, buttonPlus, buttonMinus, searchInput }) {
    countInput.addEventListener("blur", () => handleCounterBlur(countInput, searchInput));
    buttonPlus.addEventListener("click", (e) => { e.preventDefault(); updateCounter(countInput, 1, searchInput)});
    buttonMinus.addEventListener("click", (e) => { e.preventDefault(); updateCounter(countInput, -1, searchInput)});
}

// Обработчики фокуса и потери фокуса
function addFocusHandler(searchInput, searchResultBlock) {
    searchInput.addEventListener("focus", () => toggleSearchResult(searchResultBlock, true));
}

function addBlurHandler(searchInput, searchResultBlock) {
    searchInput.addEventListener("blur", () => {
        setTimeout(() => toggleSearchResult(searchResultBlock, false), 400);
    });
}

// Обработчик ввода текста
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

// Обработчик кнопки закрытия
function addCloseHandler(closeButton, searchInput) {
    closeButton.addEventListener("click", () => {
        searchInput.value = "";
        searchInput.removeAttribute("data-product-id");
        document.querySelector(selectors.formProductId).removeAttribute("value");
    });
}

// Поиск данных
function performSearch(query, container, resultBlock, searchInput) {
    fetchSearchResults(query)
        .then((response) => {
            container.innerHTML = renderSearchResults(response.data);
            setupSearchItemClickHandlers(container, resultBlock, searchInput);
        })
        .catch((error) => console.error("Ошибка:", error));
}

// Отображение кнопки закрытия
function toggleCloseButton(closeButton, query) {
    closeButton.classList.toggle("active", !!query);
}

// Управление отображением результатов поиска
function toggleSearchResult(searchResultBlock, isActive) {
    searchResultBlock.classList.toggle("active", isActive);
}

// Запрос данных с сервера
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

function renderSearchItem(data) {
    return `<div class="search-item">
                <span data-product-id="${data.id}">${data.pagetitle}</span>
            </div>`;
}

// Обработчики кликов по элементам поиска
function setupSearchItemClickHandlers(container, resultBlock, searchInput) {
    container.querySelectorAll(selectors.searchItem).forEach((item) => {
        item.addEventListener("click", () => handleSearchItemClick(item, searchInput, resultBlock));
    });
}

// Логика клика по элементу поиска
function handleSearchItemClick(item, searchInput, resultBlock) {
    const span = item.querySelector(selectors.searchItemSpan);
    searchInput.value = span.textContent;
    const productId = span.getAttribute("data-product-id");
    searchInput.setAttribute("data-product-id", productId);
    document.querySelector(selectors.formProductId).setAttribute("value", productId);
    toggleSearchResult(resultBlock, false);
    calculatePrice(searchInput);
}

// Логика работы счетчика
function handleCounterBlur(countInput, searchInput) {
    if (!isNumericString(countInput.value) || countInput.value < 1) {
        countInput.value = 1;
    }
    calculatePrice(searchInput);
}

function updateCounter(countInput, delta, searchInput) {
    const currentValue = parseInt(countInput.value, 10) || 1;
    countInput.value = Math.max(1, currentValue + delta);
    calculatePrice(searchInput);
}

function isNumericString(value) {
    return typeof value === "string" && /^\d+$/.test(value);
}

// Расчет цены
function calculatePrice(searchInput) {
    const productId = searchInput.getAttribute("data-product-id");
    const countInput = document.querySelector(selectors.countInput);
    const priceBlock = document.querySelector(selectors.priceBlock);
    const priceSaleBlock = document.querySelector(selectors.priceSaleBlock);

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

// Старт инициализации
try {
    init();
} catch (e) {
    console.error("Ошибка инициализации:", e);
}
