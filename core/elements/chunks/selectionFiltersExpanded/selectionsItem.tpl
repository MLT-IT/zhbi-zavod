<li class="custom-selections__tag">
    <a href="{$uri}" class="custom-selections__tag-link">
        <div class="custom-selections__tag-picture">
        {set $image = $mainImage ?: $_pls['mainImage']}
        {if $image}
            {set $src = 'phpthumbon' | snippet : [
                'input' => $image,
                'options' => '&w=60&h=60&zc=1'
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
            {if $visual['type'] == 'image' && $visual['value'] is not empty}
                {set $src = 'phpthumbon' | snippet : [
                    'input' => $visual['value'],
                    'options' => '&w=60&h=60&zc=1'
                ]}
                <img class="custom-selections__tag-image" src="{$src}" alt="">
            {elseif $visual['type'] == 'color' && $visual['value'] is not empty}
                <div class="custom-selections__tag-background wizard-background" data-color="{$visual['value']}" data-val="{$menutitle}"></div>
            {/if}
        {/if}
        </div>
        <div class="custom-selections__tag-name">{$_pls['tagName'] ?: $menutitle}</div>
    </a>
</li>
