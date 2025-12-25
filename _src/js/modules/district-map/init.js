import mapCreate from "./map-create";

export default function initDistrictsMap() {
  window.mapCreate = mapCreate;

  const script = document.createElement("script");
  script.src =
    "https://api-maps.yandex.ru/2.1/?apikey=99aa267b-edef-422a-b3d8-12bfaa6253a1&lang=ru_RU&coordorder=latlong&onload=mapCreate";
  script.async = true;
  document.body.appendChild(script);
}
