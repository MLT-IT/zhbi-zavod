<li class="custom-selections__tag">
    <a href="{$uri}" class="custom-selections__tag-link">
        <div class="custom-selections__tag-picture">
        {set $image = $mainImage ?: $_pls['tv.mainImage']}
        {if $image}
            <img class="custom-selections__tag-image" src="{$image}" alt="">
        {/if}
            {set $visual = $_modx->runSnippet("getVisualWizard",
                [
                    "options" => "cvet,ottenok",
                    "context"=> "",
                    "name"=> $menutitle
                ]
            )}
        <div class="custom-selections__tag-background wizard-background" data-color="{$visual['value']}" data-val="{$menutitle}"></div>
        </div>
        <div class="custom-selections__tag-name">{$_pls['tagName'] ?: $menutitle}</div>
    </a>
</li>
