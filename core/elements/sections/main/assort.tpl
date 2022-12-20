{set $items = '@FILE snippets/assortItems.php' | snippet}

<section class="assort wrapper assort_active_sidebar">
    {if $skipHeader is empty}
        <h2 class="title-2">Наш ассортимент</h2>
    {/if}
    <div class="assort__tabs">
        <div class="assort__sidebar">
            {set $isFirst = true}

            {foreach $items as $key => $val}
                {set $svg = $val['id']}
                {if $svg in list ['assort-natur-cerepica-1', 'assort-natur-cerepica-2']}
                    {set $svg = 'assort-natur-cerepica'}
                {/if}

                <span data-tab="{$val['id']}" class="assort__sidebar-item{if $isFirst?} active{/if}">
                    <svg class="assort__svg">
                        <use xlink:href="/assets/template/img/svg-sprite.svg#{$svg}"></use>
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
                {if $val['id'] in list ['assort-soputtovary', 'assort-dobor']}
                    {set $contentAdditionalClass = ' columns-css'}
                {else}
                    {set $contentAdditionalClass = ' columns-flex'}
                {/if}

                <div data-tab="{$val['id']}" class="assort__content{$contentAdditionalClass}{if $isFirst?} active{/if}">
                    {foreach $val['items'] as $title => $item}
                        {set $titleAdditionalClass = ''}
                        {if !$item['img']}
                            {set $titleAdditionalClass = ' equal-margins'}
                        {/if}
                        {set $itemAdditionalClass = ''}
                        {if $item['fullwidth']}
                            {set $itemAdditionalClass = ' assort__item_fullwidth'}
                        {/if}

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
                    {/foreach}
                </div>
                {set $isFirst = false}
            {/foreach}
        </div>
    </div>
</section>
