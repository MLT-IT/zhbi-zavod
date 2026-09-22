{extends "file:layouts/base.tpl"}

{block 'page-content'}
    {include "file:sections/breadcrumbs/wrapper.tpl"}

    <div class="section-margin">
        <div class="container">
            <h1 class="section-title">{$_modx->resource.pagetitle}</h1>
            <div class="page-content">
                {$_modx->resource.content}
            </div>
        </div>
    </div>

    {if $_modx->context.key === 'gbi-zavod78'}
    {include "file:sections/about-zbi-gallery/wrapper.tpl"
        title="Работаем на рынке ЖБИ с 2010 года"
        text="Производим широкий перечень продукции и постоянно увеличиваем ассортимент изделий для более полного удовлетворения потребительского спроса."
        slider_id="about-zbi-gallery"
        images=[
            "/assets/images/content/o-kompanii-1.jpg",
            "/assets/images/content/o-kompanii-2.jpg",
            "/assets/images/content/o-kompanii-3.webp",
            "/assets/images/content/o-kompanii-4.png",
            "/assets/images/content/o-kompanii-5.webp",
        ]
    }
    {/if}

    <div class="section-margin">
        {include "file:sections/products-used/wrapper.tpl"}
    </div>

    {if $_modx->context.key === 'gbi-zavod78'}
    {include "file:sections/about-team/wrapper.tpl"}
    {/if}

    <div class="section-margin">
        {include "file:sections/company-profit/wrapper.tpl"}
    </div>

    {if $_modx->context.key === 'gbi-zavod78'}
    {include "file:sections/about-zbi-gallery/wrapper.tpl"
        title="Наше оборудование"
        text="На заводах компании «Завод 78» установлено высокотехнологичное оборудование. Наши производственные мощности помогают нам создавать качественные ЖБИ — сваи, колодезные кольца, ригели, плиты перекрытия и многое другое."
        slider_id="equipment-gallery"
        images=[
            "/assets/images/content/oborudovanie-1.jpg",
            "/assets/images/content/oborudovanie-2.jpg",
            "/assets/images/content/oborudovanie-3.jpg",
            "/assets/images/content/oborudovanie-4.jpg",
            "/assets/images/content/oborudovanie-6.jpg",
            "/assets/images/content/oborudovanie-5.webp",
        ]
    }
    {/if}
{/block}
