<section class="sect-map">
    <div class="map{if $classToMap?} {$classToMap}{/if}">
        <div class="wrapper{if $classToWrapper?} {$classToWrapper}{/if}">
            <h2 class="title-2">Склады с которых мы возим</h2>
            <div class="map__container" id="districts_map" data-map-script="districts_map"></div>
        </div>
    </div>
</section>

<section class="sect-delcost wrapper">
    {include "file:chunks/svg-gradient.tpl" w=14 h=16}

    <h2 class="title-2">
        <svg stroke="url(#svg-gradient)" fill="transparent" class="svg sect-benefits__item-svg"
             xmlns="http://www.w3.org/2000/svg"
             xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="14" height="16">
            <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-place-2"></use>
        </svg>

        Рассчитать стоимость доставки с ближайшего склада
    </h2>

    {'!AjaxForm' | snippet : [
        'snippet' => 'FormIt',
        'form' => '@FILE chunks/sect-delcost-form.tpl',
        'hooks' => 'create_request,create_bitrix_lead',
        'customValidators' => 'checkPhone,check_request,mobilephone:blank',
        'validate' => 'PHONE:required:checkPhone:check_request,mobilephone:blank',
        'validationErrorMessage' => 'В форме содержатся ошибки!',
        'successMessage' => 'Сообщение успешно отправлено'
    ]}
</section>
