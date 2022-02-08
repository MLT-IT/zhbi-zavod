<ul class="certs-block">
    {foreach $value as $ct}
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
                    {set $previewSrc = 'phpthumbon' | snippet : [
                    'input' => $previewSrc,
                    'options' => '&w=100&far=1'
                    ]}
                {/if}
            {/if}

            {if $previewSrc is empty}
                <a class="certs-block__pdf-preview" data-fancybox title="{$ct.name}"
                   href="/assets/template/img/import/{$ct.file}"></a>
            {else}
                <a class="certs-block__cert-preview" data-fancybox title="{$ct.name}"
                   href="/assets/template/img/import/{$ct.file}">
                    <img class="certs-block__cert-img" src="{$previewSrc}" alt="{$ct.name}">
                </a>
            {/if}
        </li>
    {/foreach}
</ul>
