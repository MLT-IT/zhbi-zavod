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
                {* Определяем стиль внутренних элементов раздела *}
                {if $val['style'] == 'columns-css'}
                    {set $contentAdditionalClass = ' columns-css'}
                {else}
                    {set $contentAdditionalClass = ' columns-flex'}
                {/if}

                <div data-tab="{$val['id']}" class="assort__content-wrap{$contentAdditionalClass}{if $isFirst?} active{/if}">
                    {* Определяем такие параметры, как: дополнительный класс для заголовка, дополнительный класс для чанка и др. *}
                    {set $itemsCss = ''}
                    {set $itemsFlex = ''}

                    {foreach $val['items'] as $title => $item}
                        {set $titleAdditionalClass = ''}
                        {set $itemAdditionalClass = ''}
                        {if !$item['img']}
                            {set $titleAdditionalClass = ' equal-margins'}
                        {/if}
                        {if $item['fullwidth']}
                            {set $itemAdditionalClass = ' assort__item_fullwidth'}
                        {/if}

                        {set $chunk = $_modx->getChunk('@FILE: sections/main/assort-item.tpl', [
                          'item' => $item,
                          'title' => $title,
                          'itemAdditionalClass' => $itemAdditionalClass,
                          'titleAdditionalClass' => $titleAdditionalClass])
                        }

                        {if $item['fullwidth']}
                            {set $itemsFlex = $itemsFlex ~ $chunk}
                        {else}
                            {if $val['style'] == 'columns-css'}
                                {set $itemsCss = $itemsCss ~ $chunk}
                            {else}
                                {set $itemsFlex = $itemsFlex ~ $chunk}
                            {/if}
                        {/if}
                    {/foreach}

                    {if $itemsFlex ?}
                        <div class="assort__content assort__content_columns-flex">
                            {$itemsFlex}
                        </div>
                    {/if}
                    {if $itemsCss ?}
                        <div class="assort__content assort__content_columns-css">
                            {$itemsCss}
                        </div>
                    {/if}
                </div>
                {set $isFirst = false}
            {/foreach}
        </div>
    </div>
</section>
