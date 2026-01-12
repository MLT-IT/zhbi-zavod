{set $params = [
  'id' => $_modx->resource.id,
  'parent' => $_modx->resource.parent,
  'position' => 'category-product'
]}
{set $banner_data = "@FILE snippets/apiGetBanner.php" | snippet : $params}
{set $banner_groups = $banner_data['data']}

{if $banner_data['status'] && !empty($banner_groups)}
    {if count($banner_groups) > 1}
        {include "file:banners/category-product/banner-slider.tpl"}
    {else}
        {include "file:banners/category-product/banner-single.tpl"}
    {/if}
{else}
  <!-- {$banner_data['data'] | toJSON} -->
{/if}