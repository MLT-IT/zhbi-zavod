{set $items = '@FILE snippets/assortItems.php' | snippet}

<section class="assort wrapper assort_active_sidebar">
    {if $skipHeader is empty}
        <h2 class="title-2">Наш ассортимент</h2>
    {/if}
    <div class="assort__tabs">
        <div class="assort__sidebar">
            {set $isFirst = true}
            {foreach $items as $key => $val}
                <span data-tab="{$val['id']}" class="assort__sidebar-item{if $isFirst?} active{/if}">
                    <svg class="assort__svg">
                        <use xlink:href="/assets/template/img/svg-sprite.svg#{$val['id']}"></use>
                    </svg>
                    {$key}
                </span>
                {set $isFirst = false}
            {/foreach}
        </div>
        <div class="assort__contents-wrap">
            <div class="assort__back">
                <span class="assort__back-btn"></span>
                <span class="assort__back-text">Какой-то текст</span>
            </div>
            {set $isFirst = true}
            {foreach $items as $key => $val}
                <div data-tab="{$val['id']}" class="assort__content{if $isFirst?} active{/if}">
                    {foreach $val['items'] as $title => $item}
                        <div class="assort__item">
                            <div class="assort__item-img-wrap">
                                <img class="assort__item-img" src="{$item['img']}" alt="">
                            </div>
                            {if $item['uri']?}
                                <a href="{$item['uri']}" class="assort__item-title">{$title}</a>
                            {else}
                                <span class="assort__item-title">{$title}</span>
                            {/if}
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
</section>
