{var $key = $table ~ $delimeter ~ $filter}

<div class="sect-mainlist__fblock{if $keyClass?} filter_type_{$keyClass}{/if}{if $dontActive?}{else} active{/if}" id="mse2_{$key}">
        <div class="sect-mainlist__fblock-title">{('mse2_filter_' ~ $table ~ '_' ~ $filter) | lexicon}:</div>
        {$rows}
</div>
