<section class="sect-listing wrapper">
    <div id="pdopage" class="sect-listing__content">
        <div class="listing__products-list rows grid">
            {set $params = [
                'element' => 'msProducts',
                'tpl' => "@FILE sections/category/listing-products-item.tpl",
                'ajax' => 1,
                'limit' => 42,
                'sort' => 'tv|priority1:asc,tv|HitsPage:asc',
                'includeTVs' => 'priority1,HitsPage,isFractional',
                'context' => $_modx->resource.context_key,

                'optionFilters' => $_modx->getPlaceholder('mspcs.option'),
                'where' => $_modx->getPlaceholder('mspcs.where'),

                'ajaxMode' => 'button',
                'ajaxElemMore' => "#pdopage .btn_more",
                'ajaxTplMore' => '@INLINE <button class="btn btn-default btn_more">Показать еще</button>',

                'setMeta' => 0,
            ]}
            {'!pdoPage' | snippet : $params}
        </div>

        {$_modx->getPlaceholder('page.nav')}
    </div>

    {'!AjaxForm' | snippet : [
        'hooks' => 'create_bitrix_lead',
        'snippet' => 'FormIt',
        'form' => '@FILE sections/catalog/catalog-banner.tpl',
        'customValidators' => 'checkPhone',
        'validate' => 'PHONE:required:checkPhone',
        'validationErrorMessage' => 'В форме содержатся ошибки!',
        'successMessage' => 'Сообщение успешно отправлено',
    ]}
    <div class="hidden-data">
        <span id="pdopage_total">{'page.total' | placeholder ?: 0}</span>
        <span id="mse2_total">{$total ?: 0}</span>
    </div>
</section>
