<section class="sect-map">
    <div class="map{if $classToMap?} {$classToMap}{/if}">
        <div class="wrapper{if $classToWrapper?} {$classToWrapper}{/if}">
            {if $_modx->context.key === 'pro-fanera'}
                <h2 class="title-2">География работы</h2>
                <div class="map__container">
                    <iframe src="https://yandex.ru/map-widget/v1/?z=12&ol=biz&oid=54568639872" width="560" height="400" frameborder="0"></iframe>
                </div> 
            {else}
                <h2 class="title-2">Склады с которых мы возим</h2>
                <div class="map__container" id="districts_map" data-map-script="districts_map"></div>
            {/if}
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
        'hooks' => 'check_words_and_links,create_request,create_bitrix_lead,create_calltouch_lead',
        'customValidators' => 'checkPhone,check_request,mobilephone:blank',
        'validate' => 'PHONE:required:checkPhone:check_request,mobilephone:blank',
        'validationErrorMessage' => 'В форме содержатся ошибки!',
        'successMessage' => 'Сообщение успешно отправлено'
    ]}
</section>
