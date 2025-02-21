<div class="custom-selections__block">
  <div class="custom-selections__tags"> 
    {$output}
    {if ($_modx->resource.context_key != 'web')}
    <li class="custom-selections__toggle">
        <div class="custom-selections__toggle-button"></div>
    </li>
    {/if}
  </div>
</div>
