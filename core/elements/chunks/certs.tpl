{if $certs | count}

    <ul class="certs-block">
        {foreach $certs as $ct}
            <li class="certs-block__item">
                {set $previewSrc = ''}
                {set $splitted = $ct.file | split: '.'}
                {set $count = $splitted | count}
                {if $count > 1}
                    {set $lastElem = $splitted[$count - 1] | strtolower}

                    {if $lastElem == 'pdf'}
                        {set $previewSrc = 'pdfToJpg' | snippet : [
                        'src' => '/assets/template/img/import/' ~ $ct.file,
                        ]}
                    {elseif ($lastElem in list ['jpg','jpeg','png','gif','webp'])}
                        {set $previewSrc = '/assets/template/img/import/' ~ $ct.file}
                    {/if}

                    {if $previewSrc ?}
                        {if $h is empty}
                            {set $h = 138}
                        {/if}
                        {set $previewSrc = 'phpthumbon' | snippet : [
                        'input' => $previewSrc,
                        'options' => '&h='~$h~'&far=1'
                        ]}
                    {/if}
                {/if}

                {if $previewSrc is empty}
                    {if $lastElem in list ['dwg','xls','doc', 'rfa', 'odt', 'zip', 'docx']}
                        {set $previewClass = 'certs-block__preview-download'}
                    {else}
                        {set $previewClass = 'certs-block__preview-view'}
                        {set $fancybox = 'data-fancybox'}
                    {/if}
                    <a class="{$previewClass} certs-block__{$lastElem}-preview" {$fancybox} title="{$ct.name}"
                       href="/assets/template/img/import/{$ct.file}"></a>
                {else}
                    <a class="certs-block__cert-preview{if $classToPreview?} {$classToPreview}{/if}" data-fancybox title="{$ct.name}"
                       href="/assets/template/img/import/{$ct.file}">
                        <img class="certs-block__cert-img" src="{$previewSrc}" alt="{$ct.name}">
                    </a>
                {/if}
            </li>
        {/foreach}
    </ul>

{/if}
