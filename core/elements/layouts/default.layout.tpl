{extends "file:layouts/base.layout.tpl"}
{block 'head'}
    {parent}
    {block 'title'}
        {include "file:elements/meta-title.tpl"}
    {/block}
    {block 'description'}
        {include "file:elements/meta-description.tpl"}
    {/block}
    <link rel="stylesheet" href="{$_modx->config['template_path']}css/main.css">
    <link rel="stylesheet" href="{$_modx->config['template_path']}css/styles.css">
    {include 'file:elements/metrika.tpl'}

    {* >>> favicon *}
    {if $_modx->context.key == 'web'}
        {set $site_context = 'knauf'}
    {else}
        {set $site_context = $_modx->context.key}
    {/if}
    <link rel="apple-touch-icon" sizes="180x180" href="/assets/template/img/favicons/{$site_context}/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="/assets/template/img/favicons/{$site_context}/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="/assets/template/img/favicons/{$site_context}/favicon-16x16.png">
    <link rel="manifest" href="/assets/template/img/favicons/{$site_context}/site.webmanifest">
    <link rel="mask-icon" href="/assets/template/img/favicons/{$site_context}/safari-pinned-tab.svg" color="#5bbad5">
    <meta name="msapplication-TileColor" content="#da532c">
    <meta name="theme-color" content="#ffffff">
    {* <<< favicon *}
{/block}

{block 'body'}
    {block "header-mobile"}
    {/block}
    <div class="wrap">
        {block "header"}
            {include "file:blocks/header.tpl"}
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
    <script src="{$_modx->config['template_path']}js/main.js"></script>
    <script src="{$_modx->config['template_path']}js/scripts.js"></script>
    <script src="{$_modx->config['template_path']}js/vendors.js"></script>
    <script src="{$_modx->config['template_path']}js/base.js"></script>
{/block}
