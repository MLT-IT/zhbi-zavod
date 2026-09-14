<div class="mlt-reviews__item prod-review">
  <div class="mlt-reviews__item-body prod-review">
    <div class="mlt-reviews__item-body-name">
      [[+user_name]] [[+rating_html]]
    </div>
    <div class="mlt-reviews__item-body-date">
      {set $createdon = '[[+createdon]]'}
      {'@FILE snippets/stringDateFormatted.php' | snippet : [
        'dateString' => $createdon
      ]}
    </div>
    <div class="mlt-reviews__item-body-content">[[+content]]</div>
  </div>
</div>
