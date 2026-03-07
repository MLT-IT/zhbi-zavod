const TRIGGER_SELECTOR = "[data-tooltip][data-tooltip-text]";
const OPEN_CLASS = "is-open";
const TOOLTIP_CLASS = "ui-tooltip";
const TOOLTIP_CONTENT_CLASS = "ui-tooltip__content";
const TOOLTIP_CLOSE_CLASS = "ui-tooltip__close";
const TOOLTIP_ID_PREFIX = "ui-tooltip-";

const tooltipsByTrigger = new WeakMap();
let tooltipIdSeq = 1;

function isTrueAttr(el, name) {
  const v = el?.getAttribute?.(name);
  if (v == null) return false;
  if (v === "" || v === "true" || v === "1") return true;
  return false;
}

function getTimeoutMs(trigger) {
  const raw = trigger.getAttribute("data-tooltip-timeout");
  if (raw == null || raw === "") return 5000;
  const num = Number(raw);
  if (!Number.isFinite(num)) return 5000;
  return Math.max(0, Math.round(num));
}

function getContainer(trigger) {
  // For cards we want full width of card
  return trigger.closest(".product-card") || trigger.parentElement || document.body;
}

function ensureContainerPositioned(container) {
  if (!container || container === document.body) return;
  const computed = window.getComputedStyle(container);
  if (computed.position === "static") {
    container.style.position = "relative";
  }
}

function ensureTooltip(trigger) {
  const existing = tooltipsByTrigger.get(trigger);
  if (existing) return existing;

  const container = getContainer(trigger);
  ensureContainerPositioned(container);

  const tooltip = document.createElement("div");
  tooltip.className = TOOLTIP_CLASS;
  tooltip.setAttribute("role", "tooltip");
  tooltip.setAttribute("aria-hidden", "true");
  tooltip.__trigger = trigger;

  const id = `${TOOLTIP_ID_PREFIX}${tooltipIdSeq++}`;
  tooltip.id = id;
  trigger.setAttribute("aria-describedby", id);

  const closeBtn = document.createElement("button");
  closeBtn.type = "button";
  closeBtn.className = TOOLTIP_CLOSE_CLASS;
  closeBtn.setAttribute("data-tooltip-close", "true");
  closeBtn.setAttribute("aria-label", "Закрыть");
  closeBtn.textContent = "×";
  tooltip.appendChild(closeBtn);

  const content = document.createElement("div");
  content.className = TOOLTIP_CONTENT_CLASS;
  tooltip.appendChild(content);

  container.appendChild(tooltip);
  tooltipsByTrigger.set(trigger, tooltip);
  return tooltip;
}

function setText(tooltip, text) {
  const content = tooltip.querySelector(`.${TOOLTIP_CONTENT_CLASS}`);
  if (!content) return;
  content.textContent = text ?? "";
}

function setArrowPosition(trigger, tooltip) {
  const container = tooltip.offsetParent || tooltip.parentElement || document.documentElement;
  const containerRect = container.getBoundingClientRect();
  const triggerRect = trigger.getBoundingClientRect();
  const xRaw = Math.round(triggerRect.left + triggerRect.width / 2 - containerRect.left);
  const min = 12;
  const max = Math.max(min, Math.round(containerRect.width) - 12);
  const x = Math.min(max, Math.max(min, xRaw));
  tooltip.style.setProperty("--ui-tooltip-arrow-left", `${x}px`);
}

function setTopPosition(trigger, tooltip) {
  const container = tooltip.offsetParent || tooltip.parentElement || document.documentElement;
  const containerRect = container.getBoundingClientRect();
  const triggerRect = trigger.getBoundingClientRect();
  const offsetRaw = trigger.getAttribute("data-tooltip-offset");
  const offset = offsetRaw == null || offsetRaw === "" ? 8 : Number(offsetRaw);
  const safeOffset = Number.isFinite(offset) ? offset : 8;

  // Measure real height after text is set (prevents "0px then jump")
  const height = Math.round(tooltip.getBoundingClientRect().height) || tooltip.offsetHeight || 0;
  const top = Math.round(triggerRect.top - containerRect.top - height - safeOffset);
  tooltip.style.top = `${top}px`;
}

function open(trigger, reason = "api") {
  const tooltip = ensureTooltip(trigger);
  setText(tooltip, trigger.getAttribute("data-tooltip-text"));

  // Close others
  document.querySelectorAll(`.${TOOLTIP_CLASS}.${OPEN_CLASS}`).forEach((el) => {
    if (el === tooltip) return;
    const otherTrigger = el.__trigger;
    if (otherTrigger) close(otherTrigger);
    else {
      if (el.__hideTimer) window.clearTimeout(el.__hideTimer);
      el.__hideTimer = null;
      el.classList.remove(OPEN_CLASS);
      el.setAttribute("aria-hidden", "true");
    }
  });

  tooltip.classList.add(OPEN_CLASS);
  tooltip.setAttribute("aria-hidden", "false");

  // Position after becoming "open" so height is measurable
  setTopPosition(trigger, tooltip);
  setArrowPosition(trigger, tooltip);

  // Auto hide
  if (tooltip.__hideTimer) window.clearTimeout(tooltip.__hideTimer);
  tooltip.__hideTimer = null;

  // For hover tooltips we close immediately on mouseout (no timer)
  if (reason !== "hover") {
    const ms = getTimeoutMs(trigger);
    if (ms > 0) {
      tooltip.__hideTimer = window.setTimeout(() => {
        close(trigger);
      }, ms);
    }
  }
}

function close(trigger) {
  const tooltip = tooltipsByTrigger.get(trigger);
  if (!tooltip) return;

  if (tooltip.__hideTimer) window.clearTimeout(tooltip.__hideTimer);
  tooltip.__hideTimer = null;

  tooltip.classList.remove(OPEN_CLASS);
  tooltip.setAttribute("aria-hidden", "true");
}

function toggle(trigger) {
  const tooltip = tooltipsByTrigger.get(trigger);
  const isOpen = tooltip?.classList?.contains?.(OPEN_CLASS);
  if (isOpen) close(trigger);
  else open(trigger, "toggle");
}

function initPageOnload() {
  document.querySelectorAll(TRIGGER_SELECTOR).forEach((trigger) => {
    if (
      isTrueAttr(trigger, "data-tooltip-autoload") ||
      isTrueAttr(trigger, "data-tooltip-page-onload")
    ) {
      open(trigger, "autoload");
    }
  });
}

export default function initTooltips() {
  if (window.__uiTooltipsInited) return;
  window.__uiTooltipsInited = true;

  document.addEventListener("click", (e) => {
    const closeBtn = e.target.closest?.('[data-tooltip-close="true"]');
    if (closeBtn) {
      const tooltip = closeBtn.closest?.(`.${TOOLTIP_CLASS}`);
      const trigger = tooltip?.__trigger;
      if (trigger) close(trigger);
      return;
    }

    const trigger = e.target.closest?.(TRIGGER_SELECTOR);
    if (trigger) {
      toggle(trigger);
      return;
    }

    // click outside closes all
    const insideTooltip = e.target.closest?.(`.${TOOLTIP_CLASS}`);
    if (!insideTooltip) {
      document.querySelectorAll(`.${TOOLTIP_CLASS}.${OPEN_CLASS}`).forEach((tooltip) => {
        const t = tooltip.__trigger;
        if (t) close(t);
        else {
          if (tooltip.__hideTimer) window.clearTimeout(tooltip.__hideTimer);
          tooltip.__hideTimer = null;
          tooltip.classList.remove(OPEN_CLASS);
          tooltip.setAttribute("aria-hidden", "true");
        }
      });
    }
  });

  document.addEventListener("mouseover", (e) => {
    const trigger = e.target.closest?.(TRIGGER_SELECTOR);
    if (!trigger) return;
    if (!isTrueAttr(trigger, "data-tooltip-hover")) return;

    const related = e.relatedTarget;
    if (related && (trigger.contains(related) || related.closest?.(`.${TOOLTIP_CLASS}`))) return;
    open(trigger, "hover");
  });

  document.addEventListener("mouseout", (e) => {
    const trigger = e.target.closest?.(TRIGGER_SELECTOR);
    if (!trigger) return;
    if (!isTrueAttr(trigger, "data-tooltip-hover")) return;

    const related = e.relatedTarget;
    if (related && (trigger.contains(related) || related.closest?.(`.${TOOLTIP_CLASS}`))) return;
    close(trigger);
  });

  document.addEventListener("keydown", (e) => {
    if (e.key !== "Escape") return;
    document.querySelectorAll(`.${TOOLTIP_CLASS}.${OPEN_CLASS}`).forEach((tooltip) => {
      const t = tooltip.__trigger;
      if (t) close(t);
      else {
        if (tooltip.__hideTimer) window.clearTimeout(tooltip.__hideTimer);
        tooltip.__hideTimer = null;
        tooltip.classList.remove(OPEN_CLASS);
        tooltip.setAttribute("aria-hidden", "true");
      }
    });
  });

  window.addEventListener("resize", () => {
    document.querySelectorAll(TRIGGER_SELECTOR).forEach((trigger) => {
      const tooltip = tooltipsByTrigger.get(trigger);
      if (!tooltip || !tooltip.classList.contains(OPEN_CLASS)) return;
      setTopPosition(trigger, tooltip);
      setArrowPosition(trigger, tooltip);
    });
  });

  initPageOnload();
}

