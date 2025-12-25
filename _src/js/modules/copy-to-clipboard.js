function fallbackCopy(text) {
  const textarea = document.createElement("textarea");
  textarea.value = text;
  textarea.setAttribute("readonly", "");
  textarea.style.position = "absolute";
  textarea.style.left = "-9999px";
  document.body.appendChild(textarea);
  textarea.select();
  try {
    return document.execCommand("copy");
  } catch {
    return false;
  } finally {
    document.body.removeChild(textarea);
  }
}

export default function initCopyToClipboard() {
  window.copyToClipboard = async function(text) {
    if (!text) return;
    try {
      if (navigator.clipboard && navigator.clipboard.writeText) {
        await navigator.clipboard.writeText(text);
      } else {
        const ok = fallbackCopy(text);
        if (!ok) throw new Error("Fallback copy failed");
      }
      if (window.notifications) {
        window.notifications.success("Скопировано в буфер");
      }
    } catch (e) {
      if (window.notifications) {
        window.notifications.error("Не удалось скопировать");
      } else {
        console.error("Copy failed", e);
      }
    }
  };
}


