        <div class="infoblocks__block" data-tab-page="Прайс">
          <button class="infoblocks__block-title" data-tab="Прайс">Прайс</button>
          <div class="infoblocks__block-dropdown custom-content">
            <div class="table product-pricelist">
                {$_modx->runSnippet('msProducts', [
                  'parents' => $_modx->resource.parent,
                  'depth' => 1,
                  'includeOptions' => 1,
                  'context' => $_modx->resource.context_key,
                  'tplWrapper' => '@INLINE
                    <table class="table__table product-pricelist-table">
                      <thead>
                        <tr>
                          <th>Наименование</th>
                          <th>Характеристики</th>
                          <th>Цена</th>
                        </tr>
                      </thead>
                      {$output}
                    </table>
                  ',
                  'tpl' => '@INLINE
                    <tr>
                      <td><a class="link" href="/{$uri}">{$pagetitle}</a></td>
                      <td>
                          <p>Маркировка : {$markirovka[0]}</p>
                          <p>Длина, мм : {$_pls["dlina-mm"][0]}</p>
                          <p>Ширина, мм : {$_pls["shirina-mm"][0]}</p>
                          <p>Высота, мм : {$_pls["vysota-mm"][0]}</p>
                      </td>
                      <td>{$price}</td>
                    </tr>
                  ',
                  'limit' => 0,
                ])}
            </div>
            {* <div class="product-info__delivery-btn infoblocks__bottom"><a class="btn btn_style_shadow" data-fancybox="" href="#callback">заказать с доставкой</a></div> *}
          </div>
        </div>
