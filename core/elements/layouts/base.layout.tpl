{$_modx->runSnippet('@FILE snippets/pushViewedProduct.php')}

{switch $_modx->context.key}
    {case 'web'}
        {set $brand = 'Кнауф'}
    {case 'rockwool'}
        {set $brand = 'Роквул'}
    {case 'tn'}
        {set $brand = 'Технониколь'}
    {case 'penoplex'}
        {set $brand = 'Пеноплекс'}
    {case 'isover'}
        {set $brand = 'Изовер'}
    {case 'paroc'}
        {set $brand = 'Парок'}
    {case 'ursa'}
        {set $brand = 'Урса'}
{/switch}

{$_modx->setPlaceholder('brand', $brand)}

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
<body id="body" class="{$site_context}">
    {block 'body'}{/block}
    {block "end-body"}{/block}
</body>
</html>
