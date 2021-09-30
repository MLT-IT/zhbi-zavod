{'!AjaxForm' | snippet : [
'snippet' => 'FormIt',
'form' => '@FILE elements/modals/callback/form.tpl',
'hooks' => 'create_bitrix_lead',
'customValidators' => 'checkPhone',
'validate' => 'PHONE:required:checkPhone'
]}
