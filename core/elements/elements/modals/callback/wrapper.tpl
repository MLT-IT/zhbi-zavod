{'!AjaxForm' | snippet : [
    'snippet' => 'FormIt',
    'form' => '@FILE elements/modals/callback/popup-callback.tpl',
    'hooks' => 'create_bitrix_lead',
    'customValidators' => 'checkPhone',
    'validate' => 'PHONE:required:checkPhone',
    'validationErrorMessage' => 'В форме содержатся ошибки!',
    'successMessage' => 'Сообщение успешно отправлено'
]}

{'!AjaxForm' | snippet : [
    'snippet' => 'FormIt',
    'form' => '@FILE elements/modals/callback/popup-cost-delivery.tpl',
    'hooks' => 'create_bitrix_lead',
    'customValidators' => 'checkPhone',
    'validate' => 'PHONE:required:checkPhone',
    'validationErrorMessage' => 'В форме содержатся ошибки!',
    'successMessage' => 'Сообщение успешно отправлено'
]}

{'!AjaxForm' | snippet : [
    'snippet' => 'FormIt',
    'form' => '@FILE elements/modals/callback/popup-reviews.tpl',
    'validate' => 'NAME:required,TEXT:required',
    'validationErrorMessage' => 'В форме содержатся ошибки!',
    'successMessage' => 'Спасибо, ваш отзыв отправлен на модерацию'
]}
