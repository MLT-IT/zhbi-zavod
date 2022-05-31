{$_modx->runSnippet('@FILE snippets/pushViewedProduct.php')}

{switch $_modx->context.key}
    {* Утеплители *}
    {case 'web'}
        {set $brand = 'Кнауф'}
    {case 'rockwool'}
        {set $brand = 'Роквул'}
    {case 'tn'}
        {set $brand = 'Технониколь'}
    {case 'penoplex'}
        {set $brand = 'Пеноплэкс'}
    {case 'isover'}
        {set $brand = 'Изовер'}
    {case 'paroc'}
        {set $brand = 'Парок'}
    {case 'ursa'}
        {set $brand = 'Урса'}
    {* Остальное *}
    {case 'krovlya'}
        {set $brand = 'Кровельная компания №1'}
    {case 'kirpich-m'}
        {set $brand = 'КирпичПро'}
    {case 'fasady-pro'}
        {set $brand = 'ЛЕССНАБСТРОЙ'}
    {case 'fasad'}
        {set $brand = 'Мир Фасада'}
    {case 'armatura-178'}
        {set $brand = 'АрматураПРО'}
    {case 'asconcrete'}
        {set $brand = 'АсфальтПРО'}
    {case 'pilomat'}
        {set $brand = 'ЛЕССНАБСТРОЙ'}
    {case 'plitaosb'}
        {set $brand = 'OSB здесь!'}
    {case 'pro-fanera'}
        {set $brand = 'Фанера ПРО'}
    {case 'plity-mdvp'}
        {set $brand = 'Плиты МДВП'}
{/switch}

{$_modx->setPlaceholder('brand', $brand)}

{'!checkHost' | snippet}
{'!checkItems' | snippet}

<!doctype html>
<html lang="ru">
<head>
    {block 'head'}
        <base href="/">
        <meta charset="UTF-8">
        <meta name="viewport"
              content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">

        <link rel="canonical" href="{$_modx->makeUrl($_modx->resource.id, '', '', 'full')}">
    {/block}
</head>
<body id="body" class="{$site_class}" data-ctx="{$_modx->resource.context_key}">
    {block 'body'}{/block}
    {block "end-body"}{/block}
</body>
</html>
