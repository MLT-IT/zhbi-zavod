{$_modx->runSnippet('@FILE snippets/pushViewedProduct.php')}

<!doctype html>
<html lang="ru">
<head>
    {block 'head'}
        <base href="/">
        <meta charset="UTF-8">
        <meta name="viewport"
              content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
    {/block}

    {* >>> favicon *}
    {if $_modx->context.key === 'web'}
        {set $folder = 'knauf'}
    {else}
        {set $folder = $_modx->context.key}
    {/if}
    <link rel="apple-touch-icon" sizes="180x180" href="/assets/template/favicons/{$folder}/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="/assets/template/favicons/{$folder}/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="/assets/template/favicons/{$folder}/favicon-16x16.png">
    <link rel="manifest" href="/assets/template/favicons/{$folder}/site.webmanifest">
    <link rel="mask-icon" href="/assets/template/favicons/{$folder}/safari-pinned-tab.svg" color="#5bbad5">
    <meta name="msapplication-TileColor" content="#da532c">
    <meta name="theme-color" content="#ffffff">
    {* <<< favicon *}

</head>
<body id="body">
    {block 'body'}{/block}
    {block "end-body"}{/block}
</body>
</html>
