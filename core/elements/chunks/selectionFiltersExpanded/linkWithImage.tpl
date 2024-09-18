<div class="custom-selections__tag">
<a href="{$link}" class="custom-selections__tag-link">
  {set $visual = $_modx->runSnippet("getVisualWizard",
    [
      "options" => "cvet,ottenok",
      "context"=> "",
      "name"=> $selectionLink.name
    ]
  )}
  <div class="custom-selections__tag-background wizard-background" data-color="{$visual['value']}" data-val="{$selectionLink.name}"></div>
  <div class="custom-selections__tag-title">
          {$selectionLink.name}
  </div>
</a>
</div>
