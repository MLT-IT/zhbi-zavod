{var $key = $table ~ $delimeter ~ $filter}

<div class="sect-mainlist__fblock-wrap">
    <div class="sect-mainlist__fblock{if $keyClass?} filter_type_{$keyClass}{/if}" id="mse2_{$key}">
        <span class="sect-mainlist__fblock-title">{('mse2_filter_' ~ $table ~ '_' ~ $filter) | lexicon}:</span>
            {$rows}
    </div>
    <div class="sect-mainlist__btn-more hidden" data-text="Скрыть">Показать еще</div>
</div>
