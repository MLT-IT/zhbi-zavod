{* AJAX корзины *}
{'@FILE modules/cart/backend/snippets/ajax.php' | snippet}
{include "file:modules/fast-search/chunks/ajax.tpl"}

{* Создание всех плейсхолдеров *}
{"@FILE config/placeholders/index.php" | snippet}

{* Плейсхолдеры для модуля избранных и сравнения товаров *}
{'@FILE modules/store-product-selection/snippet/setPlaceholder.php' | snippet : ["cookie_key" => "favorite-products"]}
{'@FILE modules/store-product-selection/snippet/setPlaceholder.php' | snippet : ["cookie_key" => "comparison-products"]}

{* Похожие товары *}
{"@FILE modules/similarsamples/snippets/ajax.php" | snippet}

{* Категории товаров. По всему сайту работаем с даным массивом *}
{if $_modx->getPlaceholder('context.catalog_id')}
  {"@FILE modules/map-resources/mapResources.php" | snippet : [
    'parents' => $_modx->getPlaceholder('context.catalog_id')
    'where' => '{"class_key":"msCategory"}'
    'depth' => 2
    'includeTVs' => 'main_image,icon'
    'toPlaceholder' => 'map-resources.category'
    'save_cache_name' => true
  ]}
{/if}

{* Ресурсы для меню. По всему сайту работаем с даным массивом *}
{"@FILE modules/map-resources/mapResources.php" | snippet : [
  'parents' => 0
  'where' => '{"class_key":"modDocument"}'
  'toPlaceholder' => 'map-resources.menu'
  'save_cache_name' => true
  'depth' => 1
]}

{* Элементы меню. Используются в нескольких чанках: десктоп + скрытый од кнопкой меню, мобилка *}
{if $_modx->getPlaceholder('context.header_menu_ids')}
  {set $menu_items = "@FILE modules/map-resources/mapSeparateResources.php" | snippet : [
      'data' => $_modx->getPlaceholder('map-resources.menu'),
      'ids' => $_modx->getPlaceholder('context.header_menu_ids')
  ]}
  {$_modx->setPlaceholder('menu_items',$menu_items)}
{/if}

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
    <title>{$_modx->resource.longtitle?:$_modx->resource.pagetitle}</title>

    <link rel="apple-touch-icon" sizes="180x180" href="/assets/template/images/favicons/default/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="/assets/template/images/favicons/default/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="/assets/template/images/favicons/default/favicon-16x16.png">
    <link rel="manifest" href="/assets/template/images/favicons/default/site.webmanifest">
    <link rel="mask-icon" href="/assets/template/images/favicons/default/safari-pinned-tab.svg" color="#5bbad5">
    <meta name="msapplication-TileColor" content="#da532c">
    <meta name="theme-color" content="#ffffff">
    <link rel="icon" href="/assets/template/images/favicons/default/favicon.ico" type="image/x-icon">

    <base href="/">

    <meta name="description" content="{$_modx->resource.description}">

    <link rel="canonical" href="{$_modx->makeUrl($_modx->resource.id, '','','full')}">
    <link rel="stylesheet" href="/assets/template/css/main.css?{'file_version'|config}">

        <!-- Yandex.Metrika counter -->
    {set $yandex_id = $_modx->getPlaceholder('virtual-router')['yandex_id']}
    <script type="text/javascript">
      (function (m, e, t, r, i, k, a) {
        m[i] =
          m[i] ||
          function () {
            (m[i].a = m[i].a || []).push(arguments);
          };
        m[i].l = 1 * new Date();
        for (var j = 0; j < document.scripts.length; j++) {
          if (document.scripts[j].src === r) {
            return;
          }
        }
        (k = e.createElement(t)),
          (a = e.getElementsByTagName(t)[0]),
          (k.async = 1),
          (k.src = r),
          a.parentNode.insertBefore(k, a);
      })(
        window,
        document,
        "script",
        "https://mc.yandex.ru/metrika/tag.js?id={$yandex_id}",
        "ym"
      );

      ym({$yandex_id}, "init", {
        ssr: true,
        webvisor: true,
        clickmap: true,
        ecommerce: "dataLayer",
        accurateTrackBounce: true,
        trackLinks: true,
      });
    </script>
    <noscript
      ><div>
        <img
          src="https://mc.yandex.ru/watch/{$yandex_id}"
          style="position: absolute; left: -9999px"
          alt=""
        /></div
    ></noscript>
    <!-- /Yandex.Metrika counter -->
  </head>
  <body data-res-id="{$_modx->resource.id}" data-res-parent="{$_modx->resource.parent}">
    {include "file:sections/header/wrapper.tpl"}

    {block 'page-content'}{/block}
    
    {include "file:sections/footer/wrapper.tpl"}
    {include "file:modules/modals/chunks/all.tpl"}
    {if $_modx->context.key in list ["web"]}
      {include "file:chunks/mobile-bottom.tpl"}
    {/if}

    <script>
      {if $_modx->getPlaceholder('virtual-router')['region']['key'] === 'krasnodar'}
        window.map_data ={
          warehouses_path: "/assets/template/json/address-map/warehouses/krasnodar.json",
          map_center: [45.03547, 39.019896],
        }  
      {else}
        window.map_data ={
          polygons_path: "/assets/template/json/address-map/polygons/spb.json",
          warehouses_path: "/assets/template/json/address-map/warehouses/spb.json",
          map_center: [59.94313797002322, 30.3010448956483],
        }  
      {/if}
    </script>
    <script src="/assets/template/js/main.js?{'file_version'|config}"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  </body>

  {if $_modx->isAuthenticated('mgr')}
    {include "file:chunks/errors-monitor.tpl"}
  {/if}
  
</html>
