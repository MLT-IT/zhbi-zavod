{* Автоматическая выборка товаров по опциям *}

{set $data = "@FILE snippets/getJsonData.php" | snippet : [
    "path" => "/assets/template/json/components-for-product/"~$_modx->context.key~".json"
]}

{if $data['status'] == 'success'}

    {set $components_ids = "@FILE modules/components-for-product/snippets/getComponents.php" | snippet: [
        'components_category_id' => $data['data']['components_category_id']
        'options' => $data['data']['options']
    ]}

    {if $components_ids}
    <div class="section-padding section-margin bg-light-gray-2">
        <div class="container">
            <h2 class="section-title">Сопутствующие товары</h2>
    
            <div class="swiper" data-slider="default-product-slider">
                <div class="swiper-wrapper">
                    {'!msProducts' | snippet : [
                        'parents' => $setting['components_category_id']
                        'resources' => $components_ids
                        'depth' => 50
                        'limit' => 42
                        'sortby' => '{"priority":"ASC"}'
                        'includeTVs' => 'priority'
                        'includeThumbs' => 'webp'
                        'tpl' => '@FILE modules/product-cards/chunks/v2/wrapper.tpl'
                    ]}
                </div>
        
                <div class="swiper-button-prev base-box-shadow"></div>
                <div class="swiper-button-next base-box-shadow"></div>
            </div>
        </div>
    </div>
    {/if}

{/if}