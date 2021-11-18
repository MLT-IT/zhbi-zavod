{$_modx->resource.certs}
{set $certs = $_modx->resource.mainCerts}
{set $certs = json_decode($certs, true)}

{if $certs | count > 0}
    <div class="wrapper sect-serts">
        <h1 class="title-1">Сертификаты</h1>

        <ul class="certs-block">
            {foreach $certs as $ct}
                <li class="certs-block__item">
                    {set $previewSrc = ''}
                    {set $splitted = $ct.file | split: '.'}
                    {set $count = $splitted | count}
                    {if $count > 1}
                        {set $lastElem = $splitted[$count - 1]}

                        {if ($lastElem in list ['jpg','jpeg','png','gif','webp'])}
                            {set $previewSrc = 'phpthumbon' | snippet : [
                            'input' => '/assets/template/img/import/' ~ $ct.file,
                            'options' => '&w=100&far=1'
                            ]}
                        {/if}
                    {/if}

                    {if $previewSrc == ''}
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
        {*<a href="/certs/" class="custom-link">Смотреть все</a>*}
    </div>
{/if}
