<li class="custom-selections__tag">
    <a href="{$uri}" class="custom-selections__tag-link">
        <div class="custom-selections__tag-picture">
        {set $image = $mainImage ?: $_pls['mainImage']}
        {if $image}
            {set $src = 'phpthumbon' | snippet : [
                'input' => $mainImage,
                'options' => '&w=30&h=30&zc=1'
            ]}
            <img class="custom-selections__tag-image" src="{$src}" alt="">
        {else}
            {set $visual = $_modx->runSnippet("getVisualWizard",
                [
                    "options" => "cvet,ottenok",
                    "context"=> "",
                    "name"=> $menutitle
                ]
            )}
            <div class="custom-selections__tag-background wizard-background" data-color="{$visual['value']}" data-val="{$menutitle}"></div>
        {/if}
        </div>
        <div class="custom-selections__tag-name">{$_pls['tagName'] ?: $menutitle}</div>
    </a>
</li>
