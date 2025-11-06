<li class="catalog-screen__item catalog-screen__item_type_default">
    <a href="{$uri}" class="catalog-screen__item-link">
        <div class="catalog-screen__item-picture">
        {set $image = $_pls['tv.mainImage'] ?: $mainImage}
        {if $image}
            <img class="catalog-screen__item-image" src="{$image}" alt="{$menutitle}">
        {/if}
            {set $visual = $_modx->runSnippet("getVisualWizard",
                [
                    "options" => "cvet,ottenok",
                    "context"=> "",
                    "name"=> $menutitle
                ]
            )}
        <div class="catalog-screen__item-background wizard-background" data-color="{$visual['value']}" data-val="{$menutitle}"></div>
        </div>
        <div class="catalog-screen__item-name">{$_pls['tagName'] ?: $menutitle}</div>
    </a>
</li>
