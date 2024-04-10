{'!AjaxForm' | snippet : [
  'snippet' => 'FormIt',
  'form' => '@FILE chunks/modals/popup-callback.tpl',
  'hooks' => 'check_words_and_links,create_request,create_bitrix_lead',
  'customValidators' => 'checkPhone,check_request',
  'validate' => 'PHONE:required:checkPhone:check_request,MOBILEPHONE:blank',
  'validationErrorMessage' => 'В форме содержатся ошибки!',
  'successMessage' => 'Сообщение успешно отправлено'
]}
{'!AjaxForm' | snippet : [
  'snippet' => 'FormIt',
  'form' => '@FILE chunks/modals/popup-availability.tpl',
  'hooks' => 'check_words_and_links,create_request,create_bitrix_lead',
  'customValidators' => 'checkPhone,check_request',
  'validate' => 'PHONE:required:checkPhone:check_request,MOBILEPHONE:blank',
  'validationErrorMessage' => 'В форме содержатся ошибки!',
  'successMessage' => 'Сообщение успешно отправлено'
]}
{'!AjaxForm' | snippet : [
  'snippet' => 'FormIt',
  'form' => '@FILE chunks/modals/popup-order.tpl',
  'hooks' => 'check_words_and_links,create_request,create_bitrix_lead',
  'customValidators' => 'checkPhone,check_request',
  'validate' => 'PHONE:required:checkPhone:check_request,MOBILEPHONE:blank',
  'validationErrorMessage' => 'В форме содержатся ошибки!',
  'successMessage' => 'Сообщение успешно отправлено'
]}
{'!AjaxForm' | snippet : [
'snippet' => 'createReview',
'form' => '@FILE chunks/modals/popup-review.tpl',
'customValidators' => 'checkPhone,check_request',
'validate' => 'NAME:required,TEXT:required',
'validationErrorMessage' => 'В форме содержатся ошибки!',
'successMessage' => 'Сообщение успешно отправлено'
]}
