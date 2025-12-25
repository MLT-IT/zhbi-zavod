{extends "file:layouts/base.tpl"} 

{block 'page-content'}
    {include "file:sections/breadcrumbs/wrapper.tpl"}
    
    {set $all_certs = "@FILE modules/certificates-list/snippets/getAllCerts.php" | snippet : [
        'tvName' => 'certs'
    ]}

    <div class="certificates-page section-margin">
        <div class="container">
            <h1 class="section-title">{$_modx->resource.pagetitle}</h1>

            {include "file:modules/certificates-list/chunks/wrapper.tpl" certs=$all_certs}
        </div>
    </div>
{/block}