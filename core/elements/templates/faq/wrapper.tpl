{extends "file:layouts/default.layout.tpl"}

{block "page"}
    <main class="layout__main">
        {include "file:chunks/breadcrumbs/breadcrumbs.tpl"}
        <article class="faq section">
            <div class="faq__container">
                {include 'file:sections/faq/wrapper.tpl' ispage=1}
                {include "file:sections/payment/wrapper.tpl"}
            </div>
        </article>
    </main>
{/block}
