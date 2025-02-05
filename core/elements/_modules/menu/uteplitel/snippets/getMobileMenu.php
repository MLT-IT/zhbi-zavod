<?php

$tpl = $modx->getOption("tpl", $scriptProperties, "@FILE _modules/menu/uteplitel/chunks/mobileMenu.tpl");
$context = $modx->getOption("context", $scriptProperties,"web");

$fileMenu = $modx->getOption("fileMenu", $scriptProperties, "template/json/menu/mobile/$context.json");

// Инициализируем pdoTools
if (!$pdo = $modx->getService('pdoTools')) {
    return 'pdoTools not found';
}

try{
    $fileMenu = file_get_contents(MODX_ASSETS_PATH . $fileMenu);
    if(!$fileMenu) return;

    $menu = json_decode($fileMenu, true);

    if(!function_exists("generateSubmenu")){
        function generateSubmenu($items, $level = 0, $modx) {
            // Получаем pdoTools внутри функции
            $pdo = $modx->getService('pdoTools');
            $output = "";

            foreach ($items as $item) {
                if (isset($item['items']) && !empty($item['items'])) {
                    // Генерируем подменю для текущего элемента
                    $submenuHtml = $pdo->getChunk("@FILE _modules/menu/uteplitel/chunks/mobileMenuSubmenu.tpl", array(
                        "submenu_id" => $item['submenu_id'],
                        "items" => $item['items']
                    ));

                    $output .= $submenuHtml;

                    // Рекурсивно обрабатываем подменю
                    $output .= generateSubmenu($item['items'], $level + 1, $modx);
                }
            }

            return $output;
        }
    }

// Генерируем все подменю рекурсивно, передаем $modx
    $submenus = generateSubmenu($menu['menu'], 0, $modx);

// Возвращаем основной шаблон с меню и подменю
    return $pdo->getChunk($tpl, array(
        "menu" => $menu['menu'],
        "submenus" => $submenus
    ));
}catch (Error $e){
    $modx->log(1, "Ошибка генерациии мобильного меню " . $e->getMessage());
}
