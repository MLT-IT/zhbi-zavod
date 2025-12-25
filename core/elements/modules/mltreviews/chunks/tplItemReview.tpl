{if $idx > 5}
  {set $classes = 'hidden'}
  {$_modx->setPlaceholder('review-show-more',true)}
{/if}

<div class="mlt-reviews__item {$classes}">
  <div class="mlt-reviews__item-header">
    <div
      class="mlt-reviews__item-logo"
      style="background-image: url('{$avatar ?: '/assets/components/mltreviews/avatars/avatar.svg'}');"
    ></div>
    <div class="mlt-reviews__item-info">
      <div class="mlt-reviews__item-name">
        {$user_name}
      </div>
      {$rating_html}
      <div class="mlt-reviews__item-date">
        {$createdon | date: "d.m.Y"}
      </div>
    </div>
  </div>
  <div class="mlt-reviews__item-body">
    <div class="mlt-reviews__item-body-content">{$content}</div>
  </div>

  {if $gallery}
  <div class="mlt-reviews__item-gallery">
    {foreach $gallery as $file}
      <a href="{$file}" data-fancybox="product-image">
        <img src="{$file}" width="50"/>
      </a>
    {/foreach}
  </div>
  {/if}
</div>
