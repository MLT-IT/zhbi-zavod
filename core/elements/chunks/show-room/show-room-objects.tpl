{set $rows = $_modx->resource.id | resource : 'showroomGallery' | fromJSON}

{if $rows}
<div class="showroom-objects">
    <div class="showroom-objects__slider">
        <div class="swiper-container">
            <div class="swiper-wrapper">
            {foreach $rows as $gallery}
                {set $thumb = 'phpthumbon' | snippet : [ 'input' => "/assets/{$gallery.image}", 'options' => '&h=250&w=350&zc=1' ]}
                <div class="swiper-slide">
                    <a href="/assets/{$gallery.image}" data-fancybox="show-room-objects">
                        <img src="{$thumb}" class="showroom-objects__image" alt="" loading="lazy">
                    </a>
                </div>
            {/foreach}
            </div>

            <div class="swiper-buttons">
                <div class="swiper-button swiper-button-prev"></div>
                <div class="swiper-button swiper-button-next"></div>
            </div>
        </div>
    </div>
</div>
{/if}