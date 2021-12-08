<section class="catalog">
    <div class="wrapper">
        <h2 class="title-2">Наш ассортимент</h2>
        <div class="catalog__cards">
            {'!pdoResources' | snippet : [
                'tpl' => '@FILE chunks/catalogCard.tpl',
                'depth' => 0,
                'limit' => 0,
                'includeTVs' => 'mainImage',
                'sortby' => 'menuindex',
                'sortdir' => 'ASC',
                'parents' => '@FILE snippets/getIdByAlias.php' | snippet : ['alias' => 'catalog']
            ]}
</section>
