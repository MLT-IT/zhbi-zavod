{if $_modx->resource.context_key in list ['web', 'pilomat', 'pro-fanera']}
    {set $colorStart = '#5892FC'}
    {set $colorEnd = '#4F70AD'}
{elseif $_modx->resource.context_key in list ['rockwool', 'krovlya', 'kirpich-m', 'armatura-178', 'asconcrete', 'plitaosb']}
    {set $colorStart = '#e90115'}
    {set $colorEnd = '#aa000f'}
{elseif $_modx->resource.context_key == 'tn'}
    {set $colorStart = '#ed1c24'}
    {set $colorEnd = '#af0e14'}
{elseif $_modx->resource.context_key == 'penoplex'}
    {set $colorStart = '#f36f21'}
    {set $colorEnd = '#bd4d0a'}
{elseif $_modx->resource.context_key == 'isover'}
    {set $colorStart = '#83c320'}
    {set $colorEnd = '#578115'}
{elseif $_modx->resource.context_key == 'paroc'}
    {set $colorStart = '#ce1126'}
    {set $colorEnd = '#870b19'}
{elseif $_modx->resource.context_key == 'ursa'}
    {set $colorStart = '#ea4740'}
    {set $colorEnd = '#c81d16'}
{elseif $_modx->resource.context_key in list ['fasady-pro', 'plity-mdvp']}
    {set $colorStart = '#109654'}
    {set $colorEnd = '#08532e'}
{elseif $_modx->resource.context_key == 'fasad'}
    {set $colorStart = '#deb262'}
    {set $colorEnd = '#c9912a'}
{elseif $_modx->resource.context_key == 'policarbonat'}
    {set $colorStart = '#4cb463'}
    {set $colorEnd = '#2da748'}
{/if}
<div style="height: 0; width: 0; position: absolute; visibility: hidden;">
    <defs>
        <svg viewBox="0 0 {$w} {$h}" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
            <linearGradient id="svg-gradient" gradientTransform="rotate(90)" gradientUnits="userSpaceOnUse">
                <stop offset="0" stop-color="{$colorStart}"/>
                <stop offset="1" stop-color="{$colorEnd}"/>
            </linearGradient>
        </svg>
    </defs>
</div>
