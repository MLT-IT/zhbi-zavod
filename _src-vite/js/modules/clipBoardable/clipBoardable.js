import "./clipBoardable.scss";

import copy from "copy-to-clipboard";

const iconSvg = '<svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><g><path d="M10 8V7C10 6.05719 10 5.58579 10.2929 5.29289C10.5858 5 11.0572 5 12 5H17C17.9428 5 18.4142 5 18.7071 5.29289C19 5.58579 19 6.05719 19 7V12C19 12.9428 19 13.4142 18.7071 13.7071C18.4142 14 17.9428 14 17 14H16M7 19H12C12.9428 19 13.4142 19 13.7071 18.7071C14 18.4142 14 17.9428 14 17V12C14 11.0572 14 10.5858 13.7071 10.2929C13.4142 10 12.9428 10 12 10H7C6.05719 10 5.58579 10 5.29289 10.2929C5 10.5858 5 11.0572 5 12V17C5 17.9428 5 18.4142 5.29289 18.7071C5.58579 19 6.05719 19 7 19Z" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"></path></g></svg>'

function createClipboardIcon() {
  const icon = document.createElement("i");
  icon.className = "clipboard-icon";
  icon.title = 'Скопировать в буфер';
  icon.innerHTML = iconSvg;
  // icon.onclick = copyTextToClipboard; // in case only icon should copy
  return icon;
}

// Function to copy text to clipboard
function copyTextToClipboard(event) {
  event.preventDefault();
  event.stopPropagation();
  const text = event.target.closest('.clipBoardable')?.textContent || 'e-mail';
  copy(text);
  showTooltip(event.target.closest('.clipBoardable'), "Скопировано в буфер");
}

function showTooltip(element, message) {
  const tooltip = document.createElement("div");
  tooltip.className = "tooltip";
  tooltip.textContent = message;
  element.style.position = 'relative';
  element.append(tooltip);

  //const rect = element.getBoundingClientRect();
  // tooltip.style.left = 0;//`${rect.left + window.scrollX}px`;
  // tooltip.style.top = 0;//`${rect.top + window.scrollY - tooltip.offsetHeight}px`;
  tooltip.style.opacity = "1";

  setTimeout(() => {
    tooltip.style.opacity = "0";
    setTimeout(() => {
      tooltip.remove();
    }, 300); // Delay to match the fade out duration
  }, 600); // Display time before starting fade out
}

// Function to add clipboard icons to elements with class 'clipBoardable'
export function addClipboardIcons(selector = ".clipBoardable") {
  const elements = document.querySelectorAll(selector);
  if(!elements.length) return;
  elements.forEach((element) => {
    element.onclick = (e) => {e.preventDefault()}
    const icon = createClipboardIcon();
    element.append(icon);
    icon.addEventListener('click', copyTextToClipboard) // all button copies text
  });
}
