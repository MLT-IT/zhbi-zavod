/**
 * 
 * @param {string} num Строка для форматирования 
 * @returns 
 */
export function prettify(num) {
  try {
    var n = num;
    var separator = " ";
    return n.replace(/(\d{1,3}(?=(?:\d\d\d)+(?!\d)))/g, "$1" + separator);
  } catch {
    return num;
  }
}


export function addCurrency(value, cur, template = () => `${value}${cur}`){
  return template();
}
