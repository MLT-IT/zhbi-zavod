{set $default_stars = 5}
{set $active_stars = $active_stars ?: $default_stars}
{set $inactive_stars = $default_stars - $active_stars}
{set $range = range(1, $active_stars)}

<div class="rating-stars">
  {foreach range(1, $active_stars) as $star}
    <span class="rating-stars__item"></span>
  {/foreach}

  {foreach range(1, $inactive_stars) as $star}
    <span class="rating-stars__item inactive"></span>
  {/foreach}
</div>
