{if isset($linksData)}
    {if $colorsSorted?}
    <div class="product__select-other-color">
        <div class="product__select-wrap">
            <div class="product__select-other-color-span">
                Цветовая палитра:
            </div>
            <div class="custom-select-other-color-wrap">
                <div class="colors-options custom-select_scrollable">
                    {foreach $colorsSorted as $id => $val}
                        {set $visual = $_modx->runSnippet("getVisualWizard",
                        [
                            "options" => "cvet,ottenok",
                            "context"=> "",
                            "name"=> $val
                            ]
                        )}
                        <a href="{$_modx->makeUrl($id, '', '', 'full')}" style="background:{$visual['value']}" data-product="{$id}" class="colors-select__option euv-custom-select__option" data-val="{$val}" data-value="{$val}">
                            <span class="colors-select__option-title">
                                {$val}
                            </span>
                        </a>
                    {/foreach}
                </div>
            </div>
        </div>
    </div>

    {elseif $_modx->context.key == 'fibrofasad'}
        <div class="product__select-other-color">
            <div class="product__select-wrap">
                <div class="product__select-other-color-span">
                    Цветовая палитра:
                </div>
                <div class="custom-select-other-color-wrap">
                    <div class="colors-options custom-select_scrollable">
                        {foreach $linksData['ottenok']['items'] as $item}
                            
                            {set $visual = $_modx->runSnippet("getVisualWizard",
                            [
                                "options" => "ottenok",
                                "context"=> "",
                                "name"=> $item['value']
                                ]
                            )}
                            <a href="{$_modx->makeUrl($item['product_id'], '', '', 'full')}" style="background:{$visual['value']}" data-product="{$item['product_id']}" class="colors-select__option euv-custom-select__option" data-val="{$item['value']}" data-value="{$item['value']}">
                                <span class="colors-select__option-title">
                                    {$item['value']}
                                </span>
                            </a>
                        {/foreach}
                    </div>
                </div>
            </div>
        </div>
    {/if}
{/if}