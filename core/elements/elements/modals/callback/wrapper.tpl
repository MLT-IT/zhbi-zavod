{'!AjaxForm' | snippet : [
'snippet' => 'FormIt',
'form' => '@FILE elements/modals/callback/popup-callback.tpl',
'hooks' => 'check_words_and_links,create_request,create_bitrix_lead',
'customValidators' => 'checkPhone,check_request',
'validate' => 'PHONE:required:checkPhone:check_request,mobilephone:blank',
'validationErrorMessage' => 'В форме содержатся ошибки!',
'successMessage' => 'Сообщение успешно отправлено'
]}

{if !$_modx->getPlaceholder('utm_source')}
    {'!AjaxForm' | snippet : [
    'snippet' => 'FormIt',
    'form' => '@FILE elements/modals/callback/popup-discount.tpl',
    'hooks' => 'check_words,create_request,create_bitrix_lead',
    'customValidators' => 'checkPhone,check_request',
    'validate' => 'PHONE:required:checkPhone:check_request,mobilephone:blank',
    'validationErrorMessage' => 'В форме содержатся ошибки!',
    'successMessage' => 'Сообщение успешно отправлено'
    ]}
{/if}

{'!AjaxForm' | snippet : [
'snippet' => 'FormIt',
'form' => '@FILE elements/modals/callback/popup-cost-delivery.tpl',
'hooks' => 'check_words_and_links,create_request,create_bitrix_lead',
'customValidators' => 'checkPhone,check_request',
'validate' => 'PHONE:required:checkPhone:check_request,mobilephone:blank',
'validationErrorMessage' => 'В форме содержатся ошибки!',
'successMessage' => 'Сообщение успешно отправлено'
]}

{'!AjaxForm' | snippet : [
'snippet' => 'FormIt',
'form' => '@FILE elements/modals/callback/popup-order.tpl',
'hooks' => 'check_words_and_links,create_request,create_bitrix_lead',
'customValidators' => 'checkPhone,check_request',
'validate' => 'PHONE:required:checkPhone:check_request,mobilephone:blank',
'validationErrorMessage' => 'В форме содержатся ошибки!',
'successMessage' => 'Сообщение успешно отправлено'
]}

{'!AjaxForm' | snippet : [
'snippet' => 'FormIt',
'form' => '@FILE elements/modals/callback/popup-showroom.tpl',
'hooks' => 'check_words_and_links,create_request,create_bitrix_lead',
'customValidators' => 'checkPhone,check_request',
'validate' => 'PHONE:required:checkPhone:check_request,mobilephone:blank',
'validationErrorMessage' => 'В форме содержатся ошибки!',
'successMessage' => 'Сообщение успешно отправлено'
]}

{'!AjaxForm' | snippet : [
'snippet' => 'FormIt',
'form' => '@FILE elements/modals/callback/help-in-choice.tpl',
'hooks' => 'check_words_and_links,create_request,create_bitrix_lead',
'customValidators' => 'checkPhone,check_request',
'validate' => 'PHONE:required:checkPhone:check_request,mobilephone:blank',
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

{if ($_modx->resource.template === 21)}
    {'!AjaxForm' | snippet : [
    'snippet' => 'FormIt',
    'form' => '@FILE elements/modals/callback/popup-cost-fanera.tpl',
    'hooks' => 'check_words_and_links,create_request,create_bitrix_lead',
    'customValidators' => 'checkPhone,check_request',
    'validate' => 'PHONE:required:checkPhone:check_request,mobilephone:blank',
    'validationErrorMessage' => 'В форме содержатся ошибки!',
    'successMessage' => 'Сообщение успешно отправлено'
    ]}
{/if}

{if ($_modx->resource.template in list [17, 20, 22])}
    {include 'file:elements/modals/callback/popup-select.tpl'}
{/if}
