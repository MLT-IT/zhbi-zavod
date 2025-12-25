{extends "file:modules/modals/layots/base.tpl"} 

{block 'params'}
  {set $id='modal-review'}
  {set $title="Оставить отзыв"}
{/block}

{block 'body'}
  {'@FILE modules/mltreviews/snippets/mltReviewForm.php' | snippet : [
      'tpl' => '@FILE modules/mltreviews/chunks/tplForm.tpl'
  ]}
{/block}