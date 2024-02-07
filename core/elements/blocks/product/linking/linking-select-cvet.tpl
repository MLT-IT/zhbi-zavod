
<div class="custom-select-wrap">
    <div class="colors-options euv-custom-select euv-custom-select_type_wide custom-select_scrollable">
        <div class="euv-custom-select__input">
            <span data-val="{$_modx->resource[$key][0]}" class="euv-custom-select__input-value">{$_modx->resource[$key][0]}</span>
        </div>
        <span class="euv-custom-select__btn"></span>
        <div class="euv-custom-select__options-wrap">
            <div class="euv-custom-select__options-wrap-scroll">
                <div class="euv-custom-select__options-wrap-scroll-inner">

                    <div class="euv-custom-select__options-col">
                        {foreach $linksData[$key] as $id => $val}
                            {set $v = $val}
                            <a href="{$_modx->makeUrl($id, '', '', 'full')}" data-product="{$id}" class="euv-custom-select__option" data-val="{$v}" data-value="{$val}">
                                {$val}
                            </a>
                        {/foreach}
                    </div>

                </div>
            </div>
        </div>
    </div>
    <div class="custom-select-mobile-link"></div>
    <div href="#select" data-fancybox="" class="custom-select-mobile-link"></div>
</div>