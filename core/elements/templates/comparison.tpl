{extends "file:layouts/default.layout.tpl"}

{block 'title'}
    {include "file:elements/product/meta-title.tpl"}
{/block}
{block 'description'}
    {include "file:elements/product/meta-description.tpl"}
{/block}

{block "page"}
    <div class="wrapper">
        {include "file:blocks/breadcrumbs.tpl"}
    </div>

    {set $resources = $_modx->getPlaceholder('checkItems')['comp'] | join : ','}
    {set $countResources = $_modx->getPlaceholder('checkItems')['comp'] | length}

    <section class="product-slider product-slider-1 sect-pop sect-comparison">
        <div class="wrapper sect-pop__wrapper">
            <div class="sect-comparison__header-and-toggler">
                <h1 class="asfs title-1">{$_modx->resource.pagetitle}
                    <span class="title-1__sup">{$countResources}
                        {'formOfWord' | snippet : [
                        'n' => $countResources,
                        'f1' => 'товар',
                        'f2' => 'товара',
                        'f5' => 'товаров'
                        ]}
                </span>
                </h1>

                {*
                    {if $resources != ''}
                        <label for="only-different-toggler" class="sect-comparison__custom-toggler custom-toggler">
                            <span class="custom-toggler__span">
                                <input class="custom-toggler__input" type="checkbox" id="only-different-toggler">
                                <span class="custom-toggler__checkmark"></span>
                            </span>
                            <span class="custom-toggler__text">Только отличающиеся</span>
                        </label>
                    {/if}
                *}
            </div>

            {if $resources != ''}
                <div class="swiper-buttons sect-pop__swiper-buttons sect-comparison__buttons" style="display: none;">
                    <div class="swiper-button-prev"></div>
                    <div class="swiper-button-next"></div>
                </div>
                <div class="swiper-container sect-comparison__slider">
                    <div class="swiper-wrapper sect-pop__slider">
                        {'!msProducts' | snippet : [
                        'parents' => 0,
                        'depth' => 50,
                        'limit' => 42,
                        'sortby' => '',
                        'sortdir' => '',
                        'resources' => $resources,
                        'tpl' => '@FILE sections/popular/comp-slide.tpl',
                        'where' => '{"context_key:=": "'~$_modx->resource.context_key~'"}'
                        ]}
                    </div>
                    <div class="swiper-scrollbar"></div>
                </div>
            {/if}

        </div>
    </section>

{/block}
