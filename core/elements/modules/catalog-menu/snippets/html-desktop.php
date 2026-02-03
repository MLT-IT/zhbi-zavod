<?php

if (empty($data)) return;

$html_categories = "";
$html_subcategories = "";
foreach ($data as $category_index => $category) {

    if ($category_index == 0) {
        $active_class = "opened";
    } else {
        $active_class = "";
    }

    $html_categories .= "<a class='catalog-menu__categories-item $active_class' href='{$category['uri']}' data-subcategories-open='category-{$category_index}'>
    <svg><use xlink:href='{$category['icon']}'></use></svg>
    {$category['title']}
    </a>";

    $html_subcategory = "";
    foreach ($category['children'] as $subcategory_name => $childrens) {

        $html_childrens = "";
        foreach ($childrens as $children) {
            $html_childrens .= "<a class='catalog-menu__subcategory-item {$children['classnames']}' href='{$children['uri']}'>{$children['title']}</a>";
        }

        $html_subcategory .= "<div class='catalog-menu__subcategory'>
                                    <div class='catalog-menu__subcategory-name fs-14 fw-700'>$subcategory_name</div>
                                    <div class='catalog-menu__subcategory-items'>$html_childrens</div>
                                </div>";
    }

    $html_subcategories .= "<div class='catalog-menu__subcategories-items $active_class' id='category-{$category_index}'>$html_subcategory</div>";
}

$html_categories = "<div class='catalog-menu__categories'><div class='catalog-menu__categories-name fs-14 fw-700'>Раздел</div>$html_categories</div>";
$html_subcategories = "<div class='catalog-menu__subcategories'>$html_subcategories</div>";

return $html_categories . $html_subcategories;
