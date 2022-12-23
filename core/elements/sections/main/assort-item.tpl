<div class="assort__item{$itemAdditionalClass}">
    {if $item['img']?}
      <a href="{$item['uri']}" class="assort__item-img-wrap">
        <img class="assort__item-img" src="{$item['img']}">
      </a>
    {/if}
    {if $item['uri']?}
      <a href="{$item['uri']}" class="assort__item-title{$titleAdditionalClass}">{$title}</a>
    {else}
      <span class="assort__item-title{$titleAdditionalClass}">{$title}</span>
    {/if}
  <div class="assort__item-links-wrap">
      {foreach $item['links'] as $linkTitle => $linkUri}
        <a class="assort__item-link" href="{$linkUri}">{$linkTitle}</a>
      {/foreach}
  </div>
</div>
