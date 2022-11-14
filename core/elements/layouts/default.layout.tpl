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
    <link rel="stylesheet" href="{$_modx->config['template_path']}css/main.css?v=16">

    {if $_modx->context.key == 'web'}
        {set $site_context = 'knauf'}
    {else}
        {set $site_context = $_modx->context.key}
    {/if}
    {set $site_class = $site_context}

    {if $_modx->context.key == 'krovlya'}
        {set $site_class = 'rockwool krovlya'}
    {elseif $_modx->context.key == 'pilomat'}
        {set $site_class = 'knauf pilomat'}
    {elseif $_modx->context.key == 'kirpich-m'}
        {set $site_class = 'rockwool kirpich-m'}
    {elseif $_modx->context.key == 'fasady-pro'}
        {set $site_class = 'fasady-pro'}
    {elseif $_modx->context.key == 'fasad'}
        {set $site_class = 'fasad'}
    {elseif $_modx->resource.context_key == 'armatura-178'}
        {set $site_class = 'rockwool armatura-178'}
    {elseif $_modx->resource.context_key == 'asconcrete'}
        {set $site_class = 'rockwool asconcrete'}
    {elseif $_modx->resource.context_key == 'plitaosb'}
        {set $site_class = 'rockwool plitaosb'}
    {elseif $_modx->resource.context_key == 'pro-fanera'}
        {set $site_class = 'knauf pro-fanera'}
    {elseif $_modx->resource.context_key == 'plity-mdvp'}
        {set $site_class = 'fasady-pro plity-mdvp'}
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
    {elseif $site_context == 'fasady-pro'}
        {set $micro_title = $micro_title ~ 'деревянных фасадов'}
    {elseif $site_context == 'fasad'}
        {set $micro_title = $micro_title ~ 'фасадов'}
    {elseif $site_context == 'armatura-178'}
        {set $micro_title = $micro_title ~ 'арматуры'}
    {elseif $site_context == 'asconcrete'}
        {set $micro_title = $micro_title ~ 'асфальтобетона'}
    {elseif $site_context == 'plitaosb'}
        {set $micro_title = $micro_title ~ 'плит ОСБ'}
    {elseif $site_context == 'pro-fanera'}
        {set $micro_title = $micro_title ~ 'фанеры'}
    {elseif $site_context == 'plity-mdvp'}
        {set $micro_title = $micro_title ~ 'плит МДВП'}
    {else}
        {set $micro_title = $micro_title ~ 'утеплителя ' ~ $brand}
    {/if}

    {set $micro_title = $micro_title ~ ' по Санкт-Петербургу и Ленинградской области от официального дилера'}
    <meta property="og:locale" content="ru_RU" />
    <meta property="og:type" content="website" />
    <meta property="og:title" content="{$_modx->resource.longtitle}" />
    <meta property="og:description" content="{$_modx->resource.description}" />
    <meta property="og:url" content="{$_modx->makeUrl($_modx->resource.id, '', '', 'full')}" />
    <meta property="og:image" content="{'site_url' | option}{$micro_img}" />
    <meta name="twitter:card" content="summary" />
    <meta name="twitter:description" content="{$_modx->resource.description}" />
    <meta name="twitter:title" content="{$micro_title}" />
    <meta name="twitter:image" content="{'site_url' | option}{$micro_img}" />
    {* <<< Open Graph и Twitter Card  *}

    {if $_modx->getPlaceholder('checkHost') === 'prod'}
        <script src="//code.jivo.ru/widget/9J1gSPDmWh" async></script>

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
            } )(window,document,'script','dataLayer', '{$_modx->config.gtm_id}');
        </script>
        <!-- End Google Tag Manager -->

        {* Данный код нужен, чтобы загрузку этих скриптов не ждал preloader
        <noscript><div><img src="https://mc.yandex.ru/watch/86222209" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
        <script>
            (function () {
                var parent = document.getElementsByTagName("script")[0].parentNode;

                // gtm
                script = document.createElement("script");
                script.setAttribute('gtm_id', '{$_modx->config.gtm_id}');
                script.src = "/assets/template/js/ext-google-tag-manager.js";
                parent.appendChild(script);

                // ym
                script = document.createElement("script");
                script.setAttribute('ym_id', '{$_modx->config.yandex_id}');
                script.src = "/assets/template/js/ext-yandex-metrika.js";
                parent.appendChild(script);
            })();
        </script>
        *}

        {*
        <!-- calltouch -->
        {if $_modx->resource.context_key in list ['krovlya','pro-fanera','fasady-pro','rockwool','paroc','tn','ursa','penoplex','isover','web','pilomat','plitaosb','kirpich-m']}
            <script type="text/javascript">
                (function(w,d,n,c) { w.CalltouchDataObject=n;w[n]=function() { w[n]["callbacks"].push(arguments) } ;if(!w[n]["callbacks"]){ w[n]["callbacks"]=[] } w[n]["loaded"]=false;if(typeof c!=="object") { c=[c] } w[n]["counters"]=c;for(var i=0;i<c.length;i+=1) { p(c[i]) } function p(cId) { var a=d.getElementsByTagName("script")[0],s=d.createElement("script"),i=function() { a.parentNode.insertBefore(s,a) } ,m=typeof Array.prototype.find === 'function',n=m?"init-min.js":"init.js";s.type="text/javascript";s.async=true;s.src="https://mod.calltouch.ru/"+n+"?id="+cId;if(w.opera=="[object Opera]") { d.addEventListener("DOMContentLoaded",i,false) } else { i() } } } )(window,document,"ct","n7xp3puh");
            </script>
        {/if}
        <!-- calltouch -->
        *}
    {/if}

    {block 'schema'}{/block}
{/block}

{block 'body'}
    {if $_modx->resource.context_key in list ['kirpich-m', 'krovlya']}
        <div id="preloader">
          <div id="preloader-status">&nbsp;</div>
        </div>
    {/if}

    {if $_modx->getPlaceholder('checkHost') == 'prod'}
        <!-- Google Tag Manager (noscript) -->
        <noscript><iframe src="https://www.googletagmanager.com/ns.html?id={$_modx->config.gtm_id}"
                          height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
        <!-- End Google Tag Manager (noscript) -->
    {/if}

    {block "header-mobile"}
    {/block}

    <div class="wrap">
        {block "header"}
            {insert "file:blocks/header.tpl"}
        {/block}
        <div class="current-page">
            {block "page"}{/block}
        </div>
        {block "footer"}
            {include "file:blocks/footer.tpl"}
        {/block}
    </div>
    {block "modals"}
        {include 'file:elements/modals/callback/wrapper.tpl'}
    {/block}
{/block}
{block "end-body"}
    <div class="scroll-top">
        <img src="{$_modx->config['template_path']}img/scroll-top.png">
    </div>
    <script src="{$_modx->config['template_path']}js/main.js?v=14"></script>

    {*
    <script src="{$_modx->config['template_path']}js/scripts.js?v=13"></script>
    *}
    {*
    <script src="{$_modx->config['template_path']}js/vendors.js?v=1"></script>
    <script src="{$_modx->config['template_path']}js/base.js?v=1"></script>
    *}

    <script data-map-id="districts_map" data-src="https://api-maps.yandex.ru/2.1/?apikey=99aa267b-edef-422a-b3d8-12bfaa6253a1&lang=ru_RU&coordorder=latlong&onload=initDistrictsMap" type="text/javascript" async defer></script>

<!--
Источник: [^s^]
БД, сек: [^qt^];
БД запросов: [^q^];
PHP, сек: - [^p^];
Всего времени: [^t^];
Память: [^m^];
-->

{/block}
