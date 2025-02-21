<div class="custom-selections">
    {if ($_modx->resource.context_key == 'web')}
        <strong class="custom-selections__title">Часто ищут:</strong> 
    {/if}
    <div class="custom-selections__preview active">
        {'@FILE snippets/getRelinkingTags.php' | snippet : [
            "tplWrapper" => "@FILE chunks/selectionFiltersExpanded/selections.tpl",
            "tpl" => "@FILE chunks/selectionFiltersExpanded/selectionsItem.tpl",
            "limit" => $_modx->resource.count_filter,
            'where' => '{"template:in":[28]}',
            'idTagsBlock' => 'block-4'
        ]}
    </div>

    <div class="custom-selections__groups">
        <div class="custom-selections__groups-wrapper">
            {set $options = [
                'tvField' => "selectionCustomFilters",
                'tplItemLink' => "@FILE chunks/selectionFiltersExpanded/linkNoImage.tpl"
            ]}
            {if ($_modx->resource.context_key == 'web')}
                {set $options['tplItemLink'] = '@FILE chunks/selectionFiltersExpanded/linkWithImage.tpl'}
            {/if}

            {$_modx->runSnippet("@FILE snippets/selectionExpandedFilterLinks.php", $options)}

            {if ($_modx->resource.context_key != 'web')}
                <div class="custom-selections__toggle">
                    <div class="custom-selections__toggle-button active"></div>
                </div>
            {/if}
        </div>
    </div>
    {if ($_modx->resource.context_key == 'web')}
        <div class="custom-selections__toggle">
            <div class="custom-selections__toggle-button"></div>
        </div>
    {/if}
</div>

{* <span class="selection-header">Цветовая палитра</span> *}
<div class="custom-selections custom-selections_colors">
    {* <div class="custom-selections__preview active">
        {$_modx->runSnippet('pdoResources', [
        'tpl' => '@FILE chunks/selectionFiltersExpanded/selectionsItem.tpl',
        'depth' => 0,
        'limit' => $_modx->resource.count_filter_color,
        'sortby' => 'menuindex',
        'sortdir' => 'ASC',
        'tplWrapper' => '@FILE chunks/selectionFiltersExpanded/selections.tpl',
        'tvPrefix' => '',
        'includeTVs' => 'showInDropdownPanel,mainImage',
        'where' => '{"template:in":[27]}',
        'totalVar' => 'total',
        'setTotal' => 1,
        'select' => 'menutitle,uri'
        ])}
    </div> *}
    {* <div class="custom-selections__preview active">
        {$_modx->runSnippet('pdoResources', [
        'tpl' => "@FILE chunks/create-menu/category-item.tpl",
        'depth' => 0,
        'limit' => $_modx->resource.count_filter_color,
        'sortby' => 'menuindex',
        'sortdir' => 'ASC',
        'tplWrapper' => '@FILE chunks/selectionFiltersExpanded/selections.tpl',
        'tvPrefix' => '',
        'includeTVs' => 'showInDropdownPanel,mainImage',
        'where' => '{"template:in":[27]}',
        'totalVar' => 'total',
        'setTotal' => 1,
        'select' => 'menutitle,uri'
        ])}
    </div> *}
    {* <div class="custom-selections__preview active">
        {'@FILE snippets/getRelinkingTags.php' | snippet : [
            "tplWrapper" => "@FILE chunks/selectionFiltersExpanded/selections.tpl",
            "tpl" => "@FILE chunks/selectionFiltersExpanded/selectionsItem.tpl",
            "limit" => $_modx->resource.count_filter_color,
            'where' => '{"template:in":[27]}',
            'idTagsBlock' => 'block-5'
        ]}
    </div>
    <div class="custom-selections__groups">
        <div class="custom-selections__groups-wrapper">
            {$_modx->runSnippet("@FILE snippets/selectionExpandedFilterLinks.php", [
                'tvField' => "selectionCustomFiltersColors",
                'tplItemLink' => "@FILE chunks/selectionFiltersExpanded/linkWithImage.tpl"
            ])}
            <div class="custom-selections__toggle">
                <div class="custom-selections__toggle-button active"></div>
            </div>
        </div>
    </div> *}
</div>
