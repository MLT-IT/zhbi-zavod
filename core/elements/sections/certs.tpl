{set $certs = ('site_start' | option) | resource: 'mainCerts'}
{set $certs = json_decode($certs, true)}

{if $certs | count > 0}
    <div class="wrapper sect-serts">
        <h2 class="title-1">Сертификаты</h2>

        {include 'file:blocks/certs.tpl' h='283' classToPreview='cursor-zoom'}

        {*<a href="/certs/" class="custom-link">Смотреть все</a>*}
    </div>
{/if}

