<div class="showroom-gallery">
    <div class="showroom-gallery__wrapper showroom-wrapper"> 
    {set $site_context = $_modx->context.key}
    {set $imagePath = "/assets/images/show-room/{$site_context}"}
    {set $showroomImages = '@FILE snippets/getFolderJpgList.php' | snippet : ['file_suffix'=>'show-room', 'folder'=> $imagePath]}   
    
    {if $site_context == 'fibrofasad'}
        {set $showroomImages = $_modx->resource.id | resource : 'showroomGallery' | fromJSON}

        {foreach $showroomImages as $idx => $img} 
            {set $thumb = 'phpthumbon' | snippet : [ 'input' => "assets/{$img['image']}", 'options' => '&h=250&w=350&zc=1' ]} 
            <p
                class="showroom-gallery__thumb">
                <a data-fancybox="show-room" href="assets/{$img['image']}">
                    <img class="showroom-gallery__image" src="{$thumb}" alt="Шоурум компании {$_modx->config.site_name} {$idx}" />
                </a>
            </p> 
        {/foreach} 
 
    {else}
        {foreach $showroomImages as $idx => $img} 
            {set $thumb = 'phpthumbon' | snippet : [ 'input' => "{$imagePath}/{$img}", 'options' => '&h=250&w=350&zc=1' ]} 
            <p
                class="showroom-gallery__thumb">
                <a data-fancybox="show-room" href="{$imagePath}/{$img}">
                    <img class="showroom-gallery__image" src="{$thumb}" alt="Шоурум компании {$_modx->config.site_name} {$idx}" />
                </a>
            </p> 
        {/foreach} 
    {/if}
    </div>
</div>
