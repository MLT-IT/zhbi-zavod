<?php
$min    = 100;
$max    = 1000;

$input = $modx->getOption('input', $scriptProperties, null);

if (($input) && ($input != '')) { // used when used as output filter
  $nums = explode(',', $input);
  if ($nums[0] != '' && is_numeric($nums[0])) {
    $min = intval($nums[0]);
  }

  if ($nums[1] != '' && is_numeric($nums[1])) {
    $mac = intval($nums[1]);
  }
} else { // when past in as a snippet property
  $min   = $modx->getOption('begin', $scriptProperties, $min);
  $max   = $modx->getOption('end', $scriptProperties, $max);
}

return rand($min, $max);
