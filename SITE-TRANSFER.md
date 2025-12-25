## Этапы

- Через CLONER настроить экспорт

  - Заменить ТВ и шаблоны

- Заново надо на категориях формировать теги. Так как в migx ID ресурсов другие
- Разобраться с шаблонами
  - Растивить правильные,создать новые
- Перенести Условия/Фильтры на СЕО выборки

  - Запустить на доноре

  ```php
    <?php

    $resrs = $modx->getCollection('modResource', [
        'context_key' => 'fasad',
        'class_key'   => 'msCategory'
    ]);

    $result = [];

    foreach ($resrs as $res) {
        $result[] = [
            'alias' => $res->alias,
            'id'    => $res->id
        ];
    }

    $json = json_encode($result, JSON_UNESCAPED_UNICODE);
    $filePath = MODX_BASE_PATH . 'resources.json';
    file_put_contents($filePath, $json);

    // Выводим на экран
    echo "success";
  ```

  - Запустить на новом сайте

  ```php
  <?php

  $data = json_decode('[
    {"alias": "catalog", "id": 4},
    {"alias": "knauf", "id": 93185},
  ]',true);


  foreach($data as $value){
      $resource = $modx->getObject('modResource',['alias' => $value['alias']]);

      if($resource){
          $res_id = $resource->id;

          $modx->query("
          UPDATE modx_products_composer_selection SET rid = $res_id WHERE  rid = {$value['id']}
          ");
      }
  }
  ```

  - Тоже самое для FROM modx_products_composer_selection WHERE key = parent (там старые ID родителей)

  на старом

  ```php
  <?php

  $donor_context = "web";

  $res = $modx->query("SELECT
      *
  FROM
      modx_products_composer_selection
  WHERE
      `key` = 'parent'
      AND rid IN (
          SELECT
              id
          FROM
              modx_site_content
          WHERE
              context_key = '$donor_context'
      )");
  $rows = $res->fetchALL(PDO::FETCH_ASSOC);

  $parents = [];
  foreach($rows as $row){
  $parents = array_merge($parents,explode(',',$row['val']));
  }

  $resrs = $modx->getCollection('modResource',['id:in' => $parents]);

  $result= [];
    foreach($resrs as $res){
        $result[$res->id] = $res->alias;
    }

    $json = json_encode($result, JSON_UNESCAPED_UNICODE);
    $filePath = MODX_BASE_PATH . 'resources.json';
    file_put_contents($filePath, $json);

    // Выводим на экран
    echo "success";
  ```

  на новом

  ```php
  <?php

  $data = json_decode('{
    "93190": "rockwool",
    "93456": "acoustic-batts",
  }
  ', true);

  $res = $modx->query("SELECT
        *
    FROM
        modx_products_composer_selection
    WHERE
        `key` = 'parent'");

  $rows = $res->fetchALL(PDO::FETCH_ASSOC);

  foreach ($rows as $row) {
      $parents = explode(",", $row['val']);

      $new_parents = [];
      foreach ($parents as $parent) {
          $alias = $data[$parent];
          $resource = $modx->getObject('modResource', ['alias' => $alias]);
          if ($resource) {
              $new_parents[] = $resource->id;
          }
      }

      if (!empty($new_parents)) {
          $ids = implode(",", $new_parents);

          $modx->query("UPDATE modx_products_composer_selection SET val = '$ids' WHERE id = {$row['id']}");

      }
  }

  ```

- TV video будет с iframe, Надо оставить только ссылки через запятую
- TV video надо загнать в родителя. Смысл он на каждом товаре...

- ВОзня со складами core\elements\modules\warehouses\snippets\selection-items.php ID статика

## Важное

### Не забыть:

- sitemap.html
- sitemap.xml
- robots.txt

- UTM
- Подмена почты
- Политика конфиденциальности

- htaccess
- autoredirector

- Микроразметка

### Блоки:

- Меню
- Теги

### Доп плагины:

- Сохранять заявки

### Тесты:

- Тест заявок

### Дополнительно

- Изучить куки. Необходимо записывать в них UTM. Так сможем чаще чистить сессии
- Поставить wizard
- Написать плагин для загрузки сертификатов. + Генерация превью. У товара указывать ID сертификата
- Разобраться с шаблонами СЕО выборок
