{extends "file:layouts/default.layout.tpl"}

{block "page"}
    <main class="layout__main">

        {insert "file:chunks/breadcrumbs/breadcrumbs.tpl"}

        {include "file:templates/showroom/contacts.tpl"}

        {include "file:templates/showroom/content.tpl"}

        {if $_modx->context.key != "fibrofasad"}
            {if $_modx->context.key == "krovelnyjstroymarket"}
                {set $gallery_heading = "Фотографии шоу-рума"}
                {set $objects_heading = "Наши объекты"}
            {else}
                {set $gallery_heading = "Наши объекты"}
                {set $objects_heading = "Фотографии шоу-рума"}
            {/if}
            {if $_modx->context.key != 'kirpich-m5' && $_modx->resource.id | resource : 'showroomGallery'}
                {include "file:templates/showroom/gallery.tpl" heading=$gallery_heading}
            {/if}
            {include "file:templates/showroom/objects.tpl" heading=$objects_heading}
        {else}
            {include "file:templates/showroom/objects.tpl" heading="Фотографии шоу-рума"}
            {include "file:templates/showroom/gallery.tpl" heading="Наши объекты"}
        {/if}

        {include "file:templates/showroom/banner.tpl"}

        {insert "file:modules/our_objects/our_objects.tpl"}

    </main>
{/block}
