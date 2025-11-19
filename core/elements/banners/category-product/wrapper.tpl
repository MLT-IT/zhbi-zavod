{if ($_modx->resource.context_key in list ['krovelnyjstroymarket']) && ($_modx->resource.template in list [4,5,28,36])}
      {set $show_banner = true}
{elseif $_modx->resource.context_key in list ['gazosilikatstroy', 'web']}
      {set $show_banner = true}
{elseif ($_modx->resource.context_key in list ['plitnye']) && ($_modx->resource.template in list [4, 5, 36])}
      {set $show_banner = true}
{/if}

{if $_modx->context.key === 'web'}
  {set $parentsIds = '@FILE snippets/getParentTree.php' | snippet}
{/if}

{if !$.get.old_banner && $show_banner && (($idx == 1 && $total == 1) || ($idx == 2 && $total >= 2))}
        {set $params = [
          'resource_id' => $_modx->resource.id,
          'resource_parent' => $_modx->resource.parent,
          'banner_position' => 'category-product'
        ]}

        {if $parentsIds}
          {set $params['parents'] = $parentsIds}
        {/if}

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
{/if}