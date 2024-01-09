{if $linksData[$key]?}
    <div class="product-info__select-link mb-4"><span class="product-info__select-link-title">Фасовка:</span>
        <input type="hidden" name="unit" value="1">
        <div class="product-card__select-link">
            <ul class="product-info__select-link-tabs">
                <li class="product-info__select-link-tab js-product__select-link-tab active" data-val="1">{$_modx->resource[$key][0]}</li>
                {foreach $linksData[$key] as $id => $val}
                    {if $_modx->resource[$key][0] != $val}
                        <li class="product-info__select-link-tab js-product__select-link-tab" data-val="{$val['id']}">
                            <a href="{$_modx->makeUrl($id, '', '', 'full')}" class="euv-custom-select__option">
                                {$val}
                            </a>
                        </li>
                    {/if}

                {/foreach}
            </ul>
        </div>
    </div>
{/if}