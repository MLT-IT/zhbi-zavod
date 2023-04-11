{* Вынес в отдельный чанк, чтобы удобнее было работать, т.к. тут много кода *}

{* Определяем, какие опции будут выводиться *}
{if $prodValues['context_key'] == 'web'}
    {set $charsValues = [
        $prodValues['razmer'][0],
        $prodValues['proizvoditel'][0],
        $prodValues['kolvo_na_poddone'][0],
    ]}
    {set $charsHeaders = [
        'Размер, мм',
        'Производитель',
        'Кол-во на поддоне, шт.'
    ]}
{/if}

{* Вывод опций *}
{foreach $charsValues as $key => $value}
    {if $value ?}
        <div class="product-card__stat">
            <span class="product-card__stat-name">
                {$charsHeaders[$key]}:
            </span>
            <span class="product-card__stat-value">
              {* На всякий случай делаем join, вдруг значение - это массив. Ну а если нет, то со значением ничего не будет *}
              {$value | join : ', '}
            </span>
        </div>
    {/if}
{/foreach}
