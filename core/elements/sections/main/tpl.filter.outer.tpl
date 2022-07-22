{var $key = $table ~ $delimeter ~ $filter}

<div class="sect-mainlist__fblock{if $keyClass?} filter_type_{$keyClass}{/if}{if $dontActive?}{else} active{/if}" id="mse2_{$key}">
    <span class="sect-mainlist__fblock-title">{('mse2_filter_' ~ $table ~ '_' ~ $filter) | lexicon}:</span>
    {$rows}

    {* Модификатор регулярного выражения "m" не нужен, но без него не работает preg_get_all. По-моему, баг в коде fenom *}
    {set $count = $rows | preg_get_all : '/sect-mainlist__filter-label/m' | count}

    {if ($count) > 5}
        <div class="sect-mainlist__btn-more" data-text="Скрыть">Показать еще</div>
    {/if}
</div>
