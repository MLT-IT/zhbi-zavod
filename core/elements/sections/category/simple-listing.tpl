<section class="listing">
    <div class="wrapper">
        <div class="listing__content">
            <div class="listing__products">

                <div id="pdopage">
                    <div class="listing__products-list rows grid">
                        {set $params = [
                            'element' => 'msProducts',
                            'tpl' => "@FILE sections/category/listing-products-item.tpl",
                            'ajaxMode' => 'button',
                            'ajax' => 1,
                            'limit' => 42,
                            'sort' => 'tv|priority1:asc,tv|HitsPage:asc',
                            'includeTVs' => 'priority1,HitsPage,isFractional',
                            'context' => $_modx->resource.context_key,
                            'optionFilters' => $_modx->getPlaceholder('mspcs.option'),
                            'where' => $_modx->getPlaceholder('mspcs.where'),
                            'pageNavVar' => 'page_nav',
                            'ajaxTplMore' => '@INLINE <div class="btn btn-default btn_more">Показать еще</div>',
                            'setMeta' => 0,
                        ]}
                        {'!pdoPage' | snippet : $params}

                        {$_modx->getPlaceholder('page_nav')}
                    </div>
                    <div class="btn btn-default btn_more"></div>
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
                    <span id="mse2_total">{$total ?: 0}</span>
                </div>

            </div>
        </div>
    </div>
</section>
