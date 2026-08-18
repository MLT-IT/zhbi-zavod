
{*Нужен кастомный фавико впиши в кейс контекст и папку, куда положил фавиконки*}

{switch $_modx->resource.context_key}
{case 'test'}
    {set $favico_folder = '/assets/template/img/favicons/test'}
{case 'trotuarnaya-plitka'}
    {set $favico_folder = '/assets/template/img/favicons/trotuarnaya-plitka'}
{case 'gbi-zavod78'}
    {set $favico_folder = '/assets/template/img/favicons/gbi-zavod78'}
{default}
    {set $favico_folder = '/assets/template/img/favicons/default'}
{/switch}

<link rel="apple-touch-icon" sizes="180x180" href="{$favico_folder}/apple-touch-icon.png">
<link rel="icon" type="image/png" sizes="32x32" href="{$favico_folder}/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="{$favico_folder}/favicon-16x16.png">
<link rel="manifest" href="{$favico_folder}/site.webmanifest">
<link rel="mask-icon" href="{$favico_folder}/safari-pinned-tab.svg" color="#5bbad5">
<meta name="msapplication-TileColor" content="#da532c">
<meta name="theme-color" content="#ffffff">
<link rel="icon" href="{$favico_folder}/favicon.ico" type="image/x-icon">