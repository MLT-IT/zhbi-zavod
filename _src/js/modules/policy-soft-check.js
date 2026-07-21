/**
 * Мягкая проверка галочки политики для FetchIt-форм.
 * Заявка уходит на бэкенд без галочки; UI success блокируется до явного согласия.
 */

const POLICY_INPUT_SELECTOR =
  'input[name="callback-policy"], input[name="privacy"]';
const POLICY_ERROR_MSG =
  "Необходимо активировать галочку согласия с условиями обработки персональных данных";

const scopeData = new WeakMap();
let lastPolicyGate = { block: false, form: null };

function getScopeData(scope) {
  if (!scope) return {};
  if (!scopeData.has(scope)) scopeData.set(scope, {});
  return scopeData.get(scope);
}

function getFormScope(form) {
  if (!form) return null;
  return form.closest(".modal") || form;
}

function getPolicyCheckbox(form) {
  if (!form) return null;
  const policy = form.querySelector(POLICY_INPUT_SELECTOR);
  if (policy && policy.type === "checkbox") return policy;

  const scope = getFormScope(form);
  return scope ? scope.querySelector(POLICY_INPUT_SELECTOR) : null;
}

function ensureAlreadySentInput(form) {
  const scope = getFormScope(form);
  let input = form.querySelector('input[name="already_sent"]');

  if (!input) {
    input = document.createElement("input");
    input.type = "hidden";
    input.name = "already_sent";
    form.appendChild(input);
  }

  input.disabled = false;
  input.value = "1";

  if (scope) getScopeData(scope).alreadySent = true;
  return input;
}

function isAlreadySent(form) {
  const scope = getFormScope(form);
  if (scope && getScopeData(scope).alreadySent) return true;

  const input = form.querySelector('input[name="already_sent"]');
  return !!(input && !input.disabled && input.value);
}

function isPolicySoftBlocked(form) {
  if (lastPolicyGate.block) return true;

  const scope = getFormScope(form);
  const data = getScopeData(scope);
  const policy = getPolicyCheckbox(form);

  if (data.policySoftBlock) return true;

  if (data.policyRequired || data.alreadySent) {
    if (!policy || !policy.checked) return true;
  }

  if (policy && !policy.checked) return true;

  return false;
}

function showPolicyError(form) {
  const policy = getPolicyCheckbox(form);
  const scope = getFormScope(form);
  const wrap = policy
    ? policy.closest(".custom-checkbox, .form__checkbox, .privacy")
    : scope?.querySelector(".custom-checkbox, .form__checkbox, .privacy");

  if (wrap) wrap.classList.add("policy-invalid");

  let msg = scope?.querySelector(".policy-error-msg");
  if (!msg) {
    msg = document.createElement("p");
    msg.className = "policy-error-msg";
    if (wrap) {
      wrap.insertAdjacentElement("afterend", msg);
    } else {
      form.appendChild(msg);
    }
  }

  msg.textContent = POLICY_ERROR_MSG;
  policy?.scrollIntoView({ behavior: "smooth", block: "nearest" });
}

function clearPolicyError(form) {
  const scope = getFormScope(form);
  scope
    ?.querySelectorAll(".custom-checkbox, .form__checkbox, .privacy")
    .forEach((el) => el.classList.remove("policy-invalid"));
  scope?.querySelectorAll(".policy-error-msg").forEach((el) => el.remove());
  form.querySelectorAll(".policy-error-msg").forEach((el) => el.remove());
}

function saveFormSnapshot(form) {
  const snapshot = [];

  form.querySelectorAll("input, select, textarea").forEach((el) => {
    if (!el.name || el.type === "submit" || el.type === "button" || el.type === "file") {
      return;
    }

    snapshot.push({
      name: el.name,
      type: el.type || el.tagName.toLowerCase(),
      value: el.value,
      checked: !!el.checked,
    });
  });

  getScopeData(getFormScope(form)).policyFormSnapshot = snapshot;
}

function restoreFormSnapshot(form) {
  const snapshot = getScopeData(getFormScope(form)).policyFormSnapshot;
  if (!snapshot?.length) return;

  snapshot.forEach((item) => {
    const fields = form.querySelectorAll(`[name="${CSS.escape(item.name)}"]`);
    if (!fields.length) return;

    if (item.type === "checkbox" || item.type === "radio") {
      fields.forEach((field) => {
        if (field.value === item.value || fields.length === 1) {
          field.checked = item.checked;
        }
      });
    } else {
      fields.forEach((field) => {
        field.value = item.value;
      });
    }
  });
}

function muteFormReset(form) {
  if (!form || form._policyOriginalReset) return;

  form._policyOriginalReset = form.reset.bind(form);
  form._policyResetMuted = true;
  form.reset = function policyMutedReset() {};
}

function restoreFormReset(form) {
  if (!form?._policyOriginalReset) return;

  form.reset = form._policyOriginalReset;
  delete form._policyOriginalReset;
  form._policyResetMuted = false;
}

function muteNotificationsSuccess() {
  if (!window.notifications || window.notifications._policyOriginalSuccess) return;

  window.notifications._policyOriginalSuccess = window.notifications.success.bind(
    window.notifications
  );
  window.notifications._policyMuted = true;
  window.notifications.success = function policyMutedSuccess() {};
}

function restoreNotificationsSuccess() {
  if (!window.notifications?._policyOriginalSuccess) return;

  window.notifications.success = window.notifications._policyOriginalSuccess;
  delete window.notifications._policyOriginalSuccess;
  window.notifications._policyMuted = false;
}

function hideSuccessNotifications() {
  document
    .querySelectorAll("#notifications-container .notification.success")
    .forEach((el) => el.remove());
}

function revertModalSuccess() {
  if (typeof window.modals?.showBodyBefore === "function") {
    window.modals.showBodyBefore();
  }
}

export function handlePolicySoftCheck(form) {
  if (!form || !isPolicySoftBlocked(form)) {
    clearPolicyError(form);
    return false;
  }

  const scope = getFormScope(form);
  const data = getScopeData(scope);

  data.policySoftBlock = true;
  data.policyRequired = true;

  muteFormReset(form);
  muteNotificationsSuccess();
  restoreFormSnapshot(form);
  ensureAlreadySentInput(form);

  const policy = getPolicyCheckbox(form);
  if (policy) policy.checked = false;

  showPolicyError(form);
  hideSuccessNotifications();
  revertModalSuccess();

  setTimeout(() => {
    restoreFormSnapshot(form);
    ensureAlreadySentInput(form);
    if (policy) policy.checked = false;
    showPolicyError(form);
    hideSuccessNotifications();
    revertModalSuccess();
  }, 0);

  setTimeout(() => {
    hideSuccessNotifications();
    revertModalSuccess();
  }, 300);

  return true;
}

export function getLastPolicyGateForm() {
  return lastPolicyGate.form;
}

export default function initPolicySoftCheck() {
  document.addEventListener(
    "change",
    (event) => {
      const target = event.target;
      if (!target.matches(POLICY_INPUT_SELECTOR)) return;

      const form = target.closest("form");
      if (!form) return;

      const scope = getFormScope(form);
      const data = getScopeData(scope);

      if (target.checked) {
        clearPolicyError(form);
        lastPolicyGate.block = false;
        data.policySoftBlock = false;
        data.policyCheckedAtSubmit = true;
        restoreFormReset(form);
        restoreNotificationsSuccess();
      } else {
        data.policySoftBlock = true;
        lastPolicyGate.block = true;
      }
    },
    true
  );

  document.addEventListener(
    "submit",
    (event) => {
      const form = event.target;
      if (!form || form.tagName !== "FORM") return;

      const scope = getFormScope(form);
      const data = getScopeData(scope);
      const policy = getPolicyCheckbox(form);
      const policyPresent = !!policy;
      const policyChecked = policyPresent && policy.checked;

      if (policyPresent) {
        data.policyRequired = true;
      }

      const stickyNeedPolicy =
        data.policySoftBlock || data.alreadySent || data.policyRequired;
      const mustBlock =
        (policyPresent && !policyChecked) ||
        (stickyNeedPolicy && !policyChecked);

      lastPolicyGate = {
        block: mustBlock,
        form,
      };

      data.policyPresentAtSubmit = policyPresent || stickyNeedPolicy;
      data.policyCheckedAtSubmit = policyChecked;

      if (mustBlock) {
        data.policySoftBlock = true;
        saveFormSnapshot(form);
        muteFormReset(form);
        muteNotificationsSuccess();
      } else if (policyChecked) {
        data.policySoftBlock = false;
        restoreFormReset(form);
        restoreNotificationsSuccess();
      }

      if (data.alreadySent) {
        ensureAlreadySentInput(form);
      }
    },
    true
  );
}
