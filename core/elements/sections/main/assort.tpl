{set $items = '@FILE snippets/assortItems.php' | snippet}

<section class="assort">
    <div class="wrapper">
        <h2 class="title-2">Наш ассортимент</h2>
        <div class="assort__tabs">
            <div class="assort__sidebar">
                {set $isFirst = true}
                {foreach $items as $key => $nevermind}
                    <span data-tab="{$key | toLowerAndRemoveChars}" class="assort__sidebar-item{if $isFirst?} active{/if}">{$key}</span>
                    {set $isFirst = false}
                {/foreach}
            </div>
            <div class="assort__contents-wrap">
                {set $isFirst = true}
                {foreach $items as $key => $items}
                    <div data-tab="{$key | toLowerAndRemoveChars}" class="assort__content{if $isFirst?} active{/if}">
                        {foreach $items as $title => $item}
                            <div class="assort__item">
                                <div class="assort__item-img-wrap">
                                    <img class="assort__item-img" src="{$item['img']}" alt="">
                                </div>
                                <p class="assort__item-title">{$title}</p>
                                <div class="assort__item-links-wrap">
                                    {foreach $item['links'] as $linkTitle => $linkUri}
                                        <a class="assort__item-link" href="{$linkUri}">{$linkTitle}</a>
                                    {/foreach}
                                </div>
                            </div>
                        {/foreach}
                    </div>
                    {set $isFirst = false}
                {/foreach}
            </div>
        </div>
    </div>
</section>
