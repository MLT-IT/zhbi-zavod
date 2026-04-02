{set $params = [
  'id' => $_modx->resource.id,
  'parent' => $_modx->resource.parent,
  'position' => 'category-product'
]}
{set $banner_data = "@FILE snippets/apiGetBanner.php" | snippet : $params}
{set $banner_groups = $banner_data['data']}
{set $banner_submit_goal = ''}

{set $fallback_banner_groups = "@FILE snippets/getCategoryListingFallbackBanners.php" | snippet : [
  'id' => $_modx->resource.id
]}

{if !$banner_data['status'] || !is_array($banner_groups) || count($banner_groups) < 2}
  {set $banner_groups = $fallback_banner_groups}
  {set $banner_submit_goal = 'banner-listing_form_submit'}
{/if}

{if !empty($banner_groups)}
  {if count($banner_groups) > 1}
    {include "file:banners/category-product/banner-slider.tpl" banner_submit_goal=$banner_submit_goal}
  {else}
    {include "file:banners/category-product/banner-single.tpl" banner_submit_goal=$banner_submit_goal}
  {/if}
{else}
  <!-- {$banner_data['data'] | toJSON} -->
{/if}
