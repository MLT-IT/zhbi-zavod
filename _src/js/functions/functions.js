/**
 * Вспомогательные функции.
 */

export default {formOfWord, numberWithSpaces, getActiveUnitValue, toggleText, trim}

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
        '3': $productItem.attr('data-m3'),
        '4': $productItem.attr('data-pm'),
        '5': $productItem.attr('data-list'),
        '6': $productItem.attr('data-thing'),
        '7': $productItem.attr('data-pilomat-thing'),
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

// Поменять местами текст внутри тега с текстом внутри атрибута attr_1
function toggleText(elem, attr_1) {
    var text = elem.attr(attr_1);
    elem.attr(attr_1, elem.text());
    elem.text(text);
}

// Strip whitespace (or other characters) from the beginning and end of a string
// +   original by: Ilia Kantor (http://javascript.ru)
function trim(str, charlist) {
    charlist = !charlist ? ' \s\xA0' : charlist.replace(/([\[\]\(\)\.\?\/\*\{\}\+\$\^\:])/g, '\$1');
    var re = new RegExp('^[' + charlist + ']+|[' + charlist + ']+$', 'g');
    return str.replace(re, '');
}
