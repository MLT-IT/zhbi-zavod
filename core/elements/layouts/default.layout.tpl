{extends "file:layouts/base.layout.tpl"}
{block 'head'}
    {parent}
    {block 'title'}
        {include "file:elements/meta-title.tpl"}
    {/block}
    {block 'description'}
        {include "file:elements/meta-description.tpl"}
    {/block}
    {*
    <link rel="stylesheet" href="{$_modx->config['template_path']}css/fonts.css?v=1">
    <link rel="stylesheet" href="{$_modx->config['template_path']}css/main.css?v=1">
    *}
    <link rel="stylesheet" href="{$_modx->config['template_path']}css/styles.css?v=5">
    {include 'file:elements/metrika.tpl'}

    {if $_modx->context.key == 'web'}
        {set $site_context = 'knauf'}
    {else}
        {set $site_context = $_modx->context.key}
    {/if}
    {set $site_class = $site_context}

    {if $_modx->context.key == 'krovlya'}
        {set $site_class = 'rockwool krovlya'}
    {elseif $_modx->context.key == 'kirpich-m'}
        {set $site_class = 'rockwool kirpich-m'}
    {/if}

    {* >>> favicon *}
    <link rel="apple-touch-icon" sizes="180x180" href="/assets/template/img/favicons/{$site_context}/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="/assets/template/img/favicons/{$site_context}/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="/assets/template/img/favicons/{$site_context}/favicon-16x16.png">
    <link rel="manifest" href="/assets/template/img/favicons/{$site_context}/site.webmanifest">
    <link rel="mask-icon" href="/assets/template/img/favicons/{$site_context}/safari-pinned-tab.svg" color="#5bbad5">
    <meta name="msapplication-TileColor" content="#da532c">
    <meta name="theme-color" content="#ffffff">
    <link rel="icon" href="/assets/template/img/favicons/{$site_context}/favicon.ico" type="image/x-icon">
    {* <<< favicon *}

    {* >>> Open Graph и Twitter Card  *}
    {set $micro_img = 'assets/template/img/logos/' ~ $site_context ~ '.svg'}
    {set $micro_title = 'Поставка '}
    {if $site_context == 'krovlya'}
        {set $micro_title = $micro_title ~ 'кровли'}
    {elseif $site_context == 'kirpich-m'}
        {set $micro_title = $micro_title ~ 'кирпича'}
    {else}
        {set $micro_title = $micro_title ~ 'утеплителя ' ~ $brand}
    {/if}

    {set $micro_title = $micro_title ~ ' по Санкт-Петербургу и Ленинградской области от официального дилера'}
    <meta property="og:locale" content="ru_RU" />
    <meta property="og:type" content="website" />
    <meta property="og:title" content="{$micro_title}" />
    <meta property="og:description" content="{$_modx->resource.description}" />
    <meta property="og:url" content="{'site_url' | option}" />
    <meta property="og:image" content="{'site_url' | option}{$micro_img}" />
    <meta name="twitter:card" content="summary" />
    <meta name="twitter:description" content="{$_modx->resource.description}" />
    <meta name="twitter:title" content="{$micro_title}" />
    <meta name="twitter:image" content="{'site_url' | option}{$micro_img}" />
    {* <<< Open Graph и Twitter Card  *}

    <!-- Yandex.Metrika counter -->
    <script type="text/javascript" >
        (function(m,e,t,r,i,k,a) { m[i]=m[i]||function() { (m[i].a=m[i].a||[]).push(arguments) } ;
                m[i].l=1*new Date();k=e.createElement(t),a=e.getElementsByTagName(t)[0],k.async=1,k.src=r,a.parentNode.insertBefore(k,a) } )
        (window, document, "script", "https://mc.yandex.ru/metrika/tag.js", "ym");

        ym([[++yandex_id]], "init", {
            clickmap:true,
            trackLinks:true,
            accurateTrackBounce:true,
            webvisor:true,
            ecommerce:"dataLayer"
        } );
    </script>
    <noscript><div><img src="https://mc.yandex.ru/watch/86222209" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
    <!-- /Yandex.Metrika counter -->

    <!-- Google Tag Manager -->
    <script>(function(w,d,s,l,i) { w[l]=w[l]||[];w[l].push( { 'gtm.start':
        new Date().getTime(),event:'gtm.js' } );var f=d.getElementsByTagName(s)[0],
                j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
                'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
                 } )(window,document,'script','dataLayer', '{$_modx->config.gtm_id}');</script>
    <!-- End Google Tag Manager -->

    {block 'schema'}{/block}
{/block}

{block 'body'}
    <!-- Google Tag Manager (noscript) -->
    <noscript><iframe src="https://www.googletagmanager.com/ns.html?id={$_modx->config.gtm_id}"
                      height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
    <!-- End Google Tag Manager (noscript) -->

    {block "header-mobile"}
    {/block}

    <div class="wrap">
        {block "header"}
            {insert "file:blocks/header.tpl"}
        {/block}
        {block "page"}{/block}
        {block "footer"}
            {include "file:blocks/footer.tpl"}
        {/block}
    </div>
    {block "modals"}
        {include 'file:elements/modals/callback/wrapper.tpl'}
    {/block}
{/block}
{block "end-body"}
    <a class="scroll-top active" href="javascript:;" onclick="document.getElementById('body').scrollIntoView();">
        <img src="{$_modx->config['template_path']}img/scroll-top.png">
    </a>
    <script src="{$_modx->config['template_path']}js/main.js?v=5"></script>
    <script src="{$_modx->config['template_path']}js/scripts.js?v=3"></script>
    {*
    <script src="{$_modx->config['template_path']}js/vendors.js?v=1"></script>
    <script src="{$_modx->config['template_path']}js/base.js?v=1"></script>
    *}

    <script data-map-id="districts_map" data-src="https://api-maps.yandex.ru/2.1/?apikey=99aa267b-edef-422a-b3d8-12bfaa6253a1&lang=ru_RU&coordorder=latlong&onload=initDistrictsMap" type="text/javascript" async defer></script>

    {*
    <!--
    Время, затраченное на анализ / рендеринг страницы t = [^t^]
    Выполнено запросов к БД q = [^q^]
    На общение с БД потрачено времени qt = [^qt^]
    Время работы php скрипта p = [^p^]
    -->
    *}
{/block}
