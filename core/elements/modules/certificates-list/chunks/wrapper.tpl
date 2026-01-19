<!-- {*
 *  @param $certs - Массив сертификатов    
 *} -->

{if $certs}
<div class="certificates-list">
    {foreach $certs as $cert}
        {set $preview = "@FILE modules/certificates-list/snippets/generatePreview.php" | snippet : [
            'src' => $cert['file']
        ]}
        <div class="certificates-list__item">
            <a href="{$cert['file']}" target="_blank">
                {if $preview}
                        {set $thumb = 'phpthumbof' | snippet : [
                            'input' => "{$preview}",
                            'options' => '&h=140&far=1'
                        ]}
                    <img src="{$thumb}" loading="lazy"/>
                {else}
                    <img src="/assets/template/images/other/dummy-pdf.png" loading="lazy" />
                    Посмотреть сертификат
                {/if}
            </a>
        </div>
    {/foreach}
</div>
{/if}