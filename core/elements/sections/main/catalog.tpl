<section class="catalog">
    <div class="wrapper">
        <h2 class="title-2">Наш ассортимент</h2>
        <div class="catalog__cards">
            {set $params = [
                'tpl' => '@FILE chunks/catalogCard.tpl',
                'depth' => 0,
                'limit' => 0,
                'includeTVs' => 'mainImage',
                'sortby' => 'menuindex',
                'sortdir' => 'ASC',
                'parents' => '@FILE snippets/getIdByAlias.php' | snippet : ['alias' => 'catalog']
            ]}

            {if $_modx->resource.context_key == 'armatura-178'}
                {set $params['where'] = '{"hidemenu:=": 0}'}
            {/if}

            {if $_modx->resource.context_key == 'krovlya'}
                {set $params['resources'] = '-56941'}
            {/if}

            {'!pdoResources' | snippet : $params}
</section>
