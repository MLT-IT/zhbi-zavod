<div class="bordered-block">
    {switch $header.type}
    {case "stock"}
    <div class="mb-8 d-flex gap-8 stocks-template--{$header.type}">
            <svg width=" 16" height="16" class="svg icon-available" xmlns="http://www.w3.org/2000/svg"
        xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
        <use xlink:href="/assets/template/img/svg-sprite.svg#icon-available"></use>
        </svg>
        <div>
            <span class="fw-700 color-success">{$header.title}</span>{if $countStocks} на {$countStocks | declension : 'складе|склад|складах' :
            true}:{/if}
        </div>
    </div>
    {if $_modx->getPlaceholder('localdata').main_contacts.email_prefix != "krasnodar"}
    <table class="mb-8 w-max-content">
        <tbody>
            {foreach $stocks['stocks'] as $stock}
            {include "file:modules/stocks/chunks/item-stock.tpl" stock=$stock}
            {/foreach}
            {foreach $stocks['limitStocks'] as $stock}
            {include "file:modules/stocks/chunks/item-stock.tpl" stock=$stock}
            {/foreach}
        </tbody>
    </table>
    {/if}

    {case "limit"}
    <div class="d-flex gap-8 stocks-template--{$header.type}">
        <svg width="14" height="13" viewBox="0 0 14 13" fill="none" xmlns="http://www.w3.org/2000/svg">
            <mask id="mask0_39_210" style="mask-type:luminance" maskUnits="userSpaceOnUse" x="0" y="0" width="14"
                height="13">
                <path
                    d="M7.00009 12.3333C7.76627 12.3343 8.52509 12.1838 9.23294 11.8906C9.9408 11.5974 10.5837 11.1672 11.1248 10.6247C11.6673 10.0837 12.0975 9.44071 12.3907 8.73285C12.6839 8.02499 12.8344 7.26618 12.8334 6.49999C12.8344 5.73381 12.6839 4.97499 12.3907 4.26714C12.0975 3.55928 11.6673 2.91634 11.1248 2.37524C10.5837 1.83279 9.9408 1.4026 9.23294 1.10939C8.52509 0.816173 7.76627 0.665716 7.00009 0.666661C6.2339 0.665716 5.47509 0.816173 4.76723 1.10939C4.05937 1.4026 3.41643 1.83279 2.87534 2.37524C2.33288 2.91634 1.90269 3.55928 1.60948 4.26714C1.31626 4.97499 1.16581 5.73381 1.16675 6.49999C1.16581 7.26618 1.31626 8.02499 1.60948 8.73285C1.90269 9.44071 2.33288 10.0837 2.87534 10.6247C3.41643 11.1672 4.05937 11.5974 4.76723 11.8906C5.47509 12.1838 6.2339 12.3343 7.00009 12.3333Z"
                    fill="white" stroke="white" stroke-width="0.75" stroke-linejoin="round" />
                <path fill-rule="evenodd" clip-rule="evenodd"
                    d="M7.00016 10.2916C7.19355 10.2916 7.37902 10.2148 7.51576 10.0781C7.65251 9.94133 7.72933 9.75587 7.72933 9.56248C7.72933 9.36909 7.65251 9.18363 7.51576 9.04688C7.37902 8.91014 7.19355 8.83331 7.00016 8.83331C6.80678 8.83331 6.62131 8.91014 6.48456 9.04688C6.34782 9.18363 6.271 9.36909 6.271 9.56248C6.271 9.75587 6.34782 9.94133 6.48456 10.0781C6.62131 10.2148 6.80678 10.2916 7.00016 10.2916Z"
                    fill="black" />
                <path d="M7 3V7.66667" stroke="black" stroke-width="0.75" stroke-linecap="round"
                    stroke-linejoin="round" />
            </mask>
            <g mask="url(#mask0_39_210)">
                <path d="M0 -0.5H14V13.5H0V-0.5Z" fill="#F9CD4A" />
            </g>
        </svg>
        <div>
            <span class="fw-700">{$header.title}</span>
        </div>
    </div>
    <table class="mb-8 w-max-content">
        <tbody>
            {foreach $stocks['limitStocks'] as $stock}
            {include "file:modules/stocks/chunks/item-stock.tpl" stock=$stock type="notCount"}
            {/foreach}
        </tbody>
    </table>

    {if $stocks['notStocks']}
    <div class="d-flex gap-8 stocks-template--{$header.type}">
        <svg width="14" height="15" viewBox="0 0 14 15" fill="none" xmlns="http://www.w3.org/2000/svg">
            <rect y="0.5" width="14" height="14" rx="7" fill="#DFDFDF" />
            <path
                d="M5.50443 6.48449L5.72772 7.29221C5.93799 8.0531 6.04291 8.43377 6.35204 8.60676C6.66116 8.78018 7.05353 8.67786 7.83827 8.47409L8.6707 8.25731C9.45544 8.05354 9.84781 7.95165 10.0264 7.65206C10.2051 7.35204 10.1001 6.97138 9.88943 6.21049L9.66658 5.4032C9.45631 4.64188 9.35095 4.26121 9.04226 4.08822C8.7327 3.9148 8.34033 4.01712 7.55559 4.22132L6.72316 4.43724C5.93842 4.64101 5.54605 4.74333 5.36786 5.04335C5.18924 5.34294 5.29416 5.7236 5.50443 6.48449Z"
                fill="#959595" />
            <path
                d="M2.34504 4.97442C2.35646 4.93325 2.37589 4.89472 2.40221 4.86106C2.42853 4.82739 2.46123 4.79925 2.49843 4.77823C2.53564 4.75721 2.57662 4.74373 2.61904 4.73856C2.66146 4.73339 2.70448 4.73664 2.74565 4.74811L3.48399 4.95274C3.67962 5.00601 3.85813 5.10898 4.00218 5.25166C4.14622 5.39433 4.25089 5.57186 4.30602 5.76697L5.2386 9.14264L5.3071 9.3798C5.58361 9.48171 5.81661 9.67568 5.96698 9.92911L6.10138 9.88749L9.94703 8.88814C9.98837 8.87738 10.0314 8.87487 10.0737 8.88075C10.116 8.88662 10.1568 8.90077 10.1936 8.92239C10.2304 8.94401 10.2627 8.97268 10.2884 9.00675C10.3142 9.04082 10.333 9.07963 10.3437 9.12096C10.3545 9.1623 10.357 9.20535 10.3511 9.24766C10.3453 9.28996 10.3311 9.3307 10.3095 9.36754C10.2879 9.40437 10.2592 9.43659 10.2251 9.46235C10.1911 9.48811 10.1523 9.50691 10.1109 9.51767L6.27957 10.5131L6.1365 10.5573C6.1339 11.108 5.75367 11.6118 5.17834 11.7609C4.48898 11.9404 3.78011 11.5432 3.59542 10.8747C3.41072 10.2062 3.82 9.5181 4.50936 9.33904C4.54375 9.33037 4.578 9.32286 4.61211 9.3165L3.6791 5.93995C3.65386 5.85326 3.60669 5.77455 3.54213 5.71144C3.47757 5.64832 3.39781 5.60293 3.31057 5.57967L2.57179 5.3746C2.53062 5.36322 2.4921 5.34384 2.45842 5.31757C2.42474 5.2913 2.39657 5.25865 2.37551 5.22148C2.35446 5.18432 2.34093 5.14338 2.3357 5.10099C2.33047 5.05859 2.33364 5.01559 2.34504 4.97442Z"
                fill="#959595" />
        </svg>
        <div>
            <span class="fw-700">Под запрос</span>
        </div>
    </div>
    <div class="d-flex gap-8 stocks-template__delivery">
        <span class="fw-400">Доставим в течение 1-2 дней</span>
    </div>
    <table class="mb-8 w-max-content">
        <tbody>
            {foreach $stocks['notStocks'] as $stock}
            {include "file:modules/stocks/chunks/item-stock.tpl" stock=$stock type="notCount" modal=true}
            {/foreach}
        </tbody>
    </table>
    {/if}
    {case "not"}
    <div class="d-flex gap-8 stocks-template--{$header.type}">
        <svg width="14" height="15" viewBox="0 0 14 15" fill="none" xmlns="http://www.w3.org/2000/svg">
            <rect y="0.5" width="14" height="14" rx="7" fill="#DFDFDF" />
            <path
                d="M5.50443 6.48449L5.72772 7.29221C5.93799 8.0531 6.04291 8.43377 6.35204 8.60676C6.66116 8.78018 7.05353 8.67786 7.83827 8.47409L8.6707 8.25731C9.45544 8.05354 9.84781 7.95165 10.0264 7.65206C10.2051 7.35204 10.1001 6.97138 9.88943 6.21049L9.66658 5.4032C9.45631 4.64188 9.35095 4.26121 9.04226 4.08822C8.7327 3.9148 8.34033 4.01712 7.55559 4.22132L6.72316 4.43724C5.93842 4.64101 5.54605 4.74333 5.36786 5.04335C5.18924 5.34294 5.29416 5.7236 5.50443 6.48449Z"
                fill="#959595" />
            <path
                d="M2.34504 4.97442C2.35646 4.93325 2.37589 4.89472 2.40221 4.86106C2.42853 4.82739 2.46123 4.79925 2.49843 4.77823C2.53564 4.75721 2.57662 4.74373 2.61904 4.73856C2.66146 4.73339 2.70448 4.73664 2.74565 4.74811L3.48399 4.95274C3.67962 5.00601 3.85813 5.10898 4.00218 5.25166C4.14622 5.39433 4.25089 5.57186 4.30602 5.76697L5.2386 9.14264L5.3071 9.3798C5.58361 9.48171 5.81661 9.67568 5.96698 9.92911L6.10138 9.88749L9.94703 8.88814C9.98837 8.87738 10.0314 8.87487 10.0737 8.88075C10.116 8.88662 10.1568 8.90077 10.1936 8.92239C10.2304 8.94401 10.2627 8.97268 10.2884 9.00675C10.3142 9.04082 10.333 9.07963 10.3437 9.12096C10.3545 9.1623 10.357 9.20535 10.3511 9.24766C10.3453 9.28996 10.3311 9.3307 10.3095 9.36754C10.2879 9.40437 10.2592 9.43659 10.2251 9.46235C10.1911 9.48811 10.1523 9.50691 10.1109 9.51767L6.27957 10.5131L6.1365 10.5573C6.1339 11.108 5.75367 11.6118 5.17834 11.7609C4.48898 11.9404 3.78011 11.5432 3.59542 10.8747C3.41072 10.2062 3.82 9.5181 4.50936 9.33904C4.54375 9.33037 4.578 9.32286 4.61211 9.3165L3.6791 5.93995C3.65386 5.85326 3.60669 5.77455 3.54213 5.71144C3.47757 5.64832 3.39781 5.60293 3.31057 5.57967L2.57179 5.3746C2.53062 5.36322 2.4921 5.34384 2.45842 5.31757C2.42474 5.2913 2.39657 5.25865 2.37551 5.22148C2.35446 5.18432 2.34093 5.14338 2.3357 5.10099C2.33047 5.05859 2.33364 5.01559 2.34504 4.97442Z"
                fill="#959595" />
        </svg>
        <div>
            <span class="fw-700">{$header.title}</span>
        </div>
    </div>
    <div class="d-flex gap-8 stocks-template__delivery">
        <span class="fw-400">{$header.delivery}</span>
    </div>
    <table class="mb-8 w-max-content">
        <tbody>
            {foreach $stocks['notStocks'] as $stock}
            {include "file:modules/stocks/chunks/item-stock.tpl" stock=$stock type="notCount" modal=true}
            {/foreach}
        </tbody>
    </table>
    {/switch}


    <div class="product-card__delivery">
        <span data-fancybox="" data-src="#cost-delivery" class="product-card__delivery-link">
            <svg class="svg icon-delivery" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
                version="1.1">
                <use xlink:href="/assets/template/img/svg-sprite.svg#icon-delivery"></use>
            </svg>
            Узнать стоимость с доставкой
        </span>
    </div>
</div>