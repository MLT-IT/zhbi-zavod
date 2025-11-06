
function coordsFromStr(coordsS, splitter = ',') {
  const coordsA = coordsS.split(splitter);
  return [parseFloat(coordsA[0]), parseFloat(coordsA[1])];
}

export {
  coordsFromStr
}