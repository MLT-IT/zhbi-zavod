{extends "file:layouts/base.tpl"}

{block 'page-content'}
{include "file:sections/breadcrumbs/wrapper.tpl"}

<div class="certificates-page section-margin">
    <div class="container">

        <div class="section-margin">
            {include "file:templates/showroom/map.tpl"}
        </div>

        <h1 class="section-title">{$_modx->resource.pagetitle}</h1>
        <div class="section-margin page-content">
            {$_modx->resource.content}
        </div>

        <div class="section-margin">
            <h2 class="section-title">Фотографии шоу-рума</h2>
            {include "file:templates/showroom/gallery.tpl"}
        </div>
        <div class="section-margin">
            <h2 class="section-title">Наши объекты</h2>
            {include "file:templates/showroom/objects.tpl"}
        </div>
        <div class="section-margin">
            {include "file:templates/showroom/banner.tpl"}
        </div>
    </div>
</div>
{/block}