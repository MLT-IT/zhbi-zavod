/**
 * Вспомогательные функции.
 */

export default {formOfWord, numberWithSpaces, getActiveUnitValue, getItemCount}

// Склонение по числам
function formOfWord(n, f1, f2, f5) {
    n = Math.abs(parseInt(n)) % 100;
    if (n > 10 && n < 20) {
        return f5;
    }
    n = n % 10;
    if (n > 1 && n < 5) {
        return f2;
    }
    if (n === 1) {
        return f1;
    }

    return f5;
}

// Разделить тысячные пробелами
function numberWithSpaces(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, " ");
}

// Получить значение активного unit
function getActiveUnitValue($productItem) {
    // Все единицы измерения
    let unitValues = {
        '1': 1,
        '2': $productItem.attr('data-m2'),
        '3': $productItem.attr('data-m3')
    };

    // Обработка кол-ва единиц измерения
    for (let key in unitValues) {
        unitValues[key] = parseFloat(unitValues[key]);
        if (isNaN(unitValues[key])) {
            unitValues[key] = 0;
        }
    }

    const unit = $productItem.find('*[name="unit"]').val();

    return unitValues[unit];
}

// Рассчет кол-ва при добавлении товара в корзину
function getItemCount($productItem, count) {
    // TODO: надо бы сделать проверку на isNaN
    let unitVal = getActiveUnitValue($productItem);

    // Получившееся кол-во
    count = Math.ceil(1 / unitVal * count);

    // Результат
    return count;
}
