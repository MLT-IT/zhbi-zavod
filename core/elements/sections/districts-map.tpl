<section class="sect-map">
    <div class="map{if $classToMap?} {$classToMap}{/if}">
        <div class="wrapper{if $classToWrapper?} {$classToWrapper}{/if}">
            <h2 class="title-2">
                {if $_modx->resource.context_key === 'pilomat'}
                    Склады с которых мы возим
                {else}
                    Доставим в любую точку Ленобласти
                {/if}
            </h2>
            <div class="map__container" id="districts_map" data-map-script="districts_map"></div>
        </div>
    </div>
</section>
