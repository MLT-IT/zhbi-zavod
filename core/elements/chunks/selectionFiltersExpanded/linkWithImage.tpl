<div class="custom-selections__tag">
<a href="{$link}" class="custom-selections__tag-link">
  {set $visual = $_modx->runSnippet("getVisualWizard",
    [
      "options" => "cvet,ottenok",
      "context"=> "",
      "name"=> $selectionLink.name
    ]
  )}
  <!-- {$visual|print_r} -->
  {if $visual['type'] == 'image' && $visual['value'] is not empty}
    {set $src = 'phpthumbon' | snippet : [
        'input' => $mainImage,
        'options' => '&w=60&h=60&zc=1'
    ]}
    <img class="custom-selections__tag-image" src="{$src}" alt="">
  {elseif $visual['type'] == 'color' && $visual['value'] is not empty}
    <div class="custom-selections__tag-background wizard-background" data-color="{$visual['value']}" data-val="{$selectionLink.name}"></div>
  {/if}

  {set $image = $selectionLink.category_id | resource : 'mainImage'}
  {if ($_modx->resource.template in list ['4']) && $image}
    {set $src = 'phpthumbon' | snippet : [
        'input' => $image,
        'options' => '&w=60&h=60&zc=1'
    ]}
    <img class="custom-selections__tag-image" src="{$src}" alt="">
  {/if}
  <div class="custom-selections__tag-title">
          {$selectionLink.name}
  </div>
</a>
</div>
