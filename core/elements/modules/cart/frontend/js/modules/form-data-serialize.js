export default function formDataSerialize(form) {
  let fillable = [
    "id",
    "price",
    "old_price",
    "calc_price",
    "count",
    "unit",
    "calc_width",
    "calc_length",
  ];

  let result = {};
  Array.from(form.elements).forEach((elem) => {
    if (fillable.indexOf(elem.name) > -1) {
      result[elem.name] = elem.value;
    }
  });

  return result;
}
