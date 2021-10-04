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
</head>
<body id="body">
    {block 'body'}{/block}
    {block "end-body"}{/block}
</body>
</html>
