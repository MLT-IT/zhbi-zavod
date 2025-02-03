<div class="product-info__selected-characteristics">

{if $_modx->context.key == 'suhiesmesi' }
    {$_modx->runSnippet("@FILE snippets/linking/linking-select.php", [
    'dependence' => ['cvet', 'ves-shtuki-kg'],
    'coincide' => ['tip', 'proizvoditel'],
    'tplFilter' => [
        'cvet' => '@FILE blocks/product/linking/linking-select-cvet.tpl',
        'ves-shtuki-kg' => '@FILE blocks/product/linking/linking-list-fasovka.tpl'
    ]
    ])}
{/if}

{if $linksData.cvet?}
    <div class="product-card__select-wrap{if $_modx->resource.template == 22} product-card__select-wrap_type_full{else} product-card__select-wrap_type_half{/if}">
        <div class="product-card__select-span">
            {if $_modx->resource.template == 17 || $_modx->context.key == "kraska"}
                Цвет:
            {/if}
            {if $_modx->resource.template in list [20, 22]}
                Оттенок:
            {/if}
        </div>
        <div class="custom-select-wrap">
            <div class="colors-options euv-custom-select euv-custom-select_type_wide custom-select_scrollable">
                <div class="euv-custom-select__input">
                    {set $visual = $_modx->runSnippet("getVisualWizard",
                    [
                        "options" => "cvet,ottenok",
                        "context"=> "",
                        "name"=> $cvet
                    ]
                    )}
                    <span data-val="{$cvet}" class="euv-custom-select__input-value wizard-cube" data-color="{$visual['value']}" >{$cvet}</span>
                </div>
                <span class="euv-custom-select__btn"></span>
                <div class="euv-custom-select__options-wrap">
                    <div class="euv-custom-select__options-wrap-scroll">
                        <div class="euv-custom-select__options-wrap-scroll-inner">
                            {foreach $linksData.cvet as $data}
                                <div class="euv-custom-select__options-col">
                                    {foreach $data as $id => $val}
                                        {set $v = $val}
                                        {set $visual = $_modx->runSnippet("getVisualWizard",
                                            [
                                                "options" => "cvet,ottenok",
                                                "context"=> "",
                                                "name"=> $val
                                            ]
                                        )}
                                        <a href="{$_modx->makeUrl($id, '', '', 'full')}" data-product="{$id}"  data-color="{$visual['value']}" class="euv-custom-select__option wizard-cube" data-val="{$v}" data-value="{$val}">
                                            {$val}
                                        </a>
                                    {/foreach}
                                </div>
                            {/foreach}
                        </div>
                    </div>
                </div>
            </div>
            <div class="custom-select-mobile-link"></div>
            <div href="#select" data-fancybox="" class="custom-select-mobile-link"></div>
        </div>
    </div>
{/if}

{if $linksData.collection?}
    <div class="product-card__select-wrap product-card__select-wrap_type_half">
        <div class="product-card__select-span">Коллекция:</div>
        <div class="custom-select-wrap">
            <div class="euv-custom-select euv-custom-select_type_wide custom-select_scrollable">
                <div class="euv-custom-select__input">
                      <span class="euv-custom-select__input-value">
                          {$_modx->resource.collection[0]}
                      </span>
                </div>
                <span class="euv-custom-select__btn"></span>
                <div class="euv-custom-select__options-wrap">
                    <div class="euv-custom-select__options-wrap-scroll">
                        {foreach $linksData.collection as $id => $val}
                            <a href="{$_modx->makeUrl($id, '', '', 'full')}" class="euv-custom-select__option">
                                {$val}
                            </a>
                        {/foreach}
                    </div>
                </div>
            </div>
            <div class="custom-select-mobile-link"></div>
            <div href="#select" data-fancybox="" class="custom-select-mobile-link"></div>
        </div>
    </div>
{/if}

{if $linksData.item_thickness?}
    <div class="product-card__select-wrap product-card__select-wrap_type_half{if $linksData.cvet?} product-card__select-wrap_align_right{/if}">
        <div class="product-card__select-span">Толщина, мм:</div>
        <div class="custom-select-wrap">
            <div class="euv-custom-select euv-custom-select_type_wide custom-select_scrollable">
                <div class="euv-custom-select__input">
                    <span class="euv-custom-select__input-value">{$_modx->resource.item_thickness[0]}</span>
                </div>
                <span class="euv-custom-select__btn"></span>
                <div class="euv-custom-select__options-wrap">
                    <div class="euv-custom-select__options-wrap-scroll">
                        {foreach $linksData.item_thickness as $id => $val}
                            <a href="{$_modx->makeUrl($id, '', '', 'full')}" class="euv-custom-select__option">
                                {$val}
                            </a>
                        {/foreach}
                    </div>
                </div>
            </div>
            <div class="custom-select-mobile-link"></div>
            <div href="#select" data-fancybox="" class="custom-select-mobile-link"></div>
        </div>
    </div>
{/if}

{if $linksData.pokrytie?}
    <div class="product-card__select-wrap product-card__select-wrap_type_full mt">
        <div class="product-card__select-span">Покрытие:</div>
        <div class="custom-select-wrap">
            <div class="euv-custom-select euv-custom-select_type_wide custom-select_scrollable">
                <div class="euv-custom-select__input">
                    <span class="euv-custom-select__input-value">{$_modx->resource.pokrytie[0]}<span class="euv-custom-select__small-text">{$_modx->resource['vid-poverhnosti'][0]}</span></span>
                </div>
                <span class="euv-custom-select__btn"></span>
                <div class="euv-custom-select__options-wrap">
                    <div class="euv-custom-select__options-wrap-scroll">
                        {foreach $linksData.pokrytie as $id => $val}
                            <a href="{$_modx->makeUrl($id, '', '', 'full')}" class="euv-custom-select__option">
                                {$val} <span class="euv-custom-select__small-text">{$linksData['vid-poverhnosti'][$id]}</span>
                            </a>
                        {/foreach}
                    </div>
                </div>
            </div>
            <div class="custom-select-mobile-link"></div>
            <div href="#select" data-fancybox="" class="custom-select-mobile-link"></div>
        </div>
    </div>
{/if}

{if $linksData.fasovka?}
    <div class="product-info__select-link mb-4"><span class="product-info__select-link-title">Фасовка:</span>
        <input type="hidden" name="unit" value="1">
        <div class="product-card__select-link">
            <ul class="product-info__select-link-tabs">

                {foreach $linksData.fasovka as $id => $val}
                    {if $_modx->resource.fasovka[0] != $val}
                        <li class="product-info__select-link-tab js-product__select-link-tab" data-val="{$val['id']}">
                            <a href="{$_modx->makeUrl($id, '', '', 'full')}" class="euv-custom-select__option">
                                {$val}
                            </a>
                        </li>
                        {else}
                        <li class="product-info__select-link-tab js-product__select-link-tab active" data-val="1">{$_modx->resource.fasovka[0]}</li>
                    {/if}
                {/foreach}
            </ul>
        </div>
    </div>
{/if}

{if $linksData.tip?}
    <div class="product-card__select-wrap product-card__select-wrap_type_half{if $linksData.tip?} product-card__select-wrap_align_right{/if}">
        <div class="product-card__select-span">Тип:</div>
        <div class="custom-select-wrap">
            <div class="euv-custom-select euv-custom-select_type_wide custom-select_scrollable">
                <div class="euv-custom-select__input">
                    <span class="euv-custom-select__input-value">{$_modx->resource.tip[0]}</span>
                </div>
                <span class="euv-custom-select__btn"></span>
                <div class="euv-custom-select__options-wrap">
                    <div class="euv-custom-select__options-wrap-scroll">
                        {foreach $linksData.tip as $id => $val}
                            <a href="{$_modx->makeUrl($id, '', '', 'full')}" class="euv-custom-select__option">
                                {$val}
                            </a>
                        {/foreach}
                    </div>
                </div>
            </div>
            <div class="custom-select-mobile-link"></div>
            <div href="#select" data-fancybox="" class="custom-select-mobile-link"></div>
        </div>
    </div>
{/if}

{set $isParentsCategoriesDobor = 'isParentsCategoriesDobor' | snippet}
{if $linksData.ottenok? && !$isParentsCategoriesDobor && $_modx->resource.context_key in list ['fibrofasad']}
<div class="product-card__select-wrap product-card__select-wrap_type_half">
    <div class="product-info__top"><div class="product-info__grid">
        <div class="product-info__relinkav_wrapper">
        <span class="product-info__volume-title">Оттенок:</span>
        <div class="product-info__relinkav">
            <div class="product-info__euv-custom-select euv-custom-select">
            <div class="euv-custom-select__input">
                <span class="euv-custom-select__input-value">{$linksData.ottenok.selected}</span>
            </div>
            <span class="euv-custom-select__btn"></span>
            <div class="euv-custom-select__options-wrap" style="display: none;">
                {foreach $linksData.ottenok.items as $item}
                    <a href="{$_modx->makeUrl($item['product_id'], '', '', 'full')}" class="euv-custom-select__option">
                        {$item['value']}
                    </a>
                {/foreach}
            </div>
            </div>
        </div>
        </div>
    </div>
</div>
{/if}
