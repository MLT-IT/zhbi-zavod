<div class="mlt-reviews__item{if $idx >= 6} hidden{/if}">
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
    <div class="mlt-reviews__item-body-content collapse-long-text">{$content}</div>
  </div>
</div>
