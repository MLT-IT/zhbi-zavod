
let maxHeight = "3em";
const buttonClass = "read-all-button";

export default function collapseLongTexts() {
  try {
    const textBlocks = document.querySelectorAll(
      ".catalog-screen__text, .collapse-long-text"
    );
    textBlocks &&
      textBlocks.forEach((textBlock) => {
        if (!textBlock.innerText.length) {
          console.log(`No text to collapse skip`);
          return;
        }
        if (textBlock.scrollHeight <= textBlock.clientHeight) {
          console.log(`Text is not high enough to collapse, skipping`);
          return;
        }
        if (textBlock.parentElement.querySelector(`.${buttonClass}`)) {
          console.log("Skip existing long text wrap");
          return;
        }
        console.log("Creating long text collapse wrap");
        textBlock.style.maxHeight = maxHeight;
        const toggleButton = document.createElement("div");
        toggleButton.classList.add(buttonClass);
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
      });
  } catch (e) {
    console.error("Error applying long-text wrap", e);
  }
}
