{'!AjaxForm' | snippet : [
  'snippet' => 'FormIt',
  'form' => '@FILE modals/popup-callback.tpl',
  'hooks' => 'check_words_and_links,create_request,create_bitrix_lead',
  'customValidators' => 'checkPhone,check_request',
  'validate' => 'PHONE:required:checkPhone:check_request,MOBILEPHONE:blank',
  'validationErrorMessage' => 'В форме содержатся ошибки!',
  'successMessage' => 'Сообщение успешно отправлено'
]}
{'!AjaxForm' | snippet : [
  'snippet' => 'FormIt',
  'form' => '@FILE modals/popup-availability.tpl',
  'hooks' => 'check_words_and_links,create_request,create_bitrix_lead',
  'customValidators' => 'checkPhone,check_request',
  'validate' => 'PHONE:required:checkPhone:check_request,MOBILEPHONE:blank',
  'validationErrorMessage' => 'В форме содержатся ошибки!',
  'successMessage' => 'Сообщение успешно отправлено'
]}
{'!AjaxForm' | snippet : [
  'snippet' => 'FormIt',
  'form' => '@FILE modals/popup-order.tpl',
  'hooks' => 'check_words_and_links,create_request,create_bitrix_lead',
  'customValidators' => 'checkPhone,check_request',
  'validate' => 'PHONE:required:checkPhone:check_request,MOBILEPHONE:blank',
  'validationErrorMessage' => 'В форме содержатся ошибки!',
  'successMessage' => 'Сообщение успешно отправлено'
]}
