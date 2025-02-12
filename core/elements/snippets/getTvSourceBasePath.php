<?php

$tvName = $tvName ?: 'mainImage';

$tv = $modx->getObject('modTemplateVar', ['name' => $tvName]);
if (!$tv) {
  return;
  // return 'TV not found';
}

$source = $tv->getSource($modx->resource->get('context_key'));
if (!$source) {
  return;
  // return 'No media source assigned';
}

$mediaSource = $modx->getObject('modMediaSource', $source->id);
if (!$mediaSource) {
  return;
  // return 'Media source not found';
}

$props = $mediaSource->getProperties();
// print_r($props);
$basePath = $props['basePath']['value'];

return $basePath;
