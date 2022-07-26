<section class="sect-map">
    <div class="map{if $classToMap?} {$classToMap}{/if}">
        <div class="wrapper{if $classToWrapper?} {$classToWrapper}{/if}">
            <h2 class="title-2">География работы</h2>
            <div class="map__container">
              {if $_modx->resource.context_key == 'fasady-pro'}
                <script type="text/javascript" charset="utf-8" async src="https://api-maps.yandex.ru/services/constructor/1.0/js/?um=constructor%3Ad7405955675ce86f479c3b8340d6900db331cac1bf3cf7e37a48fd8d9622ce2d&amp;width=500&amp;height=400&amp;lang=ru_RU&amp;scroll=true"></script>
              {else}
                <script type="text/javascript" charset="utf-8" async src="https://api-maps.yandex.ru/services/constructor/1.0/js/?um=constructor%3Abfd296294102bdce3e6b7d6aa53834630ca08e070f70374c9375fe45b57664ba&amp;width=100%25&amp;height=400&amp;lang=ru_RU&amp;scroll=true"></script>
              {/if}
            </div>
        </div>
    </div>
</section>
