
{if $_modx->context.key == 'plitnye' }
  {set $raspil_advs = '@FILE snippets/fromJSON.php' | snippet: ['input' => 'raspil/plitnye/advan.json']}  
{else}
{/if}


{if $raspil_advs}
<div class="{$styleClass ? ' ' ~ $styleClass : ''}">
  {foreach $raspil_advs as $item}
    <div class="raspil__advantages__item advantage">
      <div class="raspil__advantage__icon"><img class="raspil__advantage__icon-image" src="{$item.image}"></div>
      <p class="raspil__advantage__text">{$item.text}</p>
    </div>
  {/foreach}
</div>
{/if}
