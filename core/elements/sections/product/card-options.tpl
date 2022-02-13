{if $options | length > 0}
    <div class="pop-slide__options-wrap pop-slide__options-wrap_type_default">
        {foreach $options as $option}
            {*if $option.key not in list ['edizm', 'edizm2', 'upakovka', 'price2']*}
                <div class="pop-slide__option" data-title="{$option.caption}">
                    <div class="pop-slide__option-caption">{$option.caption}</div>
                    <div class="pop-slide__option-value">
                        {if $option.value is array}
                            {$option.value | join : ', '}
                        {else}
                            {$option.value}
                        {/if}
                    </div>
                </div>
            {*/if*}
        {/foreach}
    </div>
{/if}
