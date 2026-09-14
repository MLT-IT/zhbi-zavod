/**
 * Модуль для поиска товаров на складе
 */
const WAREHOUSE_BY_ALIAS = {
    'dachnoe': 'Дачное',
    'yanino-1': 'Янино-1',
    'shushary': 'Шушары',
    'pargolovo': 'Парголово',
    'metallostroy': 'Металлострой'
};

class WarehouseSearch {
    constructor() {
        this.searchInput = document.querySelector('.warehouse-search__input');
        this.searchButton = document.querySelector('.warehouse-search__button');
        this.clearButton = document.querySelector('.warehouse-search__clear');
        this.resultContainer = document.querySelector('.warehouse-search__result');
        this.resultSearchQuery = document.querySelector('.warehouse-search__result-search-query');
        this.stocksContainer = document.querySelector('.warehouse-search__result-stocks');
        this.notInStockContainer = document.querySelector('.warehouse-search__not-in-stock');
        
        this.currentStockName = this.getCurrentStockName();
        this.currentContext = this.getCurrentContext();
        
        // Debounce для живого поиска
        this.searchTimeout = null;
        this.searchDelay = 300; // 300 миллисекунд
        
        this.init();
    }

    init() {
        if (!this.searchInput) return;

        this.bindEvents();
        this.hideResults();
    }

    bindEvents() {
        // Поиск по клику на кнопку
        this.searchButton?.addEventListener('click', (e) => {
            e.preventDefault();
            this.performSearchImmediate();
        });

        // Поиск по Enter
        this.searchInput?.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                e.preventDefault();
                this.performSearchImmediate();
            }
        });

        // Живой поиск при вводе
        this.searchInput?.addEventListener('input', (e) => {
            this.toggleClearButton();
            this.debouncedSearch();
        });

        // Очистка поиска
        this.clearButton?.addEventListener('click', () => {
            this.clearSearch();
        });
    }

    getCurrentStockName() {
        const pathParts = window.location.pathname
            .toLowerCase()
            .split('/')
            .filter(Boolean);
        const pageAlias = pathParts[pathParts.length - 1] || '';

        if (WAREHOUSE_BY_ALIAS[pageAlias]) {
            return WAREHOUSE_BY_ALIAS[pageAlias];
        }

        const titleSelectors = [
            '.warehouse-contacts .contacts__title',
            '.warehouse-contacts h1',
            '.title-1',
            'h1'
        ];

        for (const selector of titleSelectors) {
            const title = document.querySelector(selector);
            const titleText = this.normalizeStockTitle(title?.textContent);
            if (titleText) {
                return titleText;
            }
        }

        return '';
    }

    normalizeStockTitle(title) {
        return (title || '')
            .replace(/^склад\s+/iu, '')
            .trim();
    }

    getCurrentContext() {
        const bodyContext = document.body?.dataset?.ctx;
        if (bodyContext) {
            return bodyContext;
        }

        const metaContext = document.querySelector('meta[name="context"]');
        if (metaContext) {
            return metaContext.getAttribute('content');
        }
        
        return 'web';
    }

    /**
     * Debounced поиск - вызывается при вводе текста
     */
    debouncedSearch() {
        // Отменяем предыдущий таймер
        if (this.searchTimeout) {
            clearTimeout(this.searchTimeout);
        }

        const query = this.searchInput?.value?.trim();
        
        // Если поле пустое, скрываем результаты
        if (!query) {
            this.hideResults();
            this.setSearchState('default');
            return;
        }

        // Минимальная длина запроса для поиска
        if (query.length < 2) {
            this.setSearchState('default');
            return;
        }

        // Показываем, что поиск будет выполнен
        this.setSearchState('waiting');

        // Устанавливаем новый таймер
        this.searchTimeout = setTimeout(() => {
            this.performSearch(query);
        }, this.searchDelay);
    }

    /**
     * Немедленный поиск - вызывается при клике на кнопку или Enter
     */
    performSearchImmediate() {
        // Отменяем debounced поиск
        if (this.searchTimeout) {
            clearTimeout(this.searchTimeout);
        }

        const query = this.searchInput?.value?.trim();
        this.performSearch(query);
    }

    /**
     * Выполнение поиска
     */
    async performSearch(query) {
        if (!query) {
            this.showError('Введите поисковый запрос');
            return;
        }

        this.showLoading();

        try {
            const response = await this.searchProducts(query);
            this.displayResults(response, query);
        } catch (error) {
            console.error('Ошибка поиска:', error);
            this.showError('Произошла ошибка при поиске товаров');
        }
    }

    async searchProducts(query) {
        const stockName = this.currentStockName || this.getCurrentStockName();
        if (!stockName) {
            throw new Error('Не удалось определить текущий склад');
        }
        this.currentStockName = stockName;

        const formData = new FormData();
        formData.append('query', query);
        formData.append('stockName', stockName);
        formData.append('context', this.currentContext);
        formData.append('limit', '10');

        const response = await fetch('/assets/components/calculator-opt/warehouse-search.php', {
            method: 'POST',
            body: formData
        });

        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }

        const text = await response.text();
        
        try {
            const data = JSON.parse(text);
            
            if (!data.success) {
                throw new Error(data.error || 'Неизвестная ошибка');
            }
            
            return data;
        } catch (jsonError) {
            console.error('Ошибка парсинга JSON:', jsonError);
            console.error('Ответ сервера:', text);
            throw new Error('Некорректный ответ сервера');
        }
    }

    displayResults(response, query) {
        this.setSearchState('default');
        this.showResults();
        this.updateSearchQuery(query);

        if (!response.products || response.products.length === 0) {
            // Если товары не найдены вообще, показываем сообщение об отсутствии результатов
            this.hideNotInStock();
            this.showNoResults();
            return;
        }

        // Проверяем, есть ли товары со статусом "request" (под запрос)
        const hasRequestProducts = response.products.some(product => product.status === 'request');
        
        if (hasRequestProducts) {
            this.showNotInStock();
        } else {
            this.hideNotInStock();
        }
        
        this.renderProducts(response.products);
    }

    renderProducts(products) {
        if (!this.stocksContainer) return;

        this.stocksContainer.innerHTML = '';

        products.forEach(product => {
            const productElement = this.createProductElement(product);
            this.stocksContainer.appendChild(productElement);
        });

        this.showStocks();
    }

    createProductElement(product) {
        const div = document.createElement('div');
        div.className = 'warehouse-search__result-stocks-item';

        const titleDiv = document.createElement('div');
        titleDiv.className = 'warehouse-search__result-stocks-item-title';
        
        const titleSpan = document.createElement('span');
        titleSpan.textContent = product.title;
        titleDiv.appendChild(titleSpan);

        const countDiv = document.createElement('div');
        countDiv.className = 'warehouse-search__result-stocks-item-count';
        
        const countSpan = document.createElement('span');
        
        if (product.status === 'request') {
            countSpan.textContent = 'Под запрос';
            countSpan.className = 'request-status';
            countSpan.style.color = '#ff6b6b';
            countSpan.style.fontWeight = 'bold';
        } else {
            countSpan.textContent = product.count;
            if (product.status === 'limited') {
                countSpan.style.color = '#ff9500';
                countSpan.style.fontWeight = 'bold';
            }
        }
        
        countDiv.appendChild(countSpan);
        
        // Добавляем иконку внимания для товаров с ограниченным количеством после количества
        if (product.status === 'limited') {
            const warningIcon = document.createElement('span');
            warningIcon.className = 'warning-icon';
            warningIcon.innerHTML = ' ⚠️';
            warningIcon.title = 'Ограниченное количество!';
            warningIcon.style.marginLeft = '5px';
            countDiv.appendChild(warningIcon);
        }

        div.appendChild(titleDiv);
        div.appendChild(countDiv);

        // Добавляем обработчик клика для перехода на страницу товара
        if (product.url) {
            div.style.cursor = 'pointer';
            div.title = 'Нажмите, чтобы перейти к товару';
            div.addEventListener('click', () => {
                window.open(product.url, '_blank');
            });
            
            // Добавляем стили при наведении
            div.addEventListener('mouseenter', () => {
                div.style.backgroundColor = '#f5f5f5';
            });
            
            div.addEventListener('mouseleave', () => {
                div.style.backgroundColor = '';
            });
        }

        return div;
    }

    showResults() {
        this.resultContainer?.classList.add('active');
    }

    hideResults() {
        this.resultContainer?.classList.remove('active');
    }

    showStocks() {
        if (this.stocksContainer) {
            this.stocksContainer.style.display = 'block';
        }
    }

    hideStocks() {
        if (this.stocksContainer) {
            this.stocksContainer.style.display = 'none';
        }
    }

    showNotInStock() {
        if (this.notInStockContainer) {
            this.notInStockContainer.style.display = 'flex';
        }
    }

    hideNotInStock() {
        if (this.notInStockContainer) {
            this.notInStockContainer.style.display = 'none';
        }
    }

    updateSearchQuery(query) {
        if (this.resultSearchQuery) {
            this.resultSearchQuery.textContent = query;
        }
    }

    showLoading() {
        this.setSearchState('searching');
        this.showResults();
        this.hideStocks();
        this.hideNotInStock();
        
        if (this.stocksContainer) {
            this.stocksContainer.innerHTML = '<div class="loading" style="text-align: center; padding: 20px; color: #666;">Поиск товаров...</div>';
            this.stocksContainer.style.display = 'block';
        }
    }

    showError(message) {
        this.setSearchState('default');
        this.showResults();
        this.hideNotInStock();
        
        if (this.stocksContainer) {
            this.stocksContainer.innerHTML = `<div class="error" style="text-align: center; padding: 20px; color: #ff6b6b; border: 1px solid #ff6b6b; border-radius: 4px; background-color: #fff5f5;">${message}</div>`;
            this.stocksContainer.style.display = 'block';
        }
    }

    showNoResults() {
        this.hideStocks();
        
        if (this.stocksContainer) {
            this.stocksContainer.innerHTML = '<div class="no-results" style="text-align: center; padding: 20px; color: #666; font-style: italic;">По вашему запросу товары не найдены</div>';
            this.stocksContainer.style.display = 'block';
        }
    }

    clearSearch() {
        // Отменяем любые pending поиски
        if (this.searchTimeout) {
            clearTimeout(this.searchTimeout);
            this.searchTimeout = null;
        }

        if (this.searchInput) {
            this.searchInput.value = '';
        }
        this.hideResults();
        this.toggleClearButton();
    }

    toggleClearButton() {
        if (!this.clearButton || !this.searchInput) return;

        if (this.searchInput.value.trim()) {
            this.clearButton.style.display = 'block';
        } else {
            this.clearButton.style.display = 'none';
        }
    }

    /**
     * Установка состояния поиска для визуальной индикации
     */
    setSearchState(state) {
        if (!this.searchInput) return;

        switch (state) {
            case 'waiting':
                this.searchInput.style.borderColor = '#ffa500';
                this.searchInput.style.backgroundColor = '#fff9e6';
                break;
            case 'searching':
                this.searchInput.style.borderColor = '#007bff';
                this.searchInput.style.backgroundColor = '#e6f3ff';
                break;
            case 'default':
            default:
                this.searchInput.style.borderColor = '#DFDFDF';
                this.searchInput.style.backgroundColor = '#fff';
                break;
        }
    }
}

// Инициализация при загрузке DOM
document.addEventListener('DOMContentLoaded', () => {
    new WarehouseSearch();
});

// Экспорт для использования в других модулях
if (typeof module !== 'undefined' && module.exports) {
    module.exports = WarehouseSearch;
}
