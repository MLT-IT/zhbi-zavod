export default function collapseLongTexts(){
  const textBlocks = document.querySelectorAll(
    ".catalog-screen__text, .collapse-long-text"
  );

  let maxHeight = "3em";
  if (window.innerWidth < 778) {
    maxHeight = "3em";
  }
  textBlocks &&
    textBlocks.forEach((textBlock) => {
      textBlock.style.maxHeight = maxHeight;

      if (textBlock.innerText.length) {
        if (textBlock.scrollHeight > textBlock.clientHeight) {
          const toggleButton = document.createElement("div");
          toggleButton.classList.add("read-all-button");
          toggleButton.innerText = "Читать полностью";

          textBlock.insertAdjacentElement("afterend", toggleButton); // Добавляем кнопку после блока с текстом

          toggleButton.addEventListener("click", () => {
            textBlock.classList.toggle("expand");
            if (textBlock.classList.contains("expand")) {
              toggleButton.innerText = "Свернуть";
              textBlock.style.maxHeight = "1000px";
            } else {
              toggleButton.innerText = "Читать полностью";
              textBlock.style.maxHeight = maxHeight;
            }
          });
        }
      }
    });
}
