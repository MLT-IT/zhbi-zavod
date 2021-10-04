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
