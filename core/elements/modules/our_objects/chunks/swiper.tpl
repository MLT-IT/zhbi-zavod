<section class="show-room__container sect-showroom-swiper">
{set $imageWidth = 400}
{set $imageHeight = 300}
{set $imagePath = "/assets/images/show-room/{$site_context}"}
{set $showroomImages = '@FILE modules/our_objects/snippets/getFolderJpgList.php' | snippet : ['file_suffix'=>'gallery', 'folder'=> $imagePath]}          
        
    
    <div class="sect-showroom-swiper__wrapper showroom-swiper"> 

        <div class="swiper-buttons showroom-swiper__buttons">
            <div class="swiper-button swiper-button-prev"></div>
            <div class="swiper-button swiper-button-next"></div>
        </div>
        
        <div class="swiper-wrapper">
                {foreach $showroomImages as $idx => $img}
                    {set $thumb = 'phpthumbon' | snippet : [ 'input' => "{$imagePath}/{$img}", 'options' => '&w='~$imageWidth~'&h='~$imageHeight~'&zc=1' ]} 
                    <div class="swiper-slide" data-index="{$idx}">
                        <a data-fancybox="gallery" href="{$imagePath}/{$img}">
                            <img class="showroom-swiper__image" src="{$thumb}" alt="Шоурум компании {$_modx->config.site_name} {$idx}" />
                        </a>                
                    </div>
                {/foreach}
        </div>
    </div>
</section>
