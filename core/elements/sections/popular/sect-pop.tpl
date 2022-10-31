{* $resources и $popular_ids нужно отправлять в чанк. Но это не обязательно *}
{'@FILE snippets/getPopularProducts.php' | snippet : [
  'resources' => $resources,
  'popular_ids' => $_modx->config['popular_ids']
]}
