{if isset($linksData)}
    {if $colorsSorted?}
        <div class="product__select-wrap">
            <div class="product__select-other-color-span">
                Цветовая палитра:
            </div>
            <div class="custom-select-other-color-wrap">
                <div class="colors-options custom-select_scrollable">
                    {foreach $colorsSorted as $id => $val}
                        <a href="{$_modx->makeUrl($id, '', '', 'full')}" data-product="{$id}" class="colors-select__option euv-custom-select__option" data-val="{$val}" data-value="{$val}">
                            <span class="colors-select__option-title">
                                {$val}
                            </span>
                        </a>
                    {/foreach}
                </div>
            </div>
        </div>
    {/if}
{/if}