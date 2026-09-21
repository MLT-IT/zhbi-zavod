<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Organization",
  "name": "{$_modx->getPlaceholder('context.descriptor')}",
  "url": "https://{$_modx->config.http_host}/",
  "logo": "https://{$_modx->config.http_host}{$_modx->getPlaceholder('images.logo-default')}",
  {if $_modx->getPlaceholder('contacts.phone')}
  "telephone": "{$_modx->getPlaceholder('contacts.phone')}",
  {/if}
  "address": {
    "@type": "PostalAddress",
    "streetAddress": "{$_modx->getPlaceholder('contacts.address')}",
    "addressCountry": "RU"
  }
}
</script>
