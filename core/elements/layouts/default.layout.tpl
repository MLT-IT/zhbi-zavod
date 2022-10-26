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
    <meta property="og:title" content="{$micro_title}" />
    <meta property="og:description" content="{$_modx->resource.description}" />
    <meta property="og:url" content="{'site_url' | option}" />
    <meta property="og:image" content="{'site_url' | option}{$micro_img}" />
    <meta name="twitter:card" content="summary" />
    <meta name="twitter:description" content="{$_modx->resource.description}" />
    <meta name="twitter:title" content="{$micro_title}" />
    <meta name="twitter:image" content="{'site_url' | option}{$micro_img}" />
    {* <<< Open Graph и Twitter Card  *}

    {if $_modx->getPlaceholder('checkHost') === 'prod'}
        <noscript><div><img src="https://mc.yandex.ru/watch/86222209" style="position:absolute; left:-9999px;" alt="" /></div></noscript>

        {* Данный код нужен, чтобы загрузку этих скриптов не ждал preloader *}
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
