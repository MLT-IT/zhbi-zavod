/**
 * Вспомогательные функции.
 */

export default {
  formOfWord,
  numberWithSpaces,
  toggleText,
  trim,
  getActiveForm,
  getStep,
  getCorrectValueToCounter,
  getSearchParameters,
  escapeRegExp,
  highlight,
};

// Выделяет найденное вхождение в тексте
function highlight(text, words, tag = "span") {
  var i,
    len = words.length,
    re;
  for (i = 0; i < len; i++) {
    let find = false;
    [
      words[i],
      translit(words[i], "en_ru"),
      translit(words[i], "ru_en"),
    ].forEach((word) => {
      if (!find) {
        re = new RegExp(word, "gi");
        if (re.test(text)) {
          find = true;
          text = text.replace(
            re,
            "<" + tag + ' class="highlight">$&</' + tag + ">"
          );
        }
      }
    });
  }
  return text;
}

// Транслитирация
function translit(word, key) {
  let converter = {
    ru_en: {
      а: "a",
      б: "b",
      в: "v",
      г: "g",
      д: "d",
      е: "e",
      ё: "yo",
      ж: "zh",
      з: "z",
      и: "i",
      й: "j",
      к: "k",
      л: "l",
      м: "m",
      н: "n",
      о: "o",
      п: "p",
      р: "r",
      с: "s",
      т: "t",
      у: "u",
      ф: "f",
      х: "h",
      ц: "c",
      ч: "ch",
      ш: "sh",
      щ: "sh",
      ъ: "``",
      ы: "y",
      ь: "`",
      э: "e`",
      ю: "yu",
      я: "ya",
    },
    en_ru: {
      a: "а",
      b: "б",
      v: "в",
      g: "г",
      d: "д",
      e: "е",
      yo: "ё",
      zh: "ж",
      z: "з",
      i: "и",
      j: "й",
      k: "к",
      l: "л",
      m: "м",
      n: "н",
      o: "о",
      p: "п",
      r: "р",
      s: "с",
      t: "т",
      u: "у",
      f: "ф",
      h: "х",
      c: "ц",
      ch: "ч",
      sh: "ш",
      sch: "щ",
      "``": "ъ",
      y: "ы",
      "`": "ь",
      "e`": "э",
      yu: "ю",
      ya: "я",
    },
  };

  word = word.toLowerCase();

  let answer = "";
  for (let i = 0; i < word.length; ++i) {
    let x = word[i];
    if (x === "c" && word[i + 1] === "h") {
      x = "ch";
      i++;
    } else if (x === "s" && word[i + 1] === "h") {
      x = "sh";
      i++;
    } else if (x === "y" && word[i + 1] === "u") {
      x = "yu";
      i++;
    } else if (x === "y" && word[i + 1] === "a") {
      x = "ya";
      i++;
    } else if (x === "y" && word[i + 1] === "o") {
      x = "yo";
      i++;
    } else if (x === "z" && word[i + 1] === "h") {
      x = "zh";
      i++;
    }

    if (converter[key][x] == undefined) {
      answer += x;
    } else {
      answer += converter[key][x];
    }
  }

  return answer;
}

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
  // Это нужно, чтобы убрать ненужные в конце. Пример: 1.80 - здесь лишний ноль
  x = parseFloat(x);

  return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, " ");
}

// Поменять местами текст внутри тега с текстом внутри атрибута attr_1
function toggleText($elem, attr_1) {
  var text = $elem.attr(attr_1);
  $elem.attr(attr_1, $elem.text());
  $elem.text(text);
}

// Strip whitespace (or other characters) from the beginning and end of a string
// +   original by: Ilia Kantor (http://javascript.ru)
function trim(str, charlist) {
  charlist = !charlist
    ? " s\xA0"
    : charlist.replace(/([\[\]\(\)\.\?\/\*\{\}\+\$\^\:])/g, "$1");
  var re = new RegExp("^[" + charlist + "]+|[" + charlist + "]+$", "g");
  return str.replace(re, "");
}

function getActiveForm($productItem) {
  let $formService;
  let $formAction;

  if ($productItem.hasClass("js-product-in-cart")) {
    // Товар уже в корзине, нужно изменить кол-во
    $formService = $productItem.find(".js-product__form-change");
    $formAction = $productItem.find(".js-product__controls_action_change");
  } else {
    // Товара нет в корзине
    $formService = $productItem.find(".js-product__form-add");
    $formAction = $productItem.find(".js-product__controls_action_add");
  }

  return {
    system: $formService,
    action: $formAction,
  };
}

/**
 * Эта функция нигде не используется.
 * Раньше она нужна была для получения шага, чтобы изменять кол-ва товара в счетчике кратно поддонам (на кирпичах товары должны были продаваться поддонами).
 */
function getStep($item) {
  let step = 1;
  let dataStep = $item.attr("data-step");

  if (typeof dataStep !== "undefined") {
    dataStep = parseFloat(dataStep);
    if (!isNaN(dataStep) && dataStep > 0) {
      step = dataStep;
    } else {
      step = 1;
      console.error("Ошибка при получении data-step");
    }
  }

  return step;
}

/**
 * Эта функция нигде не используется.
 * Раньше она нужна была для изменения кол-ва товара в счетчике кратно поддонам (на кирпичах товары должны были продаваться поддонами).
 */
function getCorrectValueToCounter(step, count) {
  count = parseFloat(count);
  step = parseFloat(step);
  let redundant = count % step;
  redundant = step - redundant;
  if (redundant !== step) {
    count += redundant;
  }

  return count;
}

/**
 * Получает GET-параметры и возвращает их в виде объекта.
 * Для работы использует функцию transformToAssocArray.
 *
 * Обе функции я взял их отсюда и немного улучшил:
   https://stackoverflow.com/questions/5448545/how-to-retrieve-get-parameters-from-javascript
 */
function getSearchParameters() {
  let prmstr = window.location.search.substr(1);
  return prmstr != null && prmstr != ""
    ? transformToAssocArray(decodeURI(prmstr))
    : {};
}

/**
 * Преобразует строку uri в объект.
 */
function transformToAssocArray(prmstr) {
  let params = {};
  let prmarr = prmstr.split("&");
  for (let i = 0; i < prmarr.length; i++) {
    let tmparr = prmarr[i].split("=");
    params[tmparr[0]] = tmparr[1];
  }
  return params;
}

/**
 * Экранирует строку, чтобы сделать ее частью регулярного выражения
 * https://stackoverflow.com/questions/3446170/escape-string-for-use-in-javascript-regex
 *
 * @param string
 * @returns {*}
 */
function escapeRegExp(string) {
  return string.replace(/[.*+?^${}()|[\]\\]/g, "\\$&"); // $& means the whole matched string
}
