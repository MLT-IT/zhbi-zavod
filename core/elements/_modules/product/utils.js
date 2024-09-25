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

export function hashString(input) {
  // return String(input).replace(' ', '').split().map(s => s.charCodeAt(0)).join();
  let hash = 0;
  for (let i = 0; i < input.length; i++) {
    const char = input.charCodeAt(i);
    hash = (hash << 5) - hash + char;
    hash |= 0; // Convert to 32bit integer
  }
  return hash.toString(16); // Convert to hexadecimal string
}
